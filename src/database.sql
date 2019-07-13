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
    imageurl varchar(500) not null
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


INSERT INTO `quizes` (`id`, `creator_id`, `title`, `description`, `image`, `category_id`, `random`, `one_page`, `immediate_correction`, `practice_mode`, `count`) VALUES
(1, 1, '214323', 'qurduli', 'https://scontent.ftbs5-2.fna.fbcdn.net/v/t1.0-9/66364894_2831281796943019_8327997859605512192_n.jpg?_nc_cat=111&_nc_oc=AQnifiE2uRlL3pWKqsS6VlI6R0yRd-JEG0wSkMXqRl37ClfcV7Zk7l114t58C8dOXHU&_nc_ht=scontent.ftbs5-2.fna&oh=90e7ab04eb8fcbe9a89e9cf75406a23e&oe=5DC54DB3', 1, 0, 1, 0, 1, 0),
(2, 1, '3563636', 'tesloba', 'https://scontent.ftbs5-2.fna.fbcdn.net/v/t1.0-9/66364894_2831281796943019_8327997859605512192_n.jpg?_nc_cat=111&_nc_oc=AQnifiE2uRlL3pWKqsS6VlI6R0yRd-JEG0wSkMXqRl37ClfcV7Zk7l114t58C8dOXHU&_nc_ht=scontent.ftbs5-2.fna&oh=90e7ab04eb8fcbe9a89e9cf75406a23e&oe=5DC54DB3', 7, 0, 1, 0, 1, 0),
(3, 1, '987123243', 'qurduli', 'https://scontent.ftbs5-2.fna.fbcdn.net/v/t1.0-9/66364894_2831281796943019_8327997859605512192_n.jpg?_nc_cat=111&_nc_oc=AQnifiE2uRlL3pWKqsS6VlI6R0yRd-JEG0wSkMXqRl37ClfcV7Zk7l114t58C8dOXHU&_nc_ht=scontent.ftbs5-2.fna&oh=90e7ab04eb8fcbe9a89e9cf75406a23e&oe=5DC54DB3', 6, 0, 1, 0, 1, 0),
(4, 1, 'shakira', 'loca loca', 'https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/66438570_2385448201514095_1230994977731903488_n.jpg?_nc_cat=104&_nc_oc=AQmROy4pi0UIdaPwnrFHfgpAeJQ4zw2HX5ut5lx9nUwPiRw1qJ3rWJlfycN1xQpUmAU&_nc_ht=scontent.ftbs5-1.fna&oh=98a4635ea8993c3f25a89c6234ef1832&oe=5DAD6B79', 3, 0, 0, 0, 1, 0);

INSERT INTO `questions` (`id`, `quiz_id`, `question_type`, `question`, `secondpart`) VALUES
(1, 1, 'qr', 'gaxaria unda gadadges?', NULL),
(2, 2, 'fitb', 'yle yoveltvis', 'iqnebao'),
(3, 3, 'mc', 'papi romelia?', NULL),
(4, 4, 'mc', 'qurdebs ra?', NULL),
(5, 4, 'mc', 'bozebs ra?', NULL);

INSERT INTO `answers` (`id`, `question_id`, `answer`, `iscorrect`) VALUES
(1, 1, 'ara', 1),
(2, 2, 'yle', 1),
(3, 3, 'agi', 0),
(4, 3, 'me', 0),
(5, 3, 'gaikitxe', 1),
(6, 4, 'dedis tyvna', 0),
(7, 4, 'sicocxle', 1),
(8, 5, 'sicocxle', 0),
(9, 5, 'dedis tyvna', 1);

