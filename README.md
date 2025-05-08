# Music-App
Simple Music App project with Springboot

![Alt text](https://github.com/edhiuchiha/music-app/blob/master/assets/spring-boot.png)

## Getting Started

```
git clone https://github.com/edhiuchiha/music-app.git
cd music-app
```

### Import your Project in your IDE (for example Eclipse)

Update your Project with right click on your Project > Maven > Update Project :

Make sure your java library installed with check it in lists of Maven Dependency

Your also can update your project with terminal : 
```
mvn clean install
```
It will auto downloading your dependencies, wait until complete and BUILD SUCCESS

### Running your springboot application

First make sure you have create the database with same name in application.properties in the project

Then you can run your Project rigth on your IDE with spring-boot:run in run configuration of your project

Or run build it with Maven that will be produce an file with .jar extenstion

So, you can run the .jar file in your terminal :

```
java -jar <file-path>
```


![Alt text](https://github.com/edhiuchiha/music-app/blob/master/assets/springboot-musicapp.png)

## Swagger Documentations

To show swagger API documentations, you can type this on web browser.

```
http://localhost:8081/swagger-ui.html
```

![Alt text](https://github.com/edhiuchiha/music-app/blob/master/assets/swagger.png)
## 
You can test to run the applications with that swagger documentations.

## Running the tests

You can run the automated test with JUnit 5

![Alt text](https://github.com/edhiuchiha/music-app/blob/master/assets/integration-test.png)
<!-- 
## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).  -->


