import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_b/Lich_view/Lich_Widget.dart';
import 'package:flutter_app_b/finished_list_widget.dart';
import 'package:flutter_app_b/main.dart';
import 'package:flutter_app_b/todo_list_widget.dart';
import 'package:flutter_app_b/todo_widget.dart';
import 'package:provider/provider.dart';
import 'DialogNhap.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWiget(),
      FinishedListWidget(),
      TimeTable(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Complete'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.blue,
        onPressed: () => showDialog(
          context: context,
          child: DialogNhap(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<HomePage> {
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final tabs = [
//       TodoListWidget(),
//       Container(),
//       Container(),
//     ];
//     return Scaffold(
//       appBar: AppBar(),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () {
//             showDialog(context: context, builder: (context) => DialogNhap());
//           }),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         unselectedItemColor: Colors.black.withOpacity(0.7),
//         selectedItemColor: Colors.white,
//         currentIndex: selectedIndex,
//         onTap: (index) => setState(() {
//           selectedIndex = index;
//         }),
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.fact_check_outlined), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Complete'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
//         ],
//       ),
//       body: tabs[selectedIndex],
//     );
//   }
// }
