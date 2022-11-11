FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git wget curl build-essential \
    cmake libmagic-dev imagemagick \
    ffmpeg libimage-exiftool-perl nginx certbot unzip \
    libssl-dev automake autoconf libncurses5-dev \
    libncurses5 libwxbase3.0-0v5 libwxgtk3.0-gtk3-0v5 libsctp1 \
    locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN useradd -r -s /bin/false -m -d /var/lib/pleroma -U pleroma
RUN git clone -b develop https://gitlab.com/soapbox-pub/rebased /opt/pleroma
RUN chown -R pleroma:pleroma /opt/pleroma
RUN wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_24.3.3-1~debian~buster_amd64.deb -O /tmp/erlang.deb && \
    dpkg -i /tmp/erlang.deb && rm /tmp/erlang.deb
RUN wget https://packages.erlang-solutions.com/erlang/debian/pool/elixir_1.13.0-1~debian~buster_all.deb -O /tmp/elexir.deb && \
    dpkg -i /tmp/elexir.deb && rm /tmp/elexir.deb
WORKDIR /opt/pleroma
USER pleroma
RUN wget https://gitlab.com/soapbox-pub/soapbox/-/jobs/artifacts/develop/download?job=build-production -O /tmp/soapbox.zip && \
    unzip /tmp/soapbox.zip -d /opt/pleroma/instance && rm /tmp/soapbox.zip
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN MIX_ENV=prod mix compile

ENV MIX_ENV=prod
CMD mix ecto.migrate && mix phx.server
