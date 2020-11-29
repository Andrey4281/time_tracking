drop table users_currenttrack;
drop table track;
drop table users;
drop table status;

create table status (
  id serial primary key,
  name varchar(50) not null
);

create table users (
  id serial primary key,
  username varchar(50) not null unique,
  password varchar(100) not null,
  status_id int references status(id) not null
);

create table track (
  id serial primary key,
  came timestamp without time zone,
  gone timestamp without time zone,
  user_id int references users(id) not null
);

create table users_currentTrack (
    user_id int references users(id) not null unique,
    track_id int references track(id) not null unique
);

insert into status(name) values ('отсутствует'), ('на работе');