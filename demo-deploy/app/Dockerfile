# 設定執行環境，這裡用官方的 Python 執行環境作為基本的 Docker 影像
FROM python:3.7.3-alpine

ENV TZ Asia/Taipei
ENV DOMAIN_NAME=hello.com

RUN apk --no-cache add nginx supervisor tzdata py3-jinja2 bash curl

RUN rm -f /etc/nginx/conf.d/*

# 設定工作目錄為 /app
WORKDIR /app

# 複製本機檔案到 Image 裡
COPY requirements.txt ./
COPY hello.py ./

COPY supervisord.conf /etc/supervisord.conf

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/hello.conf.j2 /tmp/hello.conf.j2
COPY nginx/nginx.py /tmp/nginx.py

# 安裝 requirements.txt 中所列的必要套件
RUN pip install -r requirements.txt

# 當 Container 啟動時，執行 hello.py
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]