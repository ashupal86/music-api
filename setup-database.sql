-- Create the database 
CREATE DATABASE IF NOT EXISTS db_musics; 
 
-- Use the database 
USE db_musics; 
 
-- Create singers table 
CREATE TABLE IF NOT EXISTS singers ( 
    id VARCHAR(255), 
    first_name VARCHAR(15), 
    last_name VARCHAR(30), 
    birth_date DATE, 
    gender VARCHAR(8), 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    PRIMARY KEY (id) 
); 
 
-- Create albums table 
CREATE TABLE IF NOT EXISTS albums ( 
    id VARCHAR(255), 
    name VARCHAR(100), 
    release_date DATE, 
    genre VARCHAR(50), 
    images VARCHAR(150), 
    singer VARCHAR(255), 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    PRIMARY KEY (id), 
    FOREIGN KEY (singer) REFERENCES singers(id) 
); 
 
-- Create songs table 
CREATE TABLE IF NOT EXISTS songs ( 
    id VARCHAR(255), 
    title VARCHAR(100), 
    content VARCHAR(1000), 
    singer VARCHAR(255), 
    album VARCHAR(255), 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    PRIMARY KEY (id), 
    FOREIGN KEY (singer) REFERENCES singers(id), 
    FOREIGN KEY (album) REFERENCES albums(id) 
); 
 
-- Insert sample singers 
INSERT INTO singers (id, first_name, last_name, birth_date, gender) VALUES 
('s1', 'Kevin', 'MacLeod', '1972-09-28', 'MALE'), 
('s2', 'Scott', 'Holmes', '1985-04-12', 'MALE'), 
('s3', 'Epidemic', 'Sound', '1990-06-20', 'MALE'), 
('s4', 'Bensound', 'Audio', '1982-11-05', 'MALE'), 
('s5', 'Joakim', 'Karud', '1988-03-18', 'MALE'); 
 
-- Insert sample albums 
INSERT INTO albums (id, name, release_date, genre, images, singer) VALUES 
('a1', 'Creative Commons Volume 1', '2019-05-15', 'POP', 'album1.jpg', 's1'), 
('a2', 'Acoustic Collection', '2020-02-22', 'JAZZ', 'album2.jpg', 's2'), 
('a3', 'Electronic Vibes', '2021-08-10', 'POP', 'album3.jpg', 's3'), 
('a4', 'Relaxing Instrumentals', '2018-12-05', 'JAZZ', 'album4.jpg', 's4'), 
('a5', 'Upbeat Melodies', '2022-01-30', 'POP', 'album5.jpg', 's5'); 
 
-- Insert sample songs 
INSERT INTO songs (id, title, content, singer, album) VALUES 
('song1', 'Monkeys Spinning Monkeys', 'Upbeat and playful instrumental track, perfect for lighthearted content. Available at incompetech.com under CC BY license.', 's1', 'a1'), 
('song2', 'The Lounge', 'Smooth jazz instrumental with piano and soft percussion. Available at bensound.com under royalty-free license.', 's4', 'a4'), 
('song3', 'Dreams', 'Electronic ambient music with peaceful melody. Created by Joakim Karud and available on YouTube Audio Library.', 's5', 'a5'), 
('song4', 'Acoustic Breeze', 'Gentle acoustic guitar melody with soft background instruments. Free for personal projects via Bensound.', 's4', 'a4'), 
('song5', 'Summer Walk', 'Uplifting folk track with acoustic guitar and whistling. Available at Scott Holmes Music under CC BY-NC license.', 's2', 'a2'), 
('song6', 'Bright Future', 'Motivational electronic track with piano and synth elements. From Epidemic Sound''s royalty-free collection.', 's3', 'a3'), 
('song7', 'Sneaky Adventure', 'Quirky and mysterious instrumental perfect for suspenseful moments. By Kevin MacLeod, available under CC BY license.', 's1', 'a1'), 
('song8', 'Morning Stroll', 'Calm instrumental with natural sounds and gentle percussion. Created by Scott Holmes for free use in personal projects.', 's2', 'a2'), 
('song9', 'Digital Dreams', 'Modern electronic track with synth waves and digital effects. From Epidemic Sound''s royalty-free collection.', 's3', 'a3'), 
('song10', 'Jazz Coffee', 'Relaxing jazz instrumental perfect for background ambiance. Available at Bensound under royalty-free license.', 's4', 'a4'); 
