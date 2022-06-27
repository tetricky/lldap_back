FROM alpine:3.16

# Simple Backup container to dump lldap database

LABEL "repository"="https://github.com/tetricky/lldap_back/" \
  "homepage"="https://github.com/tetricky/lldap_back/" \
  "maintainer"="tetricky"

COPY scripts/*.sh /app/

RUN chmod +x /app/*.sh \
  && apk add --no-cache bash curl sqlite p7zip heirloom-mailx tzdata unzip go-sendxmpp \
  && curl https://rclone.org/install.sh | bash \
  && apk del curl unzip && rm -rf /var/cache/apk/*

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["cron", "0 1 * * *"]
