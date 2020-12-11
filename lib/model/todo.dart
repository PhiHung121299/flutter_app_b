import 'package:flutter/cupertino.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {

  String title;

  String description;
  bool isDone;

  Todo({
    @required this.title,
    this.description = '',
    this.isDone = false,
  });
// class Todo {
//   String title;
//
//   String description;
//   bool isDone;
//
//   Todo({this.title, this.description,this.isDone});
  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['description'] = description;
    m['isDone'] = isDone;

    return m;
  }

}
