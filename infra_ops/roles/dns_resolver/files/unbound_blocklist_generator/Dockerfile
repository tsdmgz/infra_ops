FROM docker.io/alpinelinux/unbound:latest
RUN apk add bash curl vim
COPY blocklist.sh /usr/local/bin/entrypoint.sh 
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT /usr/local/bin/entrypoint.sh
