FROM alpine
WORKDIR /app
RUN addgroup -S app && adduser -S -h /app -G app app
RUN apk add --no-cache nodejs git
USER app
