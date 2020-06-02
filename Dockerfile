FROM tomcat
MAINTAINER kalagoni.omprakash@gmail.com
WORKDIR /usr/local/tomcat/webapps
COPY . .
EXPOSE 8000
CMD ["catalina.sh", "run"]
