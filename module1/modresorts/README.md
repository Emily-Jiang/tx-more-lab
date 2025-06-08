# ModResorts Demo Application

## About
This version of the application has been migrated from IBM WebSphere Application Server 9. It contains all the changes needed for the application to run on Liberty. The application has been upgraded from Java 8 to Java 17, and to use technologies from Jakarta EE 10 Core Profile.

## Building and Running
Application can be built with standard Maven lifecycle commands:

```
mvn clean package
```

The Liberty maven plugin is added to the pom.xml to facilitate running of the application in your development environment.

## Dependencies
Application currently has dependencies on a DB2 database as described in the server.xml.

## Alternative version running on tWAS
The alternative version(Java 8 and Java EE 7) of this app runs on tWAS. The source code is under [here](https://github.com/IBM/sample-app-mod).
