FROM golang:1.17-alpine AS build

#switch to our app directory
RUN mkdir -p /build
RUN apk add git
RUN git clone https://github.com/oxide-one/systemd.go /build
WORKDIR /build
#copy the source files
ENV CGO_ENABLED=0
#build the binary with debug information removed
RUN go mod download
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -a -o systemd.go cmd/systemd-go/systemd.go
RUN apk update && apk add upx
RUN upx /build/systemd.go


FROM alpine
COPY --from=build /build/systemd.go /bin/systemd.go
RUN apk add zsh fzf ncurses neofetch ruby sl fortune
RUN gem install --no-document lolcat
#RUN python3 -m pip install colored
#RUN git clone https://git.doubledash.org/okami/systemd.py.git /opt/systemd_py
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
