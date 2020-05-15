FROM ubuntu

RUN apt-get update && apt-get install -y cron

COPY crondocker.sh /crondocker.sh

RUN chmod +x /crondocker.sh

ENTRYPOINT [ "./crondocker.sh" ]