class Todo{
  int id ;
  String name ;
  String description;
  String completeBy;
  int priority;
  Todo(this.name,this.description,this.completeBy,this.priority);

  // creation a method toMap

  Map<String ,dynamic> toMap(){
           return {
             'name':name,
             'description':description,
             'completeBy':completeBy,
             'priority':priority
           };
  }

  // convert to a todo Object

  static Todo fromMap(Map<String ,dynamic> map){
    return Todo(
     map['name'],
     map['description'],
     map['completeBy'],
     map['priority']
    );
      
        
  }
}