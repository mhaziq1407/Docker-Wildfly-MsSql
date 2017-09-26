# Docker-Wildfly-MsSql

- WildFly Application Server 10.1.0.Final
- Microsoft JDBC Driver for SQL Server 6.2.1.jre8

## JNDI - jta data source
- **java:jboss/datasources/MssqlDS**
### Persistence.xml 
`<jta-data-source>java:jboss/datasources/MssqlDS</jta-data-source>`

## Environment
- **MSSQL_HOST** _default:_ **localhost**
- **MSSQL_PORT** _default:_ **1433**
- **MSSQL_DATABASE** _default:_ **master**
- **MSSQL_USERNAME** _default:_ **sa**
- **MSSQL_PASSWORD** _default:_ **password**