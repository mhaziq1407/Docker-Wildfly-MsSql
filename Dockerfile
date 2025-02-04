FROM docker.io/jboss/wildfly:22.0.1.Final

# create user
RUN /opt/jboss/wildfly/bin/add-user.sh admin Dfs1234@ --silent
# enable management console



ENV MSSQL_JDBC_VERSION 7.4.1.jre8

RUN rm /opt/jboss/wildfly/standalone/configuration/standalone.xml

RUN rm /opt/jboss/wildfly/bin/standalone.conf

ADD standalone.xml /opt/jboss/wildfly/standalone/configuration/

ADD standalone.conf /opt/jboss/wildfly/bin/


RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/com/microsoft/sqlserver/jdbc/main && \
  cd /opt/jboss/wildfly/modules/system/layers/base/com/microsoft/sqlserver/jdbc/main && \
curl -L https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/$MSSQL_JDBC_VERSION/mssql-jdbc-$MSSQL_JDBC_VERSION.jar > mssql-jdbc.jar

ADD module.xml /opt/jboss/wildfly/modules/system/layers/base/com/microsoft/sqlserver/jdbc/main/


CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
#ADD changeProxy.xsl /opt/jboss/wildfly/
#RUN java -jar /usr/share/java/saxon.jar -s:/opt/jboss/wildfly/standalone/configuration/standalone.xml -xsl:/opt/jboss/wildfly/changeProxy.xsl -o:/opt/jboss/wildfly/standalone/configuration/standalone.xml; java -jar /usr/share/java/saxon.jar -s:/opt/jboss/wildfly/standalone/configuration/standalone-ha.xml -xsl:/opt/jboss/wildfly/changeProxy.xsl -o:/opt/jboss/wildfly/standalone/configuration/standalone-ha.xml; rm /opt/jboss/wildfly/changeProxy.xsl

