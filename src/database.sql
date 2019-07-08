create database quizDatabase;
use quizDatabase;

CREATE TABLE users (
	id int primary key auto_increment,
    firstName varchar(50),
    lastName varchar(50),
    nickName varchar(50) unique,
    email varchar(50) unicode,
    pass varchar(50),
	points int
);

CREATE TABLE admins (
	id int primary key auto_increment,
    nickName varchar(50) unique,
    email varchar(50) unicode,
    pass varchar(50) 
);

CREATE TABLE friends (
	firstPersonId int,
    secondPersonId int,
    primary key(firstPersonId, secondPersonId),
    FOREIGN KEY (firstPersonId) REFERENCES users(id),
    FOREIGN KEY (secondPersonId) REFERENCES users(id)
);

CREATE TABLE quizes (
	id int primary key auto_increment
);

CREATE TABLE questions (
	id int primary key auto_increment,
    quizId int,
    questiontype int,
	question varchar(256),
    secondpart varchar(100),
    FOREIGN KEY (id) REFERENCES quizes(id)
);

CREATE TABLE answers (
	questionId int,
    answer varchar(100),
    iscorrect boolean,
    FOREIGN KEY (questionId) REFERENCES questions(id)
);

CREATE TABLE userhistory(
	userId int,
    quizId int,
    quizscore double,
    quizdate datetime,
    quiztime time,
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (quizId) REFERENCES quizes(id)
);
