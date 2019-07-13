drop database if exists quizDB;
create database quizDB;

use quizDB;

# CREATE TABLES
CREATE TABLE users (
    id int primary key auto_increment not null,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    username varchar(50) unique not null,
    email varchar(50) unique not null,
    password varchar(256) not null,
    isadmin bool not null,
    imageurl varchar(500) not null,
    achievements int not null
);

CREATE TABLE achievements(
    id int primary key auto_increment not null,
    userid int not null,
    firstach bool not null,
    secondach bool not null,
    thirdach bool not null,
    fourthach bool not null,
    fifthach bool not null,
    sixthach bool not null
);

CREATE TABLE chats
(
    id int primary key auto_increment not null,
    senderId int not null,
    receiverId int not null,
    txt int not null
);

CREATE TABLE challenges(
    id int primary key auto_increment not null,
    senderid int not null,
    receiverid int not null,
    quizid int not null
);

CREATE TABLE friendRequest(
    id int primary key auto_increment not null,
    senderid int not null,
    receiverid int not null
);

CREATE TABLE friends (
    id int primary key auto_increment not null,
    account_id int not null,
    friend_id int not null,
    FOREIGN KEY (friend_id) REFERENCES users(id),
    FOREIGN KEY (account_id) REFERENCES users(id)
);

CREATE TABLE category (
    id int primary key auto_increment not null,
    name varchar(100) not null
);

CREATE TABLE quizes (
    id int primary key auto_increment not null,
    creator_id int not null,
    title varchar(128) not null,
    description varchar(250) not null,
    image varchar(500) not null,
    category_id int not null,
    random bool not null,
    one_page bool not null,
    immediate_correction bool not null,
    practice_mode bool not null,
    count int default 0,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (creator_id) REFERENCES users(id)
);

CREATE TABLE questions (
    id int primary key auto_increment not null,
    quiz_id int not null,
    question_type varchar(256) not null,
    question varchar(256) not null,
    secondpart varchar(100),
    FOREIGN KEY (quiz_id) REFERENCES quizes(id)
);

CREATE TABLE answers (
     id int primary key auto_increment not null,
     question_id int not null ,
     answer varchar(100) not null,
     iscorrect bool not null,
     FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE user_history (
    id int primary key auto_increment not null,
    user_id int not null,
    quiz_id int not null,
    quiz_score double not null,
    quiz_date datetime not null,
    quiz_time int not null,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (quiz_id) REFERENCES quizes(id)
);

CREATE TABLE announcements (
    id int primary key auto_increment not null,
    announcer_id int not null,
    title varchar(100) not null,
    text varchar(250) not null,
    announce_date date not null,
    FOREIGN KEY (announcer_id) REFERENCES users(id)
);

# INSERT CATEGORIES
INSERT INTO category (name) VALUES ('Sport');
INSERT INTO category (name) VALUES ('Geography');
INSERT INTO category (name) VALUES ('Music');
INSERT INTO category (name) VALUES ('History');
INSERT INTO category (name) VALUES ('Gaming');
INSERT INTO category (name) VALUES ('Movies');
INSERT INTO category (name) VALUES ('Literature');
INSERT INTO category (name) VALUES ('Science');