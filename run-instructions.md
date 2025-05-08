# Music App - Manual Setup Guide

The setup script detected that you're missing MySQL client and Maven in your PATH. Here's how to manually complete the setup and run the application:

## 1. Database Setup

You have two options for setting up the database:

### Option 1: Using MySQL Workbench (Recommended)

1. Open MySQL Workbench and connect with your credentials:
   - Host: localhost
   - Port: 3306  
   - Username: root
   - Password: ashu@2004

2. Create a new query tab and paste the contents of the `setup-database.sql` file
   - The file is located in your project directory
   - This will create the database, tables, and insert sample data

3. Execute the SQL script (lightning bolt icon or Ctrl+Shift+Enter)

### Option 2: Using phpMyAdmin

If you have XAMPP/WAMP/MAMP:

1. Start your Apache and MySQL services
2. Open phpMyAdmin (usually at http://localhost/phpmyadmin)
3. Login with your MySQL credentials
4. Go to the "Import" tab
5. Choose the `setup-database.sql` file and click "Go"

## 2. Application Setup

### Option 1: Using an IDE (Recommended)

1. **Open in IntelliJ IDEA or Eclipse**:
   - Import as a Maven project
   - Wait for dependencies to download
   - Run the main class: `src/main/java/com/enigmacamp/App.java`

### Option 2: Download Maven and Run Manually

1. **Download and Install Maven**:
   - Get it from: https://maven.apache.org/download.cgi
   - Install guide: https://maven.apache.org/install.html
   - Add Maven's bin directory to your PATH

2. **Run the Application**:
   ```
   mvn clean install
   mvn spring-boot:run
   ```

### Option 3: Use the Existing JAR File (Quickest)

If the project was already built and you have Java installed:

1. Open a command prompt in the project directory
2. Run:
   ```
   java -jar target/springboot-app-0.0.1-SNAPSHOT.jar
   ```
   (If the JAR file doesn't exist, you'll need to use option 1 or 2)

## 3. Access the Application

Once running, open your browser and go to:
```
http://localhost:8081/swagger-ui.html
```

## Checking MySQL Status

If you're not sure if MySQL is running:

1. Open Command Prompt and type:
   ```
   sc query mysql
   ```
   or
   ```
   tasklist | findstr mysql
   ```

2. If not running, start it:
   ```
   net start mysql
   ```

## Testing with Copyright-Free Music

For testing, use music from these sources:
- Incompetech (Kevin MacLeod): https://incompetech.com/music/
- Bensound: https://www.bensound.com/
- YouTube Audio Library: https://www.youtube.com/audiolibrary

## Need Help?

If you're having trouble setting up the environment:
1. Consider using Docker (if installed) - the original Docker Compose file is still valid
2. Use XAMPP/WAMP/MAMP for an easy MySQL setup 