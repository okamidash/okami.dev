FROM golang:1.19-alpine AS build

#switch to our app directory
RUN apk add git
RUN git clone https://github.com/oxide-one/systemd.go /systemd.go
RUN git clone https://github.com/oxide-one/terminal-fallout /terminal-fallout
RUN mkdir /build
# Set environment variables
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
# Systemd.go
WORKDIR /systemd.go
RUN go mod download
RUN go build -ldflags="-w -s" -a -o /build/systemd.go cmd/systemd-go/systemd.go
# Terminal-fallout
WORKDIR /terminal-fallout
RUN go mod download
RUN go build -ldflags="-w -s" -a -o /build/fallout cmd/terminal/terminal.go
# Download Gopher
RUN apk update && apk add upx
RUN upx /build/systemd.go
RUN upx /build/fallout
# Compile Lolcat
RUN git clone https://github.com/jaseg/lolcat /lolcat
WORKDIR /lolcat
RUN apk add make build-base musl-dev
RUN make


FROM alpine
COPY --from=build /build/systemd.go /bin/systemd.go
COPY --from=build /build/fallout /bin/fallout
COPY --from=build /lolcat/lolcat /bin/lolcat
RUN apk add zsh fzf ncurses sl fortune
RUN adduser -s /bin/zsh -D you
RUN rm /bin/dd /bin/cp /usr/bin/md5sum /usr/bin/xargs
COPY entrypoint.sh /var/opt/entry.sh
RUN chmod +x /var/opt/entry.sh

ENTRYPOINT ["/var/opt/entry.sh"]
COPY conf /home/you/config/zsh
COPY conf/zshrc /home/you/.zshrc
COPY printout /home/you/printout
RUN sed -i -e 's/^root::/root:!:/' /etc/shadow
RUN apk del fuse
RUN chown -R you:you /home/you
USER you
