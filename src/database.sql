drop database if exists quizDB;
create database quizDB;

use quizDatabase;

CREATE TABLE users (
    id int primary key auto_increment not null,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    username varchar(50) unique not null,
    email varchar(50) unique not null,
    password varchar(50) not null
);

CREATE TABLE admins (
    id int primary key auto_increment not null,
    username varchar(50) unique not null,
    email varchar(50) unique not null,
    pass varchar(50) not null
);

CREATE TABLE friends (
     account_id int not null,
     friend_id int not null,
     FOREIGN KEY (friend_id) REFERENCES users(id),
     FOREIGN KEY (account_id) REFERENCES users(id)
);

CREATE TABLE quizes (
    id int primary key auto_increment not null,
    creator_id int int not null,
    title varchar(128) not null,
    description varchar(250) not null,
    category_id int not null,
    random bool not null,
    one_page bool not null,
    immediate_correction bool not null,
    practice_mode bool not null,
    image varchar(200) not null,
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
     type varchar(50) not null,
     FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE user_history (
    id int primary key auto_increment not null,
    user_id int not null,
    quiz_id int not null,
    quiz_score double not null,
    quiz_date datetime not null,
    quiz_time time not null,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (quiz_id) REFERENCES quizes(id)
);

CREATE TABLE category (
    id int primary key auto_increment not null,
    name varchar(100) not null
);