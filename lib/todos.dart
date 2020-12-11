import 'package:flutter/cupertino.dart';
import 'package:flutter_app_b/model/todo.dart';
import 'package:localstorage/localstorage.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> items=[
    Todo(title:'Hùng',description:'avc',isDone: true)
  ];
  TodoList() {
    items = new List();
  }

  _saveToStorage() {
    TodosProvider list = new TodosProvider();
    final LocalStorage storage = new LocalStorage('todo_app');
    storage.setItem('todos', list.toJSONEncodable());
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }

// List<Todo>get todos=>_Todos.where((todo)=>todo.isDone==false).toList();
  List<Todo> get todos => items.where((todo) => todo.isDone == false).toList();

  List<Todo> get todoFinished =>
      items.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    items.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    items.remove(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }

  bool checkStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }
}
