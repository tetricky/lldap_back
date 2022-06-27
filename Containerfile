FROM alpine:3.16


# Code structure and logic largely from ttionya/vaultwarden-backup
# https://github.com/ttionya/vaultwarden-backup

# Written as simple backup container to dump lldap database
# for nitnelave/lldap (but may be used for other sqlite databases)
# https://github.com/nitnelave/lldap

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
