
import 'package:flutter/material.dart';
import 'package:project/CustomWidgets/SearchTextField.dart';
import 'package:project/Pages/SearchResult.dart';
import 'Pages/Home.dart';
import 'package:project/CustomWidgets/PageResult.dart';
import 'test.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home' : (context) => const Home(),
      // '/pageResult' : (context) => PageResult("https://google.com","hello world paragraph hello world paragraph"
      //     "hello world paragraph"
      //     "hello world paragraph"
      //     "hello world paragraph"
      //     "hello world paragraph"
      //     "hello world paragraph","Hello World - Google",Colors.black,Colors.green,Colors.yellow,),
      '/searchResult' : (context) => const SearchResult(),
      '/searchBar' : (context) => const SearchTextField(bodyColor: Colors.red,innerColor: Colors.red,),
      //'/test' : (context) => AnimatedScaffold(),
    }

  ));
}

