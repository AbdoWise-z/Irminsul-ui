import 'package:flutter/material.dart';
import 'package:project/Pages/LoadingPage.dart';
import 'package:project/CustomWidgets/PageResult.dart';
import 'package:project/Info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../CustomWidgets/SearchBar.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});


  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> with TickerProviderStateMixin{

  late AnimationController animationController;
  late AnimationController resultsController;

  late Animation<Color?> textColorTween;
  late Animation<Color?> titleColorTween;
  late Animation<Color?> linkColorTween;
  late Animation<Color?> arrowsColorTween;
  late Animation<Color?> searchBarBodyColorTween;
  late Animation<Color?> searchBarInnerColorTween;

  late Animation<double> sizeScaleTween;
  late Animation<double> opacityScaleTween;
  late Animation<double> curve;


  List<AnimatedBuilder> pages = [];
  int total = resultList.length;
  int numOfPages = 0;
  int currIndex = 0;
  int currPageIndex = 0;
  int remainingPages = 0;
  int remainingResults = 0;
  double timeTaken = 0;

  bool ready = true;

  void _handleReadyChanged(bool isReady) {
    setState(() {
      ready = isReady;
    });
  }

  void sendQuery() async{

    _handleReadyChanged(false);
    tapped = false;
    Uri url = Uri.http(serverAddress , "/search" , {"q" : "google"});
    print("Requesting: $url");
    var response = await http.get(url);
    print(response.body);
    resultList = jsonDecode(response.body);
    // await Future.delayed(const Duration(seconds: 2));
   _handleReadyChanged(true);
  }

  void getSubResult () async {
    _handleReadyChanged(false);
    tapped = false;
    subResultList.clear();
    print("Total : $total");

    if (resultList.isEmpty){
      print("Error , size was zero");
      return;
    }

    List<Map> items = [];

    for(int i = currIndex * 10; i < currIndex * 10 + 10; i++){
      if(i >= resultList.length){
        break;
      }
      items.add({
        "paragraphID" : resultList[i]["paragraphID"],
        "titleID" : resultList[i]["titleID"],
      });
    }

    Map send = {
      "query" : controller.text,
      "items" : jsonEncode(items),
    };

    //print(send);

    Uri url = Uri.http(serverAddress , "/translate",);

    print("Requesting: $url");
    var response = await http.post(url, body: jsonEncode(send));
    print(response.body);
    List temp = jsonDecode(response.body);

    for(int i = 0; i < temp.length ; i++){
      subResultList.add({
        "link" : resultList[i + currIndex * 10]["link"],
        "paragraph" : temp[i]["paragraphs"],
        "title" : temp[i]["title"],
        "score" : resultList[i + currIndex * 10]["score"],
        "toBoldIDs" : temp[i]["bold"],
      });
    }
    _handleReadyChanged(true);

  }

  @override
  void initState() {

    print("INIT");

    super.initState();

    sendQuery();
    getSubResult();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    resultsController = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    curve = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

    textColorTween = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(curve);

    titleColorTween = ColorTween(   //TODO:
      begin: Colors.blue,
      end: Colors.blue,
    ).animate(curve);

    linkColorTween = ColorTween(   //TODO:
      begin: Colors.green,
      end: Colors.green,
    ).animate(curve);

    arrowsColorTween = ColorTween(   //TODO:
      begin: Colors.lightGreenAccent,
      end: Colors.lightGreenAccent,
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
    opacityScaleTween = Tween<double>(begin: 0, end: 1).animate(resultsController);

    animationController.addListener(() {
      print(animationController.value);
      //print(textColorTween.value);
    });
    animationController.addStatusListener((status) {
      print(status);
    });

    (dark)? animationController.forward() : animationController.reverse();

    resultsController.forward();

    //print(total);
    numOfPages = total ~/ 10 + 1 ;
    remainingResults = total % 10;
    remainingPages = numOfPages % 10;
    tapped = false;
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // subResultList = ModalRoute.of(context)!.settings.arguments as List;
    // subResultList = resultList.sublist(currIndex * 10 , (currIndex == total ~/ 10)? currIndex * 10 + remainingResults : currIndex * 10 + 10);
    int start = currPageIndex * 10;
    int end = (currPageIndex == numOfPages ~/ 10)? (currPageIndex * 10 + remainingPages) : (currPageIndex * 10 + 10);
    pages.clear();
    for(int i = start + 1; i <= end; i++){
      pages.add(AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context , _){
          return TextButton(
              onPressed: (){
                setState(() {
                  resultsController.reset();
                  currIndex = i - 1;
                  resultsController.forward();
                  getSubResult();
                  //print(currIndex);
                });
              },
              child: Text(
                '$i',
                style: TextStyle(
                  color: ((i - 1) == currIndex) ? Colors.lightGreen : textColorTween.value,
                ),
              )
          );
        },
      )
      );
    }

    return (ready)? AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context ,_){
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: SizedBox(
                            width: 110,
                            height: 110,
                            child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, '/home');
                                },
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Stack(
                                    children: [
                                      Opacity(
                                        opacity: 1.0 - animationController.value,
                                        child: Image.asset("nahida-walk-unscreen.gif")
                                      ),
                                      Opacity(
                                        opacity: animationController.value,
                                        child: Image.asset("nahida-sleeping-genshin-impact-unscreen.gif"),
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SearchBar(
                          onSuggestionSelected: (String selection) {
                            controller.text = selection;
                            sendQuery();
                            //print(controller.text);
                          },
                          onButtonPressed: (){
                            (controller.text == '')? null : sendQuery(); getSubResult();
                          },
                          bodyColor: searchBarBodyColorTween.value!,
                          innerColor: searchBarInnerColorTween.value!,
                        )
                      ],
                    ),
                    const Divider(
                        color: Colors.lightGreen
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(135, 0, 0, 0),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          'About $total results ($timeTaken Seconds)',
                          style: TextStyle(
                              color: textColorTween.value,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: FadeTransition(
                        opacity: opacityScaleTween,
                        child: ListView(
                          children: subResultList.map((e) => Padding(
                            padding: const EdgeInsets.fromLTRB(130, 0, 550, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PageResult(e['link'], e['paragraph'],e['toBoldIDs'], e['title'], textColorTween.value ,titleColorTween.value,linkColorTween.value),
                                  const Divider(
                                      color: Colors.lightGreen
                                  ),
                                ]
                            ),
                          )).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                      child: Row(
                          children: [
                            IconButton(
                              onPressed:(){
                                if(currPageIndex != 0){
                                  setState(() {
                                    currPageIndex--;
                                    //print(currPageIndex);
                                  });
                                }
                              } ,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: arrowsColorTween.value,
                              ),
                            ),
                            Row(
                                children: pages
                            ),
                            IconButton(
                              onPressed:(){
                                if(currPageIndex < numOfPages ~/ 10){
                                  setState(() {
                                    currPageIndex++;
                                    //print(currPageIndex);
                                  });
                                }
                              } ,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: arrowsColorTween.value,
                              ),
                            ),
                          ]
                      ),
                    )
                  ],
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
                      if(animationController.isDismissed){
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
