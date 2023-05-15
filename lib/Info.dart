import 'package:flutter/cupertino.dart';
import 'package:project/CustomWidgets/PageResult.dart';

List suggestionList = [
  "Hello World",
  "Nahida",
  "why are we here?",
  "just to suffer",
  "looooooooooooooooooooooooooooooooooooongparagraph: flutter plugin for launching a URL. Supports web, phone, SMS, and email schemes. sidngbhijsntbjrnotbnroltynborsnbojrnolkbjmmebobokjem tyjnkmtlhyntext",
  "test1",
  "test2",
  "test3",
];

// List resultList = [
//   {
//     "link": "https://google.com",
//     "paragraph": "flutter plugin for launching a URL. Supports web, phone, SMS, and email schemes.",
//     "title": "google"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.google.com",
//     "paragraph": "paragraph 4",
//     "title": "google"
//   },
//   {
//     "link": "www.google.com",
//     "paragraph": "paragraph 5",
//     "title": "facebook"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.google.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "lol"
//   },
//   {
//     "link": "http://www.Face.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.lol.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "omg"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.hiiii.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "hooooooo"
//   },
//   {
//     "link": "http://www.wikiplolololedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "test"
//   },
//   {
//     "link": "http://www.wikidhdththpedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.2341.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "http://www.wikipedia.com",
//     "paragraph": "The launch method takes a string argument containing a URL . By default, Android opens up a browser when handling URLs. You can pass",
//     "title": "wikipedia"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//   {
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },{
//     "link": "www.facebook.com",
//     "paragraph": "paragraph 3",
//     "title": "google"
//   },
//
// ];
String serverAddress = 'localhost:8080';
//List suggestionList = [];
List resultList = [];
List subResultList = [];
bool dark = false;
bool tapped = false;

TextEditingController controller = TextEditingController();
