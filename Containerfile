FROM alpine:3.14

# Some code from:
# vaultwarden backup
# https://github.com/ttionya/vaultwarden-backup

LABEL "repository"="https://github.com/tetricky/lldap_back/" \
  "homepage"="https://github.com/tetricky/lldap_back/" \
  "maintainer"="tetricky"

COPY scripts/*.sh /app/

RUN chmod +x /app/*.sh \
  && apk add --no-cache bash curl sqlite unzip \
  && curl https://rclone.org/install.sh | bash \
  && apk del curl unzip

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["cron", "0 1 * * *"]
