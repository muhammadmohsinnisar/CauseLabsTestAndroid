FROM maven:3-adoptopenjdk-16 AS apk-patcher

RUN apt-get update && apt-get install -y zip

WORKDIR /dex

ADD ./apk apk
ADD ./src src
ADD ./pom.xml pom.xml
ADD ./scripts/patch.sh patch.sh

RUN sh patch.sh

FROM androidsdk/android-30

COPY --from=apk-patcher /dex/apk/sauce-patched.apk apk/sauce-patched.apk
ADD ./scripts/sign.sh sign.sh

RUN sh sign.sh
RUN mkdir /dist
CMD ["cp", "apk/sauce-patched-signed.apk", "/dist"]