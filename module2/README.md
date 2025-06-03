# Spring app: petclinic 6.x

This instuction is to build the Spring Pet Clinic application to an ear file, install, and run the application on a managed Liberty server (MLS) in WebSphere Appication Server (WAS) Modernized Runtime Extension (MoRE).

- **Spring petclinic Github repository**: https://github.com/spring-projects/spring-petclinic
- **Prerequisites**: Git, Maven, Java 17

## Build the spring-petclinic war file

Visit the [Traditional Deployment document](https://docs.spring.io/spring-boot/how-to/deployment/traditional-deployment.html) for the detail of how Spring Boot supports traditional deployment.

Run the following:
- `git clone https://github.com/Emily-Jiang/tx-more-lab.git`
- `cd tx-more-lab/module2/build-war`
- `git clone https://github.com/spring-projects/spring-petclinic.git
- `cd spring-petclinic`
- update the `pom.xml` file by adding
  - the [`packaging`](https://github.com/Emily-Jiang/tx-more-lab/blob/main/module2/build-war/updated/pom.xml#L15) element after the `<version>3.4.0-SNAPSHOT</version>` line
  - and the [`exec.mainClass`](https://github.com/Emily-Jiang/tx-more-lab/blob/main/module2/build-war/updated/pom.xml#L41) property before the `</properties>` line as the following:
  - (or run the `cp updated/pom.xml spring-petclinic/pom.xml` command):

```
  ...
    <version>3.4.0-SNAPSHOT</version>
    <packaging>war</packaging>
  ...
    <properties>
       ...
       <exec.mainClass>org.springframework.samples.petclinic.PetClinicApplication</exec.mainClass>
    </properties>
```

- update the `PetClinicApplication.java` file by
  - adding 2 [`import`](https://github.com/Emily-Jiang/tx-more-lab/blob/main/module2/build-war/updated/PetClinicApplication.java#L21-L22) statements 
  - extending the `PetClinicApplication` class with [`SpringBootServletInitializer`](https://github.com/Emily-Jiang/tx-more-lab/blob/main/module2/build-war/updated/PetClinicApplication.java#L33)
  - and adding the [`configure()`](https://github.com/Emily-Jiang/tx-more-lab/blob/main/module2/build-war/updated/PetClinicApplication.java#L35-L38) statements  method as the following
  - (or run the `cp updated/PetClinicApplication.java spring-petclinic/src/main/java/org/springframework/samples/petclinic/PetClinicApplication.java` command):
 
```
...
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
...
public class PetClinicApplication extends SpringBootServletInitializer {

       @Override
       protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
               return application.sources(PetClinicApplication.class);
       }

...
```
- `cd spring-petclinic`
- `mvn clean install`

The `spring-petclinic-3.4.0-SNAPSHOT.war` file is created under the `target` directory.

## Build the spring-petclinic ear file

The `pom.xml` is provided at the `build-ear` directory.

- `cd tx-more-lab/module2/build-ear`
- `mvn clean package`

The `spring-petclinic-3.4.0-SNAPSHOT.ear` file is created under the `target` directory.

## Create a Managed Liberty server 

Assume that the MoRE enviroment is set.

- Go to admin console, e.g. https://localhost:9043/ibm/console 
- Go to **Servers** > **Server Types** > **WebSphere application servers**
- At the **New...** button, select **Managed Liberty server**
- At the Step 1, select a node to run the MLS
  - Type in a Server name: `demoServer1`
  - Click **Next** button
- At the Step 2, click **Next** button
- At the Step 3, click **Next** button
- At the Step 4, click **Finish** button
- Save and syncronize the changes

## Install the spring-petclinic ear file

Assume the spring-petclinic ear file is built at the previous step.

- Go to admin console, e.g. https://localhost:9043/ibm/console 
- Go to **Applications** > **New Application**
- Click the **New Enterprise Application** link
- Select Local file system option 
  - Click the **Browser...** button to select the `spring-petclinic-ear-3.4.0.ear` ear file that is located at the `tx-more-lab/module2/build-ear/target` directory 
- In **Target Runtime Environment** section, select _WebSphere Liberty_
- Click Next button 
- Select the **Fast Path** option, and click **Next** button 
- At the Step 1, click **Next** button 
- At the Step 2, make sure the `demoServer1` is selected. If not, select the `demoServer1` and check the Module, and click **Apply** button. Then, click **Next** button
- At the Step 4, enter `/spring-petclinic` as the the context root. Then, click **Next** button.
- At the **Summary** step, click **Finish** button 
- Save and syncronize the changes

##  Start the managed Liberty server
- Go to admin console, e.g. https://localhost:9043/ibm/console 
- Go to **Servers** > **Server Types** > **WebSphere application servers**
- Select `demoServer1`
- Click the **Start** button 
- Wait for a while, the server should be started when you see the green right arrow icon

## Check out the application

- Check out the messages.log by running the following command:
  - `cat AppServer/profiles/AppSrv01/managedLiberty/usr/servers/demoServer5/logs/messages.log | grep CWWKT0016I`
  - You will see an output similar to the following:
```
[2025-05-27, 11:47:29:181 EDT] 00000032 com.ibm.ws.http.internal.VirtualHostImpl
A CWWKT0016I: Web application available (default_host): http://9.46.93.127:9084/spring-petclinic/
```
- Visit the URL
