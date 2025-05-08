@echo off
setlocal enabledelayedexpansion

echo === Music App Setup and Run Script ===
echo This script will help you set up the database and run the application.
echo.

:: Default values
set DEFAULT_DB_HOST=localhost
set DEFAULT_DB_PORT=3306
set DEFAULT_DB_NAME=db_musics
set DEFAULT_DB_USER=root
set DEFAULT_DB_PASS=ashu@2004
set DEFAULT_TIMEZONE=Asia/Jakarta

:: Prompt for database configuration
set /p DB_HOST=Enter database host [%DEFAULT_DB_HOST%]: 
if "!DB_HOST!"=="" set DB_HOST=%DEFAULT_DB_HOST%

set /p DB_PORT=Enter database port [%DEFAULT_DB_PORT%]: 
if "!DB_PORT!"=="" set DB_PORT=%DEFAULT_DB_PORT%

set /p DB_NAME=Enter database name [%DEFAULT_DB_NAME%]: 
if "!DB_NAME!"=="" set DB_NAME=%DEFAULT_DB_NAME%

set /p DB_USER=Enter database username [%DEFAULT_DB_USER%]: 
if "!DB_USER!"=="" set DB_USER=%DEFAULT_DB_USER%

set /p DB_PASS=Enter database password [%DEFAULT_DB_PASS%]: 
if "!DB_PASS!"=="" set DB_PASS=%DEFAULT_DB_PASS%

set /p TIMEZONE=Enter timezone [%DEFAULT_TIMEZONE%]: 
if "!TIMEZONE!"=="" set TIMEZONE=%DEFAULT_TIMEZONE%

:: Update application.properties
echo Updating application.properties...
(
echo server.port=8081
echo spring.resources.static-locations=file:/var/www/static,classpath:static
echo spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
echo spring.datasource.url=jdbc:mysql://%DB_HOST%:%DB_PORT%/%DB_NAME%?serverTimezone=%TIMEZONE%
echo spring.datasource.username=%DB_USER%
echo spring.datasource.password=%DB_PASS%
echo spring.jpa.hibernate.ddl-auto=update
echo.
echo spring.servlet.multipart.max-file-size = 5MB
echo spring.servlet.multipart.max-request-size = 5MB
echo.
echo app.upload.dir=./src/main/resources/static/images
) > src\main\resources\application.properties

echo Configuration updated successfully!

:: Create SQL script by direct output
echo Creating SQL setup script...

:: Create the file with database creation
echo -- Create the database > setup-database.sql
echo CREATE DATABASE IF NOT EXISTS %DB_NAME%; >> setup-database.sql
echo. >> setup-database.sql
echo -- Use the database >> setup-database.sql
echo USE %DB_NAME%; >> setup-database.sql
echo. >> setup-database.sql

:: Add singers table
echo -- Create singers table >> setup-database.sql
echo CREATE TABLE IF NOT EXISTS singers ( >> setup-database.sql
echo     id VARCHAR(255), >> setup-database.sql
echo     first_name VARCHAR(15), >> setup-database.sql
echo     last_name VARCHAR(30), >> setup-database.sql
echo     birth_date DATE, >> setup-database.sql
echo     gender VARCHAR(8), >> setup-database.sql
echo     created_at DATETIME DEFAULT CURRENT_TIMESTAMP, >> setup-database.sql
echo     updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, >> setup-database.sql
echo     PRIMARY KEY (id) >> setup-database.sql
echo ); >> setup-database.sql
echo. >> setup-database.sql

:: Add albums table
echo -- Create albums table >> setup-database.sql
echo CREATE TABLE IF NOT EXISTS albums ( >> setup-database.sql
echo     id VARCHAR(255), >> setup-database.sql
echo     name VARCHAR(100), >> setup-database.sql
echo     release_date DATE, >> setup-database.sql
echo     genre VARCHAR(50), >> setup-database.sql
echo     images VARCHAR(150), >> setup-database.sql
echo     singer VARCHAR(255), >> setup-database.sql
echo     created_at DATETIME DEFAULT CURRENT_TIMESTAMP, >> setup-database.sql
echo     updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, >> setup-database.sql
echo     PRIMARY KEY (id), >> setup-database.sql
echo     FOREIGN KEY (singer) REFERENCES singers(id) >> setup-database.sql
echo ); >> setup-database.sql
echo. >> setup-database.sql

:: Add songs table
echo -- Create songs table >> setup-database.sql
echo CREATE TABLE IF NOT EXISTS songs ( >> setup-database.sql
echo     id VARCHAR(255), >> setup-database.sql
echo     title VARCHAR(100), >> setup-database.sql
echo     content VARCHAR(1000), >> setup-database.sql
echo     singer VARCHAR(255), >> setup-database.sql
echo     album VARCHAR(255), >> setup-database.sql
echo     created_at DATETIME DEFAULT CURRENT_TIMESTAMP, >> setup-database.sql
echo     updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, >> setup-database.sql
echo     PRIMARY KEY (id), >> setup-database.sql
echo     FOREIGN KEY (singer) REFERENCES singers(id), >> setup-database.sql
echo     FOREIGN KEY (album) REFERENCES albums(id) >> setup-database.sql
echo ); >> setup-database.sql
echo. >> setup-database.sql

:: Add sample data - singers
echo -- Insert sample singers >> setup-database.sql
echo INSERT INTO singers (id, first_name, last_name, birth_date, gender) VALUES >> setup-database.sql
echo ('s1', 'Kevin', 'MacLeod', '1972-09-28', 'MALE'), >> setup-database.sql
echo ('s2', 'Scott', 'Holmes', '1985-04-12', 'MALE'), >> setup-database.sql
echo ('s3', 'Epidemic', 'Sound', '1990-06-20', 'MALE'), >> setup-database.sql
echo ('s4', 'Bensound', 'Audio', '1982-11-05', 'MALE'), >> setup-database.sql
echo ('s5', 'Joakim', 'Karud', '1988-03-18', 'MALE'); >> setup-database.sql
echo. >> setup-database.sql

