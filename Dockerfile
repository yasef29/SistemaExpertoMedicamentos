
FROM swipl:stable

WORKDIR /app

COPY . .

EXPOSE 10000

CMD ["swipl", "-s", "prolog/servidor.pl"]
