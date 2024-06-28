
import 'package:flutter/material.dart';
import 'Pages/SearchResults.dart';
import 'Pages/Home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/'               : (context) => Home2(),
        '/results'        : (context) => SearchResults2(),
      },
    ),
  );
}