:: Add sample data - albums
echo -- Insert sample albums >> setup-database.sql
echo INSERT INTO albums (id, name, release_date, genre, images, singer) VALUES >> setup-database.sql
echo ('a1', 'Creative Commons Volume 1', '2019-05-15', 'POP', 'album1.jpg', 's1'), >> setup-database.sql
echo ('a2', 'Acoustic Collection', '2020-02-22', 'JAZZ', 'album2.jpg', 's2'), >> setup-database.sql
echo ('a3', 'Electronic Vibes', '2021-08-10', 'POP', 'album3.jpg', 's3'), >> setup-database.sql
echo ('a4', 'Relaxing Instrumentals', '2018-12-05', 'JAZZ', 'album4.jpg', 's4'), >> setup-database.sql
echo ('a5', 'Upbeat Melodies', '2022-01-30', 'POP', 'album5.jpg', 's5'); >> setup-database.sql
echo. >> setup-database.sql

:: Add sample data - songs
echo -- Insert sample songs >> setup-database.sql
echo INSERT INTO songs (id, title, content, singer, album) VALUES >> setup-database.sql
echo ('song1', 'Monkeys Spinning Monkeys', 'Upbeat and playful instrumental track, perfect for lighthearted content. Available at incompetech.com under CC BY license.', 's1', 'a1'), >> setup-database.sql
echo ('song2', 'The Lounge', 'Smooth jazz instrumental with piano and soft percussion. Available at bensound.com under royalty-free license.', 's4', 'a4'), >> setup-database.sql
echo ('song3', 'Dreams', 'Electronic ambient music with peaceful melody. Created by Joakim Karud and available on YouTube Audio Library.', 's5', 'a5'), >> setup-database.sql
echo ('song4', 'Acoustic Breeze', 'Gentle acoustic guitar melody with soft background instruments. Free for personal projects via Bensound.', 's4', 'a4'), >> setup-database.sql
echo ('song5', 'Summer Walk', 'Uplifting folk track with acoustic guitar and whistling. Available at Scott Holmes Music under CC BY-NC license.', 's2', 'a2'), >> setup-database.sql
echo ('song6', 'Bright Future', 'Motivational electronic track with piano and synth elements. From Epidemic Sound''s royalty-free collection.', 's3', 'a3'), >> setup-database.sql
echo ('song7', 'Sneaky Adventure', 'Quirky and mysterious instrumental perfect for suspenseful moments. By Kevin MacLeod, available under CC BY license.', 's1', 'a1'), >> setup-database.sql
echo ('song8', 'Morning Stroll', 'Calm instrumental with natural sounds and gentle percussion. Created by Scott Holmes for free use in personal projects.', 's2', 'a2'), >> setup-database.sql
echo ('song9', 'Digital Dreams', 'Modern electronic track with synth waves and digital effects. From Epidemic Sound''s royalty-free collection.', 's3', 'a3'), >> setup-database.sql
echo ('song10', 'Jazz Coffee', 'Relaxing jazz instrumental perfect for background ambiance. Available at Bensound under royalty-free license.', 's4', 'a4'); >> setup-database.sql

echo SQL setup script created!

:: Create images directory if it doesn't exist
echo Creating images directory...
if not exist "src\main\resources\static\images" mkdir src\main\resources\static\images
echo Images directory created!

:: Run the database setup
echo Setting up the database...
where mysql >nul 2>&1
if %ERRORLEVEL% equ 0 (
    mysql -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% < setup-database.sql
    if %ERRORLEVEL% equ 0 (
        echo Database setup completed successfully!
    ) else (
        echo Error: Database setup failed. Please check your MySQL credentials and try again.
        goto :end
    )
) else (
    echo Error: MySQL client not found. Please install MySQL client and try again.
    echo You can manually run the setup-database.sql script in your MySQL client.
)

:: Define the application URL
set APP_URL=http://localhost:8081/swagger-ui.html

:: Build and run the application
echo Building and running the application...
where mvn >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Building the application with Maven...
    call mvn clean package -DskipTests
    if %ERRORLEVEL% equ 0 (
        echo Build successful!
        echo Starting the application...
        
        :: Start the Spring Boot application in the background
        start /B cmd /c mvn spring-boot:run
        
        :: Wait for the application to start up
        echo Waiting for application to start...
        timeout /t 10 /nobreak > nul
        
        :: Visual separator
        echo ===============================================
        echo.
        echo   APPLICATION SUCCESSFULLY STARTED!
        echo   Your Music App is now running!
        echo.
        echo   Access the application at:
        echo   %APP_URL%
        echo.
        echo   The browser will open automatically in 3 seconds...
        echo.
        echo ===============================================
        
        :: Wait 3 seconds then open browser
        timeout /t 3 /nobreak > nul
        
        :: Try to open the URL in the default browser
        start "" "%APP_URL%"
        
        :: If the above command fails for any reason, give alternative instructions
        if %ERRORLEVEL% neq 0 (
            echo.
            echo Could not open browser automatically.
            echo Please open your web browser and navigate to:
            echo %APP_URL%
            echo.
        )
        
    ) else (
        echo Error: Build failed. Please check the logs for more information.
        goto :end
    )
) else (
    echo Error: Maven not found. Please install Maven and try again.
    echo You can manually build and run the application with:
    echo mvn clean package -DskipTests
    echo mvn spring-boot:run
    echo.
    echo After starting the application, access it at:
    echo %APP_URL%
)

:end
echo Press any key to exit...
pause > nul 