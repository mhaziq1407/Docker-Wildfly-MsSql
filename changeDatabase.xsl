<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ds="urn:jboss:domain:15.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="//ds:subsystem/ds:datasources">
        <xsl:copy>
            <ds:datasource jndi-name="java:/jdbc/TMLI" enabled="true" use-java-context="true"
                           pool-name="jdbc/TMLI" use-ccm="true">
                <ds:connection-url>jdbc:sqlserver://${env.MSSQL_HOST:localhost}:${env.MSSQL_PORT:1433};database=${env.MSSQL_DATABASE:master}
                </ds:connection-url>
                <ds:driver>mssql</ds:driver>
                <ds:security>
                    <ds:user-name>${env.MSSQL_USERNAME:sa}</ds:user-name>
                    <ds:password>${env.MSSQL_PASSWORD:password}</ds:password>
                </ds:security>
                <ds:validation>
                    <!--<ds:valid-connection-checker class-name="org.jboss.jca.adapters.jdbc.extensions.mssql.MSSQLValidConnectionChecker"></ds:valid-connection-checker>-->
                    <ds:check-valid-connection-sql>SELECT 1</ds:check-valid-connection-sql>
                    <ds:background-validation>true</ds:background-validation>
                    <ds:background-validation-millis>60000</ds:background-validation-millis>
                </ds:validation>
                <ds:pool>
                    <!--<ds:min-pool-size>5</ds:min-pool-size>-->
                    <!--<ds:max-pool-size>50</ds:max-pool-size>-->
                    <!--<ds:prefill>false</ds:prefill>-->
                    <!--<ds:use-strict-min>false</ds:use-strict-min>-->
                    <!--<ds:flush-strategy>FailingConnectionOnly</ds:flush-strategy>-->
                    <ds:flush-strategy>IdleConnections</ds:flush-strategy>
                </ds:pool>
            </ds:datasource>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//ds:subsystem/ds:datasources/ds:drivers">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
            <ds:driver name="mssql" module="com.microsoft.sqlserver.jdbc">
                <ds:driver-class>com.microsoft.sqlserver.jdbc.SQLServerDriver</ds:driver-class>
            </ds:driver>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
