★解答1
select name from members
where member_id = (select member_id from sales order by sale desc limit 1);



★解答2
select name from members
where member_id in (select member_id from sales
where sale >= (select avg(sale) from sales));

★解答3
select sum(sale) from sales
where member_id in (select member_id from ages
where age < 40);