create index index1 on orderdetails(orderLineNumber);
create index index2 on orderdetails(quantityOrdered,orderLineNumber);
create index index3 on orderdetails(orderLineNumber,quantityOrdered);

select * from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50;
select productCode from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50;
select orderLineNumber,count(*) from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50 group by orderLineNumber;

explain format = json select * from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50;
explain format = json select productCode from orderdetails force index(index1)where orderLineNumber =1 and quantityOrdered >50;
