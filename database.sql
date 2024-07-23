drop table if exists Lessons;
drop table if exists module_courses;
drop table if exists Courses;
drop table if exists Modules;
drop table if exists Programs;

create table courses (
	id bigint primary key generated always as identity,
	title varchar (50) not null,
	content varchar not null,
	created_at timestamp not null,
	edited_at timestamp not null,
	deleted boolean
);

create table lessons (
	id bigint primary key generated always as identity,
	title varchar (50) not null,
	content varchar not null,
	link varchar(100) not null,
	number smallint not null,
	created_at timestamp not null,
	edited_at timestamp not null,
	course_id bigint references courses (id) not null,
	deleted boolean
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
	title varchar(50) not null,
	content varchar not null,
	created_at timestamp not null,
	program_id bigint references programs (id) not null,
	edited_at timestamp not null
);

create table module_courses (
	id bigint primary key generated always as identity,
	module_id bigint references modules (id) not null,
	course_id bigint references courses (id) not null
);
