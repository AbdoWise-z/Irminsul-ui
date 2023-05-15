import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> with SingleTickerProviderStateMixin{


  late AnimationController animationController;
  late Animation backgroundColorTween;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    backgroundColorTween = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(animationController);

    animationController.addListener(() {
      print(backgroundColorTween.value);
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, _){
        return IconButton(
          icon: Icon(Icons.add),
          onPressed: (){

          },
        );
      },

    );
  }
}
