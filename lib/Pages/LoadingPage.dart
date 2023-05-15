
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
      backgroundColor: (dark)? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Image.asset("nahida-genshin-unscreen.gif")
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
              child: Text(
                widget.msg,
                style: const TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
