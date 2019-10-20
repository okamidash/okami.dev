FROM alpine
RUN apk add zsh fzf ncurses neofetch ruby
RUN gem install --no-rdoc --no-ri lolcat
COPY conf /root/config/zsh
COPY conf/zshrc /root/.zshrc
COPY entrypoint.sh /var/opt/entry.sh
COPY printout /root/printout
COPY contacts /root/contacts
RUN chmod +x /var/opt/entry.sh
ENTRYPOINT ["/var/opt/entry.sh"]

