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
sudo docker build -t myaddressapp:$BUILD_NUMBER .
sudo docker tag myaddressapp:$BUILD_NUMBER 8019014752/addressbookapp:$BUILD_NUMBER
touch my_password.txt
cat <<EOT>> my_password.txt
Saibaba123##
EOT
cat /var/lib/jenkins/workspace/DeployJob/Docker-jenkins/my_password.txt | sudo docker login --username 8019014752 --password-stdin
sudo docker push 8019014752/addressbookapp:$BUILD_NUMBER
