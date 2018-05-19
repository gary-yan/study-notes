在建表过程中，会设置外键约束，所以表和表之间有依赖关系。 因此会先建立被外键指向的表，比如User,Category，然后再是其他表
创建用户表

#用户表
CREATE TABLE user(
id int(11) NOT NULL AUTO_INCREMENT，
name varchar(255) DEFAULT NULL,
password varchar(255) DEFAULT NULL,
PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#分类表
CREATE TABLE category(
id int(11) NOT NULL AUTO_INCREMENT，
name varchar(255) DEFAULT NULL,
PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#属性表 从这个表开始 有外键约束了 这个表的外键为cid，指向分类表的id字段
CREATE TABLE property(
id int(11) NOT NULL AUTO_INCREMENT，
cid int(11) DEFAULT NULL,
name varchar(255) DEFAULT NULL,
PRIMARY KEY (id)
CONSTRAINT fk_property_category FOREIGN KEY(cid) REFERENCES category(id)
)