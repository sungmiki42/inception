FROM debian:bullseye

# 필수 패키지 설치
RUN apt-get update && apt-get install -y nginx openssl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Nginx 설정 파일 복사 (커스터마이징 가능)
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/sungmiki.key \
    -out /etc/nginx/ssl/sungmiki.crt \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=sungmiki/CN=sungmiki/"

# 웹 파일 위치 설정
# COPY html/ /usr/share/nginx/html/

# 포트 노출
EXPOSE 443

# Nginx 실행
CMD ["nginx", "-g", "daemon off;"]