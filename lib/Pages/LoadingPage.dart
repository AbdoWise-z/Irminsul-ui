
//import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
//import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Info.dart';

class LoadingPage extends StatefulWidget {
  final String msg;
  const LoadingPage({this.msg = "Loading..."  ,Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Image.asset("nahida-genshin-unscreen.gif")
            ),

            const SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
