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

CREATE TABLE friends (
                         id int primary key auto_increment not null,
                         account_id int not null,
                         friend_id int not null,
                         FOREIGN KEY (friend_id) REFERENCES users(id),
                         FOREIGN KEY (account_id) REFERENCES users(id)
);

CREATE TABLE friendRequest(
                              id int primary key auto_increment not null,
                              senderid int not null,
                              receiverid int not null,
                              FOREIGN KEY (senderid) REFERENCES users(id),
                              FOREIGN KEY (receiverid) REFERENCES users(id)
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
                        creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
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

CREATE TABLE achievements(
                             id int primary key auto_increment not null,
                             userid int not null,
                             name varchar (100) not null,
                             achievedate DATETIME DEFAULT CURRENT_TIMESTAMP,
                             FOREIGN KEY (userid) REFERENCES users(id)
);

CREATE TABLE user_history (
                              id int primary key auto_increment not null,
                              user_id int not null,
                              quiz_id int not null,
                              quiz_score double default 0,
                              quiz_start datetime not null,
                              quiz_end datetime,
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

CREATE TABLE challenges(
                           id int primary key auto_increment not null,
                           senderid int not null,
                           receiverid int not null,
                           quizid int not null
);

CREATE TABLE chats (
                       id int primary key auto_increment not null,
                       senderId int not null,
                       receiverId int not null,
                       txt mediumtext not null,
                       FOREIGN KEY (senderId) REFERENCES users(id),
                       FOREIGN KEY (receiverId) REFERENCES users(id)
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

INSERT INTO users (firstname, lastname, username, email, password, isadmin, imageurl) VALUES ('Administrator', 'QuizCake', 'admin', 'admin@quizcake.com', '123456', true, 'img/default-avatar.png');



INSERT INTO `quizes` (`id`, `creator_id`, `title`, `description`, `image`, `category_id`, `random`, `one_page`, `immediate_correction`, `practice_mode`, `creation_date`, `count`) VALUES
(5, 1, 'Science Geek', 'science', 'https://cdn.worldsciencefestival.com/wp-content/uploads/2017/03/PERCEPTIONS_OF_SCIENCE_800x494.jpg', 8, 1, 1, 1, 0, '2019-07-15 03:22:15', 0),
(6, 1, 'Father of Herodotus', 'Hist2', 'https://obuasitoday.com/wp-content/uploads/2016/09/1123676.jpg', 4, 0, 1, 1, 1, '2019-07-15 04:51:31', 0),
(7, 1, 'Beat \'em all', 'better than granfather', 'https://ec.europa.eu/sport/sites/sport/files/shutterstock_304691351.jpg', 1, 1, 1, 1, 1, '2019-07-15 05:01:39', 0),
(8, 1, 'Make hear not fear', 'Music sounds better with you', 'http://pamis.org.uk/site/uploads/musicworkshop-image.jpg', 3, 1, 1, 1, 1, '2019-07-15 05:10:13', 0),
(9, 1, 'Read and Write', 'In the chaos of harmony', 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg', 7, 1, 1, 1, 1, '2019-07-15 05:18:41', 0),
(10, 1, 'Visit Georgia', 'Visit Georgia', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/1200px-Flag_of_Georgia.svg.png', 2, 1, 1, 1, 1, '2019-07-15 05:36:10', 0);


INSERT INTO `questions` (`id`, `quiz_id`, `question_type`, `question`, `secondpart`) VALUES
(6, 5, 'mc', 'Who invented Radar?', NULL),
(7, 5, 'mc', 'Where are mesons found?', NULL),
(8, 5, 'mc', 'Which of the following parts of the sunlight makes the solar cooker hot?', NULL),
(9, 5, 'mc', 'The mass of a star is two times the mass of the Sun. How will it come to an end?', NULL),
(10, 5, 'mc', 'What happens when a chemical bond is formed?', NULL),
(11, 5, 'mc', 'The color of the eye depends upon the pigment present inside?', NULL),
(12, 5, 'mc', 'The disease that is caused by the virus is?', NULL),
(13, 5, 'mc', 'What year did Albert Einstein win tthe Nobel Prize?', NULL),
(14, 5, 'mc', 'Which physicist is the writer of the book \'A Brief History of Time\'?', NULL),
(15, 5, 'mc', 'Who is known as the \'father of quantum theory\'?', NULL),
(16, 6, 'qr', 'The European renaissance started from which country?', NULL),
(17, 6, 'fitb', 'was the author of United States Declaration of Independence', 'Thomas Jefferson was the author of United States Declaration of Independence'),
(18, 6, 'mc', 'In which year, Alexander the Great become the king of Macedonia?', NULL),
(19, 6, 'prq', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Otto_von_Bismarck.JPG/190px-Otto_von_Bismarck.JPG', NULL),
(20, 6, 'mc', 'Who was the President of America during American Civil War?', NULL),
(21, 7, 'mc', 'Which country?s first ever home football international was played at the Racecourse Ground in 1877?', NULL),
(22, 7, 'mc', 'Frankie Fredericks represented which African country in athletics?', NULL),
(23, 7, 'mc', 'In inches, how big is the diameter of a basketball hoop?', NULL),
(24, 7, 'mc', 'What sport used the term ?home run? long before baseball?', NULL),
(25, 7, 'mc', 'What number lies between 5 and 9 on a British dart board?', NULL),
(26, 8, 'mc', 'Who sings SexyBack?', NULL),
(27, 8, 'mc', 'Which mathematical symbol is not the name of an Ed Sheeran album?', NULL),
(28, 8, 'mc', 'Complete the Mark Ronson song title: Uptown...', NULL),
(29, 8, 'mc', 'Which Beatle performed a James Bond theme song?', NULL),
(30, 8, 'mc', 'In which video does Michael Jackson play a zombie?', NULL),
(31, 9, 'mc', 'Who was the author of the famous storybook \'Alice\'s Adventures in Wonderland\'?', NULL),
(32, 9, 'mc', 'Who wrote the famous 1855 poem \'The Charge of the Light Brigade\'?', NULL),
(33, 9, 'mc', 'Who wrote \'Where ignorance is bliss, it is folly to be wise\'?', NULL),
(34, 9, 'mc', 'Name the book which opens with the line \'All children, except one grew up\'?', NULL),
(35, 9, 'mc', 'Which is the first Harry Potter book?', NULL),
(36, 10, 'mc', 'Magyars are the people of which country?', NULL),
(37, 10, 'mc', 'Fuck?', NULL),
(38, 10, 'mc', 'Pilbara is a region in which Australian state?', NULL),
(39, 10, 'mc', 'What is the capital of Armenia?', NULL),
(40, 10, 'mc', 'The Chukchi Sea is north of which sea?', NULL);



INSERT INTO `answers` (`id`, `question_id`, `answer`, `iscorrect`) VALUES
(10, 6, ' P. T. Farnsworth', 0),
(11, 6, 'J. H. Van Tassel', 0),
(12, 6, 'Wilhelm K.Roentgen', 0),
(13, 6, 'A. H. Taylor & Leo C. Young', 1),
(14, 7, ' X-rays', 0),
(15, 7, ' Gamma rays', 0),
(16, 7, 'Laser beams', 0),
(17, 7, 'Cosmic rays', 1),
(18, 8, 'Red light', 0),
(19, 8, 'Ultraviolet', 0),
(20, 8, 'Cosmic rays', 0),
(21, 8, 'Infrared', 1),
(22, 9, 'Black Hole', 0),
(23, 9, 'White Dwaft', 0),
(24, 9, 'Red Giant', 0),
(25, 9, 'Neutron Star', 1),
(26, 10, 'Energy is always released', 0),
(27, 10, 'More energy is released than is absorbed', 0),
(28, 10, 'Energy neither released nor absorbed', 0),
(29, 10, 'Energy is always absorbed', 1),
(30, 11, 'Cornea', 0),
(31, 11, 'Rods', 0),
(32, 11, 'Cones', 0),
(33, 11, 'Iris', 1),
(34, 12, ' Tetanus', 0),
(35, 12, 'Cholera', 0),
(36, 12, 'Typhoid', 0),
(37, 12, 'Common Cold', 1),
(38, 13, '1922', 0),
(39, 13, '1919', 0),
(40, 13, '1920', 0),
(41, 13, '1921', 1),
(42, 14, 'Isaac Newton', 0),
(43, 14, 'Albert Einstein', 0),
(44, 14, 'Hans Bethe', 0),
(45, 14, 'Stephen Hawking', 1),
(46, 15, 'Albert Einstein', 0),
(47, 15, 'Werner Heisenberg', 0),
(48, 15, 'Ernest Rutherford', 0),
(49, 15, 'Max Planck', 1),
(50, 16, 'Italy', 1),
(51, 17, 'Thomas Jefferson', 1),
(52, 18, '323 BC', 0),
(53, 18, '350 BC', 0),
(54, 18, '200 BC', 0),
(55, 18, ' 336 BC', 1),
(56, 19, 'Otto von Bismarck', 1),
(57, 20, 'Andrew Jackson', 0),
(58, 20, 'George Washington', 0),
(59, 20, 'Abraham Lincoln', 1),
(60, 21, 'England', 0),
(61, 21, 'Ireland', 0),
(62, 21, 'France', 0),
(63, 21, 'Wales', 1),
(64, 22, 'Egypt', 0),
(65, 22, 'South Africa', 0),
(66, 22, 'Ghana', 0),
(67, 22, 'Namibia', 1),
(68, 23, '17', 0),
(69, 23, '22', 0),
(70, 23, '15', 0),
(71, 23, '18', 1),
(72, 24, 'Soccer', 0),
(73, 24, 'Basketball', 0),
(74, 24, 'Hokey', 0),
(75, 24, 'Cricket', 1),
(76, 25, '17', 0),
(77, 25, '7', 0),
(78, 25, '20', 0),
(79, 25, '12', 1),
(80, 26, 'Usher', 0),
(81, 26, 'Justin Bieber', 0),
(82, 26, 'Madona', 0),
(83, 26, 'Justin Timberlake', 1),
(84, 27, 'Plus', 0),
(85, 27, 'Multiply', 0),
(86, 27, 'Divide', 0),
(87, 27, 'Subtract', 1),
(88, 28, 'Beat', 0),
(89, 28, 'Girl', 0),
(90, 28, 'Tunes', 0),
(91, 28, 'Funk', 1),
(92, 29, 'John Lennon', 0),
(93, 29, 'George Harrison', 0),
(94, 29, 'Ringo Starr', 0),
(95, 29, 'Paul McCartney', 1),
(96, 30, 'Bad', 0),
(97, 30, 'Speed Demon', 0),
(98, 30, 'Beat It', 0),
(99, 30, 'Thriller', 1),
(100, 31, 'John Keats', 0),
(101, 31, 'Rudyard Kipling', 0),
(102, 31, 'H G Wells', 0),
(103, 31, 'Lewis Carroll', 1),
(104, 32, 'Christopher Marlowe', 0),
(105, 32, 'Johannes Gutenberg', 0),
(106, 32, 'René Descartes', 0),
(107, 32, 'Lord Alfred Tennyson', 1),
(108, 33, 'Browning', 0),
(109, 33, 'Marx', 0),
(110, 33, 'Kipling', 0),
(111, 33, 'Shakespeare', 1),
(112, 34, 'Winnie the Poo', 0),
(113, 34, 'Jungle book', 0),
(114, 34, 'The Railway Children', 0),
(115, 34, 'Peter Pan', 1),
(116, 35, 'HP and the Goblet of Fire', 0),
(117, 35, 'HP and the Chamber of Secrets', 0),
(118, 35, 'HP and the God of small Things', 0),
(119, 35, 'HP and the Philosopher?s Stone', 1),
(120, 36, 'Slovenia', 0),
(121, 36, 'Slovakia', 0),
(122, 36, 'Romania', 0),
(123, 36, 'Hungary', 1),
(124, 37, 'Incorrect', 0),
(125, 37, 'Incorrect', 0),
(126, 37, 'Incorrect', 0),
(127, 37, 'Russia', 1),
(128, 38, 'Queensland', 0),
(129, 38, 'New South Wales', 0),
(130, 38, 'Tasmania', 0),
(131, 38, 'Western Australia', 1),
(132, 39, 'Baku', 0),
(133, 39, 'Bataysk', 0),
(134, 39, 'Washington', 0),
(135, 39, 'Yerevan', 1),
(136, 40, 'White Sea', 0),
(137, 40, 'Norwegian Sea', 0),
(138, 40, 'Beaufort Sea', 0),
(139, 40, 'Bering Sea', 1);




