db.clientes.insertMany([
{"name":"peter", numProds: 4, details:[{prod:"prod1", price:200}, {prod:"prod3", price:1200}]},
{"name":"peter", numProds: 7, details:[{prod:"prod3", price:20}, {prod:"prod2", price:1200}]}, 
{"name":"peter", numProds: 2, details:[{prod:"prod9", price:200}, {prod:"prod1", price:1200}]}, 
{"name":"Esme", numProds: 9, details:[{prod:"prod8", price:200}, {prod:"prod6", price:1200}]}, 
{"name":"Esme", numProds: 1, details:[{prod:"prod7", price:200}, {prod:"prod3", price:1200}]}, 
{"name":"Esme", numProds: 27, details:[{prod:"prod3", price:200}, {prod:"prod5", price:1200}]}, 
{"name":"Kike", numProds: 22, details:[{prod:"prod2", price:200}, {prod:"prod7", price:1200}]}, 
{"name":"Kike", numProds: 26, details:[{prod:"prod3", price:200}, {prod:"prod8", price:1200}]}, 
{"name":"Kike", numProds: 28, details:[{prod:"prod2", price:200}, {prod:"prod1", price:1200}]}
])
------------------------------------------------------------------------------------------------------
var reduce = function(name, values){ var n = Array.sum(values); return n; };

var map = function(){ emit(this.name, this.numProds); }

db.clientes.mapReduce(map, reduce, {out:"res"})

------------------------------------------------------------------------------------------------------

var getCosts = function(product, prices){ var n = Array.sum(price); return n;};

var mapCosts = function(){ 
	this.details.forEach( (value) => {emit(value.prod, value.price)})	
	}
	
db.clientes.mapReduce(mapCosts, getCosts, {out:"res"})
------------------------------------------------------------------------------------------------------