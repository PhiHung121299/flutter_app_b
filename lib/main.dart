import 'package:flutter/material.dart';

import 'package:flutter_app_b/todo_list_widget.dart';
import 'package:flutter_app_b/todos.dart';
import 'package:provider/provider.dart';
import 'counter_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Todo App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: HomePage(),
        ),
      );
}

//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<CounterModel>(
//             create: (context) => CounterModel()),
//       ],
//       child: MaterialApp(
//         home: HomePage(),
//       ),
//     );
//   }
// }
