
import 'package:flutter/material.dart';
import 'package:project/Pages/SearchResult.dart';
import 'Pages/SearchResults2.dart';
import 'Pages/Home2.dart';

void main() {
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',

    routes: {
      '/'               : (context) => Home2(),
      '/results'        : (context) => SearchResults2(),
    },
  )
  );
}

