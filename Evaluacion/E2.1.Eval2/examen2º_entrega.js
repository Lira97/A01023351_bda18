//Enrique Lira Martinez 
//1º
db.grades.aggregate({$group: {_id: "$student_id"}},{$group: {_id: 1,count: {$sum: 1}}})
//50 alumnos

//2º
db.grades.aggregate({$group: {_id: '$class_id'}},{$group: {_id: 1,count: {$sum: 1}}})
//31 clases

//3º

var map = function(){
	this.scores.forEach((value)=>{emit(this.student_id, value.score)});
};

var reduce = function(name, value){
	var n = Array.avg(value);
	return n;
};

db.grades.mapReduce(map,reduce,{out:"anw"})
db.anw.find()

//4º
db.grades.aggregate([{$unwind : "$scores"},{$group:{_id: {clase:"$class_id",estudiante:"$student_id"},promedio: {$avg: "$scores.score"}}},{$sort:{'promedio':1}},{"$limit":1}]);
//Clase 8 y estudiante 18

//5º
db.grades.aggregate([{$unwind:"$scores"},{$group:{"_id":"$class_id","count":{$sum:1}}},{$sort : {count : -1}}, {$limit :1 }])
//Materia 22

//6º
db.grades.aggregate([{ $group: { _id: "$student_id", count: { $sum: 1 } } },{$sort : {count : -1}}, {$limit :1 }])
//Estudiante 40

//7º
db.grades.aggregate([{$unwind : "$scores"},{$group:{_id: {clase:"$class_id",estudiante:"$student_id"},promedio: {$avg: "$scores.score"}}},{$match:{"promedio":{"$lt":70}}},{$group:{_id:"$_id.clase",count:{$sum: 1}}},{"$sort":{count:-1}},{"$limit":1}]);
//La clase 22 tuvo 14 reprobados 





				
