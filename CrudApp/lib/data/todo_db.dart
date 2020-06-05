import 'package:CrudApp/data/todo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TodoDb{
  //  a singleton to open not more than once 
  static final TodoDb _singleton=TodoDb._internal();
  //private internal constructor
  TodoDb._internal();
  DatabaseFactory databaseFactory=databaseFactoryIo;
  //where to store the todo the file 
  final store=intMapStoreFactory.store('todos');
  // data base client
   Database _database;
   Future<Database> get database async{
     if(_database==null){
       await _openDb().then((db){
          _database=db;
       });
     }
     return _database;
   }
  
  Future _openDb()async{
    final docPath=await getApplicationDocumentsDirectory();
    final dbpath=join(docPath.path,'todos.db');
    final db=await databaseFactory.openDatabase(dbpath);
    return db;
  }
  //Creating the CruD ;
  // Methode insertTodo add a new todo
  Future insertTodo(Todo todo) async{
     await store.add(_database, todo.toMap());
  }
  // Method to update a todo we will first search for the todo using a finder
   Future updateTodo(Todo todo)async{
     final finder=Finder(filter:Filter.byKey(todo.id));
     await store.update(_database, todo.toMap(),finder:finder);
   }

   //we also need a finder to delete a Method

   Future deleteTodo(Todo todo) async{
     final finder=Finder(filter:Filter.byKey(todo.id));
     await store.delete(_database,finder:finder);
   }
   // to deleteall 
    Future deleteAll() async{
      await store.delete(_database);
    }
   // find Element in A database on va utilser la priorite et le id pour filter 

   Future<List<Todo>> getTodos()  async{
     await database;
     final finder=Finder(sortOrders: [
       SortOrder('priority'),
       SortOrder('id'),
     ]);
     final todoSnapshot=await store.find(_database, finder:finder);
     return todoSnapshot.map((e){
       final todo=Todo.fromMap(e.value);
       todo.id=e.key;
       return todo;
     }).toList();
   }

  //factory method we really dont know what the singleton wil give us back

  factory TodoDb(){
    return _singleton;
  }
}

 
  