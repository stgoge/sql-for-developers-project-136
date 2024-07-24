drop table if exists lessons;
drop table if exists module_courses;
drop table if exists courses;
drop table if exists modules;
drop table if exists programs;
drop table if exists users;
drop table if exists user_roles;
drop table if exists teaching_groups;

create table courses (
	id bigint primary key generated always as identity,
	title varchar (50) not null,
	description varchar not null,
	created_at timestamp not null,
	edited_at timestamp not null,
	deleted_at timestamp
);

create table lessons (
	id bigint primary key generated always as identity,
	course_id bigint references courses (id) not null,
	title varchar (50) not null,
	content varchar not null,
	vudeo_url varchar(100) not null,
	position int null,
	created_at timestamp not null,
	edited_at timestamp not null,
	deleted_at timestamp
);

create table programs (
	id bigint primary key generated always as identity,
	title varchar not null,
	price int not null,
	type varchar(20) not null,
	created_at timestamp not null,
	edited_at timestamp not null
);

create table modules (
	id bigint primary key generated always as identity,
	program_id bigint references programs (id) not null,
	title varchar(50) not null,
	description varchar not null,
	created_at timestamp not null,
	edited_at timestamp not null,
	deleted_at timestamp
);

create table module_courses (
	id bigint primary key generated always as identity,
	module_id bigint references modules (id) not null,
	course_id bigint references courses (id) not null
);

create table teaching_groups (
	id bigint primary key generated always as identity,
	slug varchar(50) not null,
	created_at timestamp not null,
	edited_at timestamp not null
);

create table user_roles (
	id bigint primary key generated always as identity,
	role varchar(50) not null
);

create table users (
	id bigint primary key generated always as identity,
	name varchar(50) not null,
	email varchar(50) not null unique,
	password_hash varchar(255) not null,
	teaching_group_id bigint references teaching_groups (id) not null,
	role bigint references user_roles (id) not null,
	created_at timestamp not null,
	edited_at timestamp not null,
	deleted_at timestamp
);

