
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_b/model/todo.dart';
import 'package:flutter_app_b/todo_widget.dart';
import 'package:flutter_app_b/todos.dart';
import 'package:flutter_app_b/utils.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class TodoListWiget extends StatefulWidget {
  @override
  _TodoListWigetState createState() => _TodoListWigetState();
}

class _TodoListWigetState extends State<TodoListWiget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final provider = Provider.of<TodosProvider>(context);
    final LocalStorage storage = new LocalStorage('todo_app');
    final TodosProvider list = new TodosProvider();
    bool initialized = false;
    final todos = provider.todos;
    final todofinished = provider.todoFinished;

    _saveToStorage() {
      storage.setItem('todos', list.toJSONEncodable());
    }

    return new Scaffold(
      body: new Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!initialized) {
                var items = storage.getItem('todos');
                if (items != null) {
                  list.items= List<Todo>.from(
                    (items as List).map(
                      (item) => Todo(
                        title: item['title'],
                        description: item['description'],
                        isDone: item['isDone'],
                      ),
                    ),
                  );
                }

                initialized = true;
              }

              List<Widget> widgets = list.todos.map((item) {
                return Row(
                  children: [
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                      value: item.isDone,
                      onChanged: (_) {
                        final provider =
                            Provider.of<TodosProvider>(context, listen: false);
                        final isDone = provider.checkStatus(item);
                        Utils.showSnackBar(
                            context,
                            isDone
                                ? 'Task Complete'
                                : 'Task marked incomplete');
                        _saveToStorage();
                      },
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          if (item.description.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                item.description,
                                style: TextStyle(fontSize: 10, height: 1.5),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                );
              }).toList();
              List<Widget> widgetfinish = list.todoFinished.map((item) {
                return Row(
                  children: [
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                      value: item.isDone,
                      onChanged: (_) {
                        final provider =
                            Provider.of<TodosProvider>(context, listen: false);
                        final isDone = provider.checkStatus(item);
                        Utils.showSnackBar(
                            context,
                            isDone
                                ? 'Task Complete'
                                : 'Task marked incomplete');
                        _saveToStorage();
                      },
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          if (item.description.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                item.description,
                                style: TextStyle(fontSize: 10, height: 1.5),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                );
              }).toList();
              return Column(
                children: <Widget>[
                  Text(
                    'Todo Jod',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: widgets,
                      itemExtent: 50.0,
                    ),
                  ),
                  Text(
                    'Todo Finished',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: widgetfinish,
                      itemExtent: 50.0,
                    ),
                  ),
                ],
              );
            },
          )),
      // child: new Column(
      //   children: <Widget>[
      //     new Text(
      //       'Todo Jod',
      //       style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //     ),
      //     new Container(
      //       width: screenSize.width,
      //       height: 150,
      //       color: Colors.white,
      //       child: new ListView.builder(
      //         itemCount: todos.length,
      //         itemBuilder: (context, index) {
      //           final todo = todos[index];
      //           return TodoWidget(todo: todo);
      //         },
      //       ),
      //     ),
      //     new Text(
      //       'Todo Finished',
      //       style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //     ),
      //     new Container(
      //       width: screenSize.width,
      //       height: 200,
      //       color: Colors.white,
      //       child: new ListView.builder(
      //         itemCount: todofinished.length,
      //         itemBuilder: (context, index) {
      //           final todo = todofinished[index];
      //           return TodoWidget(todo: todo);
      //         },
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoWidget(todo: todo);
      },
    );
  }
}

//
// class _TodoListWigetState extends State<TodoListWiget> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery
//         .of(context)
//         .size;
//     final provider = Provider.of<TodosProvider>(context);
//
//     return Scaffold(
//
//         body: new Column(
//           children: [
//             Box1(),
//           ],
//         )
//
//     );
//   }
// }
//
// class Box1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TodosProvider>(context);
//     final todos = provider.todos;
//     final screenSize = MediaQuery
//         .of(context)
//         .size;
//     return new Scaffold(
//       body: new Container(
//         child: new ListView.builder(
//           itemCount: todos.length,
//           itemBuilder: (context, index) {
//             final todo = todos[index];
//             return TodoWidget(todo: todo);
//           },
//         ),
//       ),
//     );
//   }
// }
