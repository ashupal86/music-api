#!/bin/bash

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Music App Setup and Run Script ===${NC}"
echo -e "${YELLOW}This script will help you set up the database and run the application.${NC}"
echo ""

# Default values
DEFAULT_DB_HOST="localhost"
DEFAULT_DB_PORT="3306"
DEFAULT_DB_NAME="db_musics"
DEFAULT_DB_USER="root"
DEFAULT_DB_PASS="ashu@2004"
DEFAULT_TIMEZONE="Asia/Jakarta"

# Prompt for database configuration
read -p "Enter database host [$DEFAULT_DB_HOST]: " DB_HOST
DB_HOST=${DB_HOST:-$DEFAULT_DB_HOST}

read -p "Enter database port [$DEFAULT_DB_PORT]: " DB_PORT
DB_PORT=${DB_PORT:-$DEFAULT_DB_PORT}

read -p "Enter database name [$DEFAULT_DB_NAME]: " DB_NAME
DB_NAME=${DB_NAME:-$DEFAULT_DB_NAME}

read -p "Enter database username [$DEFAULT_DB_USER]: " DB_USER
DB_USER=${DB_USER:-$DEFAULT_DB_USER}

read -p "Enter database password [$DEFAULT_DB_PASS]: " DB_PASS
DB_PASS=${DB_PASS:-$DEFAULT_DB_PASS}

read -p "Enter timezone [$DEFAULT_TIMEZONE]: " TIMEZONE
TIMEZONE=${TIMEZONE:-$DEFAULT_TIMEZONE}

# Update application.properties
echo -e "${YELLOW}Updating application.properties...${NC}"
cat > src/main/resources/application.properties << EOF
server.port=8081
spring.resources.static-locations=file:/var/www/static,classpath:static
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://$DB_HOST:$DB_PORT/$DB_NAME?serverTimezone=$TIMEZONE
spring.datasource.username=$DB_USER
spring.datasource.password=$DB_PASS
spring.jpa.hibernate.ddl-auto=update

spring.servlet.multipart.max-file-size = 5MB
spring.servlet.multipart.max-request-size = 5MB

app.upload.dir=./src/main/resources/static/images
EOF

echo -e "${GREEN}Configuration updated successfully!${NC}"

# Create SQL script for database setup
echo -e "${YELLOW}Creating SQL setup script...${NC}"
cat > setup-database.sql << EOF
-- Create the database
CREATE DATABASE IF NOT EXISTS $DB_NAME;

-- Use the database
USE $DB_NAME;

-- Create 'singers' table
CREATE TABLE IF NOT EXISTS singers (
    id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(8) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_gender CHECK (gender IN ('MALE', 'FEMALE'))
);

-- Create 'albums' table
CREATE TABLE IF NOT EXISTS albums (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    release_date DATE NOT NULL,
    genre VARCHAR(50) NOT NULL,
    images VARCHAR(150),
    singer VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (singer) REFERENCES singers(id),
    CONSTRAINT chk_genre CHECK (genre IN ('POP', 'DANGDUT', 'JAZZ', 'KERONCONG', 'SHOLAWAT', 'CAMPURSARI'))
);

-- Create 'songs' table
CREATE TABLE IF NOT EXISTS songs (
    id VARCHAR(255) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content VARCHAR(1000) NOT NULL,
    singer VARCHAR(255) NOT NULL,
    album VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (singer) REFERENCES singers(id),
    FOREIGN KEY (album) REFERENCES albums(id)
);

-- Insert sample singers
INSERT IGNORE INTO singers (id, first_name, last_name, birth_date, gender) VALUES
('s1', 'Kevin', 'MacLeod', '1972-09-28', 'MALE'),
('s2', 'Scott', 'Holmes', '1985-04-12', 'MALE'),
('s3', 'Epidemic', 'Sound', '1990-06-20', 'MALE'),
('s4', 'Bensound', 'Audio', '1982-11-05', 'MALE'),
('s5', 'Joakim', 'Karud', '1988-03-18', 'MALE');

