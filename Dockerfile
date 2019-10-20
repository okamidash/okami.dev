FROM alpine
RUN apk add zsh fzf ncurses neofetch ruby
RUN gem install --no-rdoc --no-ri lolcat
RUN adduser -s /bin/zsh -D you
RUN rm /bin/dd
RUN rm /bin/cp
COPY conf /home/you/config/zsh
COPY conf/zshrc /home/you/.zshrc
COPY entrypoint.sh /var/opt/entry.sh
COPY printout /home/you/printout
COPY contacts /home/you/contacts
RUN chmod +x /var/opt/entry.sh
ENTRYPOINT ["/var/opt/entry.sh"]
USER you

