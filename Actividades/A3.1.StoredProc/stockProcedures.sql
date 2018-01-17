delimiter$$
create procedure show_products(IN linea_producto varchar(50))
BEGIN
	declare line varchar (50);
    set line =concat(linea_producto,"%");
    select * from products where productLine like line;
    
END$$
delimiter$$

delimiter$$
create procedure show_customer(IN linea_customerName varchar(50))
BEGIN
	declare contador int default 0;
	declare line varchar (50);
    set line =concat(linea_customerName,"%");
    select count(*) into contador from customer where customerName like line;
    select contador;
END$$
delimiter$$


delimiter$$
create procedure show_price()
BEGIN
declare barato varchar (50);
declare caro varchar (50);

Select *from products into barato order by buyPrice DESC LIMIT 1;

Select *from products into caro  order by buyPrice ASC LIMIT 1;

select barato,caro;

END$$
delimiter$$