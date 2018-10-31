FROM python:3-alpine

LABEL maintainer="gregory.chevalley+dockerhub@gmail.com"

RUN apk --no-cache add build-base \
                       freetype-dev \
                       fribidi-dev \
                       jpeg-dev \
                       harfbuzz-dev \
                       imagemagick \
                       libzmq \
                       lcms2-dev \
                       openjpeg-dev \
                       tcl-dev \
                       tesseract-ocr \
                       tiff-dev \
                       tk-dev \
                       zeromq-dev \
                       zlib-dev \
    && rm -rf /var/cache/apk/*

ENV LIBRARY_PATH=/lib:/usr/lib

RUN addgroup -S app && adduser app -S -G app

WORKDIR /home/app/

COPY requirements.txt .

RUN chown -R app /home/app

USER app

ENV PATH=$PATH:/home/app/.local/bin

RUN pip install --user -r requirements.txt

EXPOSE 8888

VOLUME /home/app

ENTRYPOINT ["/home/app/.local/bin/jupyter-notebook", "--ip=0.0.0.0", "--no-browser"]
