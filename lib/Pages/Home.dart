
import 'package:flutter/material.dart';
import 'package:project/Pages/LoadingPage.dart';
import 'package:http/http.dart' as http;
import 'package:project/CustomWidgets/SearchBar.dart';
import 'package:project/CustomWidgets/SearchTextField.dart';
import '../Info.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  bool ready = false;  //should be false at begin

  bool switchPressed = false;




  late AnimationController animationController;
  late Animation<Color?> backgroundColorTween;
  late Animation<Color?> searchBarBodyColorTween;
  late Animation<Color?> searchBarInnerColorTween;
  late Animation<double> sizeScaleTween;
  late Animation<double> curve;


  void _handleReadyChanged(bool isReady) {
    setState(() {
      ready = isReady;
    });
  }

  void getSuggestions() async {

    // var response = await http.get(Uri.parse(serverAddress),
    //     headers: {"req_type" : "auto_complete"},
    // );
    // print(response.body);
    // suggestionList = jsonDecode(response.body);

    //await Future.delayed(const Duration(seconds: 2));
    _handleReadyChanged(true);
  }

  void sendQuery() async{

    _handleReadyChanged(false);
    tapped = false;
    Uri url = Uri.http(serverAddress , "/search" , {"q" : controller.text});
    //print("Requesting: $url");
    var response = await http.get(url);
    //print(response.body);
    resultList = jsonDecode(response.body);
    // await Future.delayed(const Duration(seconds: 2));

    print("Resultlist.len = ${resultList.length}");


    setState(() {
      Navigator.pushNamed(context, "/searchResult");
      ready = true;
    });

  }

  @override
  void initState() {
    super.initState();

    tapped = false;

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    curve = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

    backgroundColorTween = ColorTween(
      begin: Colors.white,
      end:   Colors.black,
    ).animate(curve);

    searchBarBodyColorTween = ColorTween(
      begin: Colors.lightGreenAccent,
      end: Colors.white,
    ).animate(curve);

    searchBarInnerColorTween = ColorTween(
      begin: Colors.black,
      end: Colors.lightGreenAccent,
    ).animate(curve);

    sizeScaleTween = Tween<double>(begin: 1, end: 1750).animate(curve);

    animationController.addListener(() {
      //print(animationController.value);
      //print(backgroundColorTween.value);
    });
    animationController.addStatusListener((status) {
      print(status);
    });

    (dark)? animationController.forward() : animationController.reverse();

    getSuggestions();
  }
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return (ready) ? AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, _ ){
        return Scaffold(
          //backgroundColor: (dark)? Colors.black : Colors.white,
          body: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ScaleTransition(
                  alignment: Alignment.topRight,
                  scale: sizeScaleTween,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
                    child: Container(
                      width: 1,
                      height: 1,
                      color: (animationController.isAnimating || animationController.isCompleted)? Colors.black : Colors.transparent,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                          child: Image.asset("nahida.jpg"),
                        ),
                        SearchBar(
                          onSuggestionSelected: (String selection) {
                            controller.text = selection;
                            sendQuery();
                            //print(controller.text);
                          },
                          onButtonPressed: (){
                            (controller.text == '')? null : sendQuery();
                          },
                          bodyColor: searchBarBodyColorTween.value!,
                          innerColor: searchBarInnerColorTween.value!,
                        )
                      ]
                  ),
                ),
                IconButton(
                  onPressed: (){
                    setState((){
                      if(!animationController.isAnimating){
                        dark = !dark;
                      }
                      if(animationController.isCompleted){
                        animationController.reverse();
                      }
                      else if(animationController.isDismissed){
                        animationController.forward();
                      }
                    });
                  },
                  icon: (dark)? const Icon(Icons.sunny , color: Colors.lightGreenAccent,) : Image.asset('moon_icon.png'),
                ),
              ]
          ),
        );
      },
    )
    : const LoadingPage();
  }
}
