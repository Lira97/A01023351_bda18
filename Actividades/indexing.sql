create index index1 on orderdetails(orderLineNumber);
create index index2 on orderdetails(quantityOrdered,orderLineNumber);
create index index3 on orderdetails(orderLineNumber,quantityOrdered);

select * from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50;
query_cost=95.20
select productCode from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50;
query_cost=95.20
select orderLineNumber,count(*) from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50 group by orderLineNumber;
query_cost=95.20

select * from orderdetails force index(index2)where orderLineNumber =1 and quantityOrdered >50;
query_cost=93.41
select productCode from orderdetails force index(index2)where orderLineNumber =1 and quantityOrdered >50;
query_cost=27.62
select orderLineNumber,count(*) from orderdetails force index(index2)where orderLineNumber =1 and quantityOrdered >50 group by orderLineNumber;
query_cost=27.62

select * from orderdetails force index(index3)where orderLineNumber =1 and quantityOrdered >50;
query_cost=8.01
select productCode from orderdetails force index(index3)where orderLineNumber =1 and quantityOrdered >50;
query_cost=3.02
select orderLineNumber,count(*) from orderdetails force index(index3)where orderLineNumber =1 and quantityOrdered >50 group by orderLineNumber;
query_cost=3.02

/*el costo depende del orden de los valores especificos delado iquierdo  y los rango de lado derecho 