drop table if exists discussion_messages;
drop table if exists blog;
drop table if exists discussions; 
drop table if exists quiz_questions;
drop table if exists quizzes;
drop table if exists exercises;
drop table if exists lessons;
drop table if exists module_courses;
drop table if exists courses;
drop table if exists modules;
drop table if exists payments;
drop table if exists enrollments;
drop table if exists program_completions;
drop table if exists certificates;
drop table if exists programs;
drop table if exists users;
drop table if exists teaching_groups;
drop type if exists user_roles;
drop type if exists enrollment_statuses;
drop type if exists payment_statuses;
drop type if exists program_statuses;
drop type if exists blog_statuses;

create table courses (
	id bigint primary key generated always as identity,
	title varchar (50) not null,
	description varchar not null,
	created_at timestamp not null default current_timestamp,
	edited_at timestamp not null default current_timestamp,
	deleted_at timestamp
);

create table lessons (
	id bigint primary key generated always as identity,
	course_id bigint references courses (id) not null,
	title varchar (50) not null,
	content varchar not null,
	vudeo_url varchar(100) not null,
	position int null,
	created_at timestamp not null default current_timestamp,
	edited_at timestamp not null default current_timestamp,
	deleted_at timestamp
);

create table programs (
	id bigint primary key generated always as identity,
	title varchar not null,
	price int not null,
	type varchar(20) not null,
	created_at timestamp not null default current_timestamp,
	edited_at timestamp not null default current_timestamp
);

create table modules (
	id bigint primary key generated always as identity,
	program_id bigint references programs (id) not null,
	title varchar(50) not null,
	description varchar not null,
	created_at timestamp not null default current_timestamp,
	edited_at timestamp not null default current_timestamp,
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
	created_at timestamp not null default current_timestamp,
	edited_at timestamp not null default current_timestamp
);

create type user_roles as enum ('студент', 'учитель', 'админ');

create table users (
	id bigint primary key generated always as identity,
	name varchar(50) not null,
	email varchar(50) not null unique,
	password_hash varchar(255) not null,
	teaching_group_id bigint references teaching_groups (id) not null,
	role user_roles not null,
	created_at timestamp not null default current_timestamp,
	edited_at timestamp not null default current_timestamp,
	deleted_at timestamp
);

create type enrollment_statuses as enum ('active', 'pending', 'cancelled', 'completed');

create table enrollments (
	id bigint primary key generated always as identity,
	user_id bigint references users (id),
	program_id bigint references programs (id),
	enrollment_status enrollment_statuses not null,
	created_at timestamp default current_timestamp
);

create type payment_statuses as enum ('pending', 'paid', 'failed', 'refunded');

create table payments (
	id bigint primary key generated always as identity,
	enrollment_id bigint references enrollments (id) not null,
	payment_status payment_statuses not null,
	cost int not null,
	payment_date timestamp default current_timestamp,
	created_at timestamp default current_timestamp,
	edited_at  timestamp default current_timestamp
);

create type program_statuses as enum ('active', 'completed', 'pending', 'cancelled');

create table program_completions (
	id bigint primary key generated always as identity,
	user_id bigint references users (id) not null,
	program_id bigint references programs (id) not null,
	status program_statuses not null,
	started_at timestamp not null,
	completed_at timestamp,
	created_at timestamp default current_timestamp not null,
	edited_at timestamp default current_timestamp not null
	
);

create table certificates (
	id bigint primary key generated always as identity,
	user_id bigint references users (id) not null,
	program_id bigint references programs (id) not null,
	link varchar(100) not null,
	certificate_date timestamp default current_timestamp not null,
	created_at timestamp default current_timestamp not null,
	edited_at timestamp default current_timestamp not null
);

create table quizzes (
	id bigint primary key generated always as identity,
	lesson_id bigint references lessons (id) not null,
	title varchar(50) not null,
	created_at timestamp default current_timestamp not null,
	edited_at timestamp default current_timestamp not null
);

create table quiz_questions (
	id bigint primary key generated always as identity,
	quiz_id bigint references quizzes (id) not null,
	content varchar not null,
	next_question bigint
);

create table exercises (
	id bigint primary key generated always as identity,
	lesson_id bigint references lessons (id) not null,
	title varchar(50) not null,
	link varchar(100) not null,
	created_at timestamp default current_timestamp not null,
	edited_at timestamp default current_timestamp not null
);

create table discussions (
	id bigint primary key generated always as identity,
	lesson_id bigint references lessons (id) not null,
	messages varchar not null,
	created_at timestamp default current_timestamp not null,
	edited_at timestamp default current_timestamp not null
);

create table discussion_messages (
	id bigint primary key generated always as identity,
	discussion_id bigint references discussions (id),
	parent_message bigint,
	content varchar not null
);

create type blog_statuses as enum  ('created', 'in moderation', 'published', 'archived');

create table blog (
	id bigint primary key generated always as identity,
	user_id bigint references users (id) not null,
	title varchar(50) not null,
	content varchar not null,
	status blog_statuses not null,
	created_at timestamp default current_timestamp not null,
	edited_at timestamp default current_timestamp not null
);
