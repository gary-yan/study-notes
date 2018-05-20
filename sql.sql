在建表过程中，会设置外键约束，所以表和表之间有依赖关系。 因此会先建立被外键指向的表，比如User,Category，然后再是其他表
创建用户表

#1 用户表
CREATE TABLE user(
	id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) DEFAULT NULL,
	password varchar(255) DEFAULT NULL,
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#不使用innnoDB无法使用外键

#2 分类表
CREATE TABLE category(
	id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) DEFAULT NULL,
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#3 属性表 从这个表开始 有外键约束了 这个表的外键为cid，指向分类表的id字段
CREATE TABLE property(
	id int(11) NOT NULL AUTO_INCREMENT,
	cid int(11) DEFAULT NULL,
	name varchar(255) DEFAULT NULL,
	PRIMARY KEY (id)
	CONSTRAINT fk_property_category FOREIGN KEY(cid) REFERENCES category(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#4 产品表
CREATE TABLE product(
	id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) DEFAULT NULL,
	subTitle varchar(255) DEFAULT NULL,
	originalPrice float DEFAULT NULL,
	promotionPrice float DEFAULT NULL,
	stock int(11) DEFAULT NULL,
	createDate datetime DEFAULT NULL,
	PRIMARY KEY(id),
	CONSTRAINT fk_product_category FOREIGN KEY(cid) REFERENCES category(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#5 属性值表
#有两个外键 外键ptid，指向属性表的id字段 外键pid，指向产品表的id字段
CREATE TABLE propertyvalue(
	id int(11) NOT NULL AUTO_INCREMENT,
	pid int(11) DEFAULT NULL,
	ptid int(11) DEFAULT NULL,
	 value varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_propertyvalue_property FOREIGN KEY (ptid) REFERENCES property (id),
  CONSTRAINT fk_propertyvalue_product FOREIGN KEY (pid) REFERENCES product (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
)

#6 产品图片表
#type表示类型，产品图片分为单个图片和详情图片两种
#本表外键pid，指向产品表的id字段
CREATE TABLE productimage(
id int(11) NOT NULL AUTO_INCREMENT,
pid int(11) DEFAULT NULL,
type varchar(255) DEFAULT NULL,
PRIMARY KEY(id)
CONSTRAINT fk_productimage_product FOREIGN KEY(pid) REFERENCES product(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#7 评价表
#外键pid，指向产品表的id字段
#外键uid，指向用户表的id字段
CREATE TABLE review(
id int(11) not NULL AUTO_INCREMENT,
content varchar(4000) DEFAULT NULL,
pid int(11) DEFAULT NULL,
uid int(11) DEFAULT NULL,
createDate datetime DEFAULT NULL,
PRIMARY KEY(id),
CONSTRAINT fk_review_product FOREIGN KEY(pid) REFERENCES product(id),
CONSTRAINT fk_review_user FOREIGN KEY(uid) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#8 订单表 
#外键uid，指向用户表id字段
#orderCode： 订单号
#address:收货地址
#post: 邮编
#receiver: 收货人信息
#mobile: 手机号码
#userMessage: 用户备注信息
#createDate: 订单创建日期
#payDate: 支付日期
#deliveryDate: 发货日期
#confirmDate：确认收货日期
#status: 订单状态

#order属于关键字 所以带有下划线
CREATE TABLE order_ (
  id int(11) NOT NULL AUTO_INCREMENT,
  orderCode varchar(255) DEFAULT NULL,
  address varchar(255) DEFAULT NULL,
  post varchar(255) DEFAULT NULL,
  receiver varchar(255) DEFAULT NULL,
  mobile varchar(255) DEFAULT NULL,
  userMessage varchar(255) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  payDate datetime DEFAULT NULL,
  deliveryDate datetime DEFAULT NULL,
  confirmDate datetime DEFAULT NULL,
  uid int(11) DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_order_user FOREIGN KEY (uid) REFERENCES user (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

#订单项表 number字段表示购买数量
#外键pid，指向产品表id字段
#外键oid，指向订单表id字段
#外键uid，指向用户表id字段

CREATE TABLE orderitem (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL,
  oid int(11) DEFAULT NULL,
  uid int(11) DEFAULT NULL,
  number int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_orderitem_user FOREIGN KEY (uid) REFERENCES user (id),
  CONSTRAINT fk_orderitem_product FOREIGN KEY (pid) REFERENCES product (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;