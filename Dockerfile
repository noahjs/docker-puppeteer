FROM ubuntu:latest

# Install latest chrome dev package.
# Note: this installs the necessary libs to make the bundled version of Chromium that Pupppeteer
# installs, work.
RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y git
RUN apt-get install -y software-properties-common python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs npm
RUN apt-get install -y xvfb

RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN apt-get install -y wget --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

# Install puppeteer so it's available in the container.
#RUN npm -g install puppeteer

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
