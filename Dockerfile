FROM tomcat:8.5.82

WORKDIR /opt/tomcat

User root

RUN mv /opt/tomcat/webapps /opt/tomcat/webapps2

RUN mv /opt/tomcat/webapps.dist/ webapps

ADD ./target/dptweb-1.0.war /opt/tomcat/webapps/

COPY tomcat-users.xml /opt/tomcat/conf/

COPY context.xml /opt/tomcat/webapps/manager/META-INF/

COPY context.xml /opt/tomcat/webapps/host-manager/META-INF/

EXPOSE 8080

CMD ["catalina.sh", "run"]
