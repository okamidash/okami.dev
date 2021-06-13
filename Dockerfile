# start a golang base image, version 1.8
FROM golang:1.16-alpine AS build

RUN apk add git upx
RUN git clone https://github.com/oxide-one/systemd.go /build
#switch to our app directory
WORKDIR /build
ENV CGO_ENABLED=0
ENV GO111MODULE=off
#build the binary with debug information removed
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -a -o systemd.go
RUN go get github.com/kris-nova/lolgopher
RUN 
RUN cp $GOPATH/bin/lolgopher /build/lolgopher
RUN upx /build/systemd.go

FROM alpine
RUN apk update
COPY --from=build /build/systemd.go /bin/systemd.go
COPY --from=build /build/lolgopher  /bin/lolgopher
RUN apk add zsh fzf ncurses neofetch ruby sl fortune git
RUN gem install --no-document lolcat
RUN adduser -s /bin/zsh -D you
RUN rm /bin/dd /bin/cp /usr/bin/md5sum /usr/bin/xargs
COPY entrypoint.sh /var/opt/entry.sh
RUN chmod +x /var/opt/entry.sh

COPY conf /home/you/config/zsh
COPY conf/zshrc /home/you/.zshrc
COPY printout /home/you/printout

RUN sed -i -e 's/^root::/root:!:/' /etc/shadow

RUN apk del fuse

RUN chown -R you:you /home/you

USER you
ENTRYPOINT ["/var/opt/entry.sh"]
