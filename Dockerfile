rm -rf Docker-jenkins
mkdir Docker-jenkins
cd Docker-jenkins
cp /var/lib/jenkins/workspace/PackageJob/target/addressbook.war .
touch Dockerfile
cat <<EOT>> Dockerfile
FROM tomcat
MAINTAINER kalagoni.omprakash@gmail.com
COPY addressbook.war /usr/local/tomcat/webapps
CMD "catalina.sh" "run"
EXPOSE 8080
EOT
sudo systemctl start docker
sudo docker build -t myimage:$BUILD_NUMBER .
sudo docker run -itd -p 8006:8080 myimage:$BUILD_NUMBER
