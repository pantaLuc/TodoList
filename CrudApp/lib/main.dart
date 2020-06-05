import 'package:CrudApp/bloc/bloc_todo.dart';
import 'package:CrudApp/data/todo.dart';
//import 'package:CrudApp/data/todo_db.dart';
import 'package:CrudApp/todo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final AuthententicationType authententicationType=AuthententicationType.connection;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage()    
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoBloc todoBloc;
  List<Todo> todos;
  @override
  void initState(){
    todoBloc=TodoBloc();
    super.initState();
  } 


  
  @override
  Widget build(BuildContext context) {
    Todo todo = Todo('', '', '', 0);
    todos=todoBloc.todoList;
   // _testData();
    return Scaffold(
      appBar:AppBar(title: Text("TOdoList"),),
      body: Container(
        child: StreamBuilder<List<Todo>>(
          stream: todoBloc.todos,
          initialData: todos,
          builder:(BuildContext context, AsyncSnapshot snapshot){
            return ListView.builder(
              itemCount: (snapshot.hasData)?snapshot.data.length:0,
              itemBuilder:(context ,index){
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  onDismissed: (_)=>todoBloc.todoDeleteSink.add(snapshot.data[index]), 
                  child: ListTile(
                    leading:CircleAvatar(
                      backgroundColor:Theme.of(context).highlightColor,
                      child:Text("${snapshot.data[index].priority}"),
                    ),
                    title: Text("${snapshot.data[index].name}"),
                    subtitle:Text("${snapshot.data[index].description}"),
                    trailing: IconButton(
                      icon: Icon(Icons.edit), 
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoScreen(snapshot.data[index],false)));
                      }
                      
                      ),
                  )
                  );
              } 
              );
          },

        ),
      ),
     floatingActionButton: FloatingActionButton(
       onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoScreen(todo ,true)));
       }
     
     ),
    );
  }

/*Future  _testData() async{
    TodoDb db=TodoDb();
    await db.database;
    List<Todo> todos=await db.getTodos();
    await db.deleteAll();
    todos=await db.getTodos();
    await db.insertTodo(Todo('Call Donald', 'And tell him about Daisy','02/02/2020', 1));
    await db.insertTodo(Todo('Buy Sugar', '1 Kg, brown', '02/02/2020',2));
    await db.insertTodo(Todo('Go Running', '@12.00, with neighbours','02/02/2020', 3));
    todos = await db.getTodos();
    debugPrint('First insert');
    todos.forEach((Todo todo) {
      debugPrint(todo.name);
     });

     Todo updateTodo=todos[0];
     updateTodo.name="Call Tim";
     await db.updateTodo(updateTodo);
     Todo deleteTodo=todos[1];
     await db.deleteTodo(deleteTodo);
     debugPrint("After delete");
     todos= await db.getTodos();
     todos.forEach((Todo todo){
       debugPrint(todo.name);
     });

  }*/


}

