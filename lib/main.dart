import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superhands_app/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        // colorScheme: ColorScheme.dark(),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Colors.indigoAccent,
                elevation: 1,
                padding: EdgeInsets.all(5),
                minimumSize: Size(150, 35),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)))),
      ),

      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
