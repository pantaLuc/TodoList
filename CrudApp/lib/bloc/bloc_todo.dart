import 'dart:async';

import 'package:CrudApp/data/todo.dart';
import 'package:CrudApp/data/todo_db.dart';
// 1- The class that will srve as Bloc
class TodoBloc{
//2-  // data to Change
   TodoDb db;
   List<Todo> todoList;
//3- //StreamController is like a pipe 
 final _todosStreamController=StreamController<List<Todo>>.broadcast();
 //for update ;
  final _todoInsertController=StreamController<Todo>();
  final _todoUpdateController=StreamController<Todo>();
  final _todoDeleteController=StreamController<Todo>();
// 4- //Creating the Getter sink to add stream to retrieve
  Stream<List<Todo>> get todos => _todosStreamController.stream;//ou on extrait les donnnes 
  StreamSink<List<Todo>> get todosSink=>_todosStreamController.sink; // oou on ajoute les donnes modifier
  StreamSink<Todo> get todoInsertSink=> _todoInsertController.sink;
  StreamSink<Todo> get todoUpdateSink=> _todoUpdateController.sink;
  StreamSink<Todo> get todoDeleteSink=> _todoDeleteController.sink;
 // method needed to implement the Stream of data;
  Future getTodos() async{
    List<Todo> todos=await db.getTodos();
    todoList=todos;
    todosSink.add(todos);
  }
// What will give back the Stream
List<Todo> returnTodos(todos){
  return todos;
}
// 5- adding Logic 
void _deleteTodo(Todo todo){
  db.deleteTodo(todo).then((result){
    getTodos();
  });
}

void _updateTodo(Todo todo){
  db.updateTodo(todo).then((value) {
   
      getTodos(); 
  });
}

void _addTodo(Todo todo){
  db.insertTodo(todo).then((value) {
    getTodos();
  });
}

//6- Creating Constructor

TodoBloc(){
db=TodoDb();
getTodos();
//listen to Change 
_todosStreamController.stream.listen(returnTodos);
_todoInsertController.stream.listen(_addTodo);
_todoUpdateController.stream.listen(_updateTodo);
_todoDeleteController.stream.listen(_deleteTodo);
 
}

void dispose(){
   _todosStreamController.close();
   _todoInsertController.close();
   _todoUpdateController.close();
   _todoDeleteController.close();
 }

}