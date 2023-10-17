CREATE DATABASE blog2;
USE blog2;

CREATE TABLE IF NOT EXISTS users (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(45) NOT NULL,
  password VARCHAR(60) NOT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX username_UNIQUE (username ASC)
);

CREATE TABLE IF NOT EXISTS posts (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(45) NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_posts_users_idx (user_id ASC),
  CONSTRAINT fk_posts_users
      FOREIGN KEY (user_id)
      REFERENCES users (id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS comments (
  id INT NOT NULL AUTO_INCREMENT,
  content TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  user_id INT NOT NULL,
  post_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_comments_users_idx (user_id ASC),
  INDEX fk_comments_posts_idx (post_id ASC),
  CONSTRAINT fk_comments_users
      FOREIGN KEY (user_id)
      REFERENCES users (id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT fk_comments_posts
      FOREIGN KEY (post_id)
      REFERENCES posts (id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);
