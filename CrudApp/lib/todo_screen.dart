import 'package:CrudApp/bloc/bloc_todo.dart';
import 'package:CrudApp/data/todo.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class TodoScreen extends StatelessWidget {
  final Todo todo;
    final isNew ;
    final TextEditingController txtName=TextEditingController();
    final TextEditingController txtDescription=TextEditingController();
    final TextEditingController txtCompleteBy=TextEditingController();
    final TextEditingController txtPriority=TextEditingController();
    final TodoBloc bloc;
    
  TodoScreen(this.todo,this.isNew) : bloc=TodoBloc();
  Future save() async{
    todo.name=txtName.text;
    todo.description=txtDescription.text;
    todo.completeBy=txtCompleteBy.text;
    todo.priority=int.parse(txtPriority.text);
    if (isNew){
      bloc.todoInsertSink.add(todo);
    }else{
        bloc.todoUpdateSink.add(todo);
    }

  }
 

  @override
  Widget build(BuildContext context) {
         txtName.text=todo.name;
         txtDescription.text=todo.description;
         txtCompleteBy.text=todo.completeBy;
         txtPriority.text=todo.priority.toString();

    return Scaffold(
      appBar:AppBar(
        title:Text("Todo Details"),
      ),
      body:SingleChildScrollView(
         child:Padding(
           padding: EdgeInsets.all(30.0),
           child: Column(
             children: <Widget>[
                TextField(
                  controller:txtName,
                  decoration:InputDecoration(
                    border:InputBorder.none,
                    hintText:'Name',
                  )
                ),
                TextField(
                  controller:txtDescription,
                  decoration: InputDecoration(
                     border:InputBorder.none,
                     hintText:'Description'
                  ),
                ),
                TextField(
                  controller: txtCompleteBy,
                  decoration: InputDecoration(
                    border:InputBorder.none,
                    hintText:'CompletBy',
                  ),
                ),
                TextField(
                  controller:txtPriority,
                  keyboardType: TextInputType.number,
                  decoration:InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Priority'
                  )
                ),
               MaterialButton(
                 child:Text("Save"),
                 onPressed: (){
                   save().then((value) => Navigator.pushAndRemoveUntil(
                     context, 
                     MaterialPageRoute(builder: (context)=>HomePage(),), 
                     (Route<dynamic>route) => false)
                     );
                 }
                ) 
             ],
             ),
         )
      )
    );
  }
}

