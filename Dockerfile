FROM ubuntu:latest
MAINTAINER Sven Koschnicke <sven@koschnicke.de>

# workaround problem with upstart not running
# see https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

# update system
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update
#RUN apt-get -y upgrade

# install required packages
RUN apt-get -y install ruby1.9.1 ruby1.9.1-dev \
  rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 \
  build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev \
  git libxslt-dev libxml2-dev libpq-dev

RUN update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
         --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
                        /usr/share/man/man1/ruby1.9.1.1.gz \
        --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
        --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
        --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1

RUN gem install rails
RUN gem install bundler

EXPOSE 3000
