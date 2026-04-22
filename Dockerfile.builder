FROM docker:27-cli

# Устанавливает Git (нужен для клонирования)
RUN apk add --no-cache git

# Копирует  скрипт внутрь образа
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Запускает скрипт при старте контейнера
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
