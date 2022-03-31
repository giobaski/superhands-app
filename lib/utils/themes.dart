import 'package:flutter/material.dart';

class MyThemes {

  static final lightTheme = ThemeData(
    primarySwatch: Colors.red,
    colorScheme: ColorScheme.light(),
    textTheme: textTheme,


    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.indigoAccent,
            elevation: 1,
            padding: EdgeInsets.all(5),
            minimumSize: Size(150, 35),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        )
    ),
  );



  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    // scaffoldBackgroundColor: Colors.black
    colorScheme: ColorScheme.dark(),
    textTheme: textTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.indigoAccent,
            elevation: 1,
            padding: EdgeInsets.all(10),
            minimumSize: Size(150, 40),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        )
    )
  );


  static final textTheme = TextTheme(
    //SN9 width:384 (0.025 = 9.6, 0.03 = 11.52, 0.035 = 13.44, 0.04 = 15.36)
    headline4: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff1c2f5c)),
    headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff1c2f5c)),

    subtitle1: TextStyle(fontSize: 14), // შპს ნისანი, listview's title, hints
    subtitle2: TextStyle(fontSize: 12),  //Table header დასახელება, რაოდ.

    // bodyText1: TextStyle(fontSize: 14, color: Colors.teal), // navigation drawer's title
    bodyText2: TextStyle(fontSize: 14), //Text(), ხელშეკრულების ტექსტი, პროდუქტები, საერთო ღირ.
    caption: TextStyle(fontSize: 13, color: Colors.grey), // თანამონაწილეობა: 0.0
    button: TextStyle(fontFamily: 'bpg_mrgvlovani_caps_2010', fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
  );




}