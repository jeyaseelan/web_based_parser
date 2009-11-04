create table users
(
  id serial unique primary key,
  updated_at timestamp,
  name text,
  mobile text,
  email text,
  user_name text,
  salt text,
  encrypt_password text,
  admin boolean default false--if user is admin , it will be true
);


create table rss_types
(
  id serial unique primary key,
  updated_at timestamp,
  name text,
  rssfile text
);


create table rss_contents
(
  id serial unique primary key,
  updated_at timestamp,
  posted_at timestamp,
  title text,
  link text,-- www.mpowerforce.com/file?id=11111
  description text,
  rss_type_id integer references rss_types(id) not null
);


create table user_rss_types
(
  id serial unique primary key,
  updated_at timestamp,
  rss_type_id integer references rss_types(id) not null,
  user_id integer references users(id) not null
);


create table user_rss_type_rss_contents
(
  id serial unique primary key,
  updated_at timestamp,
  user_rss_type_id integer references user_rss_types(id) not null,
  rss_content_id integer references rss_contents(id) not null,
  viewed boolean default false
);


