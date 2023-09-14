import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_work_hh/screens/brone_screen.dart';
import 'screens/hotel_screen.dart';
import 'screens/room_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Check(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: HotelScreen(),
      ),
    );
  }
}
