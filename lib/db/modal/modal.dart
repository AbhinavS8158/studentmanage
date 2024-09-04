

class Studentmodal{
  int?id;
  late String name;
  late String age;
  late String batch;
  late String domain;
  late String image;
 
  Studentmodal({required this.name,required this.age,required this.batch,required this.domain,required this.image,this.id});

  static Studentmodal fromMap(Map<String,Object?>map){
    final id=map['id'] as int;
    final name = map['name']as String;
    final age = map['age'] as String;
    final batch = map['batch'] as String;
    final domain = map['domain'] as String;
    final image = map['image'] as String;
  
     
   return Studentmodal(id: id, name: name, age: age, batch: batch, domain: domain,image:image );
  }
}