#### 基本要件(必須)
下記のような売上情報を格納したテーブル`sales`と
社員情報を格納したテーブル`members`が存在する

このとき、サブクエリや関数を用いて
次のレコードを求めるようなSQL文を作成し、
実行結果を確認せよ

1. 最大の売上を出した社員の名前
2. 売上の平均以上を達成した社員の名前
3. 30代以下の社員が達成した売上の合計

-------------------------------------------
+-----------+-----------+
| member_id | name      |
+-----------+-----------+
|         1 | Tanaka    |
|         2 | Sato      |
|         3 | Suzuki    |
|         4 | Tsuchiya  |
|         5 | Yamada    |
|         6 | Sasaki    |
|         7 | Harada    |
|         8 | Takahashi |
|         9 | Nishida   |
|        10 | Nakada    |
+-----------+-----------+

+-----------+------+-------+
| member_id | sale | month |
+-----------+------+-------+
|         1 |   75 |     4 |
|         2 |  200 |     5 |
|         3 |   15 |     6 |
|         4 |  700 |     5 |
|         5 |  672 |     4 |
|         6 |   56 |     8 |
|         7 |  231 |     9 |
|         8 |  459 |     8 |
|         9 |    8 |     7 |
|        10 |  120 |     4 |
+-----------+------+-------+

+-----------+------+
| member_id | age  |
+-----------+------+
|         1 |   24 |
|         2 |   25 |
|         3 |   47 |
|         4 |   55 |
|         5 |   39 |
|         6 |   26 |
|         7 |   43 |
|         8 |   33 |
|         9 |   24 |
|        10 |   20 |
+-----------+------+





mysql -u root -p
パスワード入力
show databases;
create database work;
show databases;
use work;
show tables;


create table sales (member_id int, sale int, month int);
show tables;
desc sales;
select * from sales;
insert into sales (member_id, sale, month) values (1, 75, 4);
select * from sales;

insert into sales (member_id, sale, month) values (2 , 200 , 5),
(3 , 15 , 6),
(4 , 700 , 5),
(5 , 672 , 4),
(6 , 56 , 8),
(7 , 231 , 9),
(8 , 459 , 8),
(9 , 8 , 7),
(10 , 120 , 4);

select * from sales;

create table members (member_id int, name varchar(32) );
show tables;
desc members;
select * from members;

insert into members (member_id, name) values (1, "Tanaka"),
(2, "Sato"),
(3, "Suzuki"),
(4, "Tsuchiya"),
(5, "Yamada"),
(6, "Sasaki"),
(7, "Harada"),
(8, "Takahashi"),
(9, "Nishida"),
(10, "Nakada");
select * from members;

create table ages (member_id int, age int );
show tables;
desc ages;
select * from ages;
insert into ages (member_id, age) values (1, 24),
(2, 25),
(3, 47),
(4, 55),
(5, 39),
(6, 26),
(7, 43),
(8, 33),
(9, 24),
(10, 20);
select * from ages;

■参考
drop table members;
drop database work;

■参考 http://www.dbonline.jp/mysql/select/index20.html
■参考 http://www.atmarkit.co.jp/ait/articles/0708/29/news118.html
■参考 http://db.yulib.com/mysql/000027.html

★解答1
select * from members
where member_id = (select member_id from sales order by sale desc limit 1);

select name from members
where member_id = (select member_id from sales order by sale desc limit 1);



★解答2  (inの使い方がポイント)
select avg(sale) from sales;

select * from sales
where sale >= (select avg(sale) from sales);

select * from members
where member_id in (select member_id from sales
where sale  >= (select avg(sale) from sales));

select name from members
where member_id in (select member_id from sales
where sale >= (select avg(sale) from sales));

★解答3
select sum(sale) from sales

select * from ages
where age < 40;

select sale from sales
where member_id in (select member_id from ages
where age < 40);

select sum(sale) from sales
where member_id in (select member_id from ages
where age < 40);
