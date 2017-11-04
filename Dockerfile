FROM ibmcom/swift-ubuntu:4.0

WORKDIR /app

RUN set -x
RUN apt-get update && \
    apt-get install -y libxml2-dev sqlite3 libsqlite3-dev

ADD . /app
RUN swift build
CMD ./.build/debug/PoppyBot