-- Insert sample albums
INSERT IGNORE INTO albums (id, name, release_date, genre, images, singer) VALUES
('a1', 'Creative Commons Volume 1', '2019-05-15', 'POP', 'album1.jpg', 's1'),
('a2', 'Acoustic Collection', '2020-02-22', 'JAZZ', 'album2.jpg', 's2'),
('a3', 'Electronic Vibes', '2021-08-10', 'POP', 'album3.jpg', 's3'),
('a4', 'Relaxing Instrumentals', '2018-12-05', 'JAZZ', 'album4.jpg', 's4'),
('a5', 'Upbeat Melodies', '2022-01-30', 'POP', 'album5.jpg', 's5');

-- Insert sample songs (with copyright-free music content references)
INSERT IGNORE INTO songs (id, title, content, singer, album) VALUES
('song1', 'Monkeys Spinning Monkeys', 'Upbeat and playful instrumental track, perfect for lighthearted content. Available at incompetech.com under CC BY license.', 's1', 'a1'),
('song2', 'The Lounge', 'Smooth jazz instrumental with piano and soft percussion. Available at bensound.com under royalty-free license.', 's4', 'a4'),
('song3', 'Dreams', 'Electronic ambient music with peaceful melody. Created by Joakim Karud and available on YouTube Audio Library.', 's5', 'a5'),
('song4', 'Acoustic Breeze', 'Gentle acoustic guitar melody with soft background instruments. Free for personal projects via Bensound.', 's4', 'a4'),
('song5', 'Summer Walk', 'Uplifting folk track with acoustic guitar and whistling. Available at Scott Holmes Music under CC BY-NC license.', 's2', 'a2'),
('song6', 'Bright Future', 'Motivational electronic track with piano and synth elements. From Epidemic Sound\'s royalty-free collection.', 's3', 'a3'),
('song7', 'Sneaky Adventure', 'Quirky and mysterious instrumental perfect for suspenseful moments. By Kevin MacLeod, available under CC BY license.', 's1', 'a1'),
('song8', 'Morning Stroll', 'Calm instrumental with natural sounds and gentle percussion. Created by Scott Holmes for free use in personal projects.', 's2', 'a2'),
('song9', 'Digital Dreams', 'Modern electronic track with synth waves and digital effects. From Epidemic Sound\'s royalty-free collection.', 's3', 'a3'),
('song10', 'Jazz Coffee', 'Relaxing jazz instrumental perfect for background ambiance. Available at Bensound under royalty-free license.', 's4', 'a4');
EOF

echo -e "${GREEN}SQL setup script created!${NC}"

# Create images directory if it doesn't exist
echo -e "${YELLOW}Creating images directory...${NC}"
mkdir -p src/main/resources/static/images
echo -e "${GREEN}Images directory created!${NC}"

# Run the database setup
echo -e "${YELLOW}Setting up the database...${NC}"
if command -v mysql &> /dev/null; then
    mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS < setup-database.sql
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Database setup completed successfully!${NC}"
    else
        echo -e "${RED}Error: Database setup failed. Please check your MySQL credentials and try again.${NC}"
        exit 1
    fi
else
    echo -e "${RED}Error: MySQL client not found. Please install MySQL client and try again.${NC}"
    echo -e "${YELLOW}You can manually run the setup-database.sql script in your MySQL client.${NC}"
fi

# Build and run the application
echo -e "${YELLOW}Building and running the application...${NC}"
if command -v mvn &> /dev/null; then
    echo -e "${BLUE}Building the application with Maven...${NC}"
    mvn clean package -DskipTests
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Build successful!${NC}"
        echo -e "${BLUE}Starting the application...${NC}"
        mvn spring-boot:run &
        echo -e "${GREEN}Application started successfully!${NC}"
        echo -e "${GREEN}You can access the application at: http://localhost:8081/swagger-ui.html${NC}"
    else
        echo -e "${RED}Error: Build failed. Please check the logs for more information.${NC}"
        exit 1
    fi
else
    echo -e "${RED}Error: Maven not found. Please install Maven and try again.${NC}"
    echo -e "${YELLOW}You can manually build and run the application with:${NC}"
    echo -e "${BLUE}mvn clean package -DskipTests${NC}"
    echo -e "${BLUE}mvn spring-boot:run${NC}"
    exit 1
fi 