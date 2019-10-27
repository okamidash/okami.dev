FROM alpine
RUN apk add zsh fzf ncurses neofetch ruby sl fortune python3 git
RUN gem install --no-rdoc --no-ri lolcat
RUN python3 -m pip install colored
RUN git clone https://git.doubledash.org/okami/systemd.py.git /opt/systemd_py
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
