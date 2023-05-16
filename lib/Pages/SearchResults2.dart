
import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:project/CustomWidgets/SearchResultItem.dart';
import 'package:project/CustomWidgets/ThemedSearchBar.dart';
import 'package:project/Pages/LoadingPage.dart';
import 'package:http/http.dart' as http;
import '../Info.dart';
import 'dart:convert';

class SearchResults2 extends StatelessWidget {
  const SearchResults2({super.key});
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: dark ? ThemeData.dark() : ThemeData.light(),
      builder: (_ , theme) {
        return SearchResults2Page();
      },
    );
  }
}

class SearchResults2Page extends StatefulWidget {
  const SearchResults2Page({Key? key}) : super(key: key);

  @override
  State<SearchResults2Page> createState() => _SearchResults2PageState();
}

class _SearchResults2PageState extends State<SearchResults2Page> {

  double queryTime = 0.1;
  bool searching = true;
  int page = 0;
  int itemsPerPage = 20;
  int bottomPageRange = 12;

  int dispStart = 0;


  void search() async {
    //actual search here
    print("Searching...");
    searching = true;
    String q = controller.text;
    if (q.isEmpty){
      print("Search was empty , aborting ..");
      searching = false;
      setState(() {

      });
      return;
    }

    page = 0;
    dispStart = 0;
    setState(() {});
    queryTime = DateTime.now().millisecond.toDouble() + DateTime.now().second.toDouble() * 1000.0;
    resultList.clear();

    Uri url = Uri.http(serverAddress , "/search" , {"q" : controller.text});
    print("Requesting: $url");
    var response = await http.get(url);
    if (response.body.isNotEmpty) {
      resultList = jsonDecode(response.body);
    }else{
      print("Result was empty");
    }

    searching = false;
    queryTime = DateTime.now().millisecond.toDouble() + DateTime.now().second.toDouble() * 1000.0 - queryTime;
    queryTime = queryTime / 1000.0;

    if (resultList.isNotEmpty){
      minHighlightScore = resultList[0]["score"] * minHighlightOf;
      print("Min=$minHighlightScore");
    }

    print("Search done !");

    translate();

  }

  List translated = [];
  double minHighlightScore = 0;
  double minHighlightOf = 0.75;
  bool translating = false;
  void translate() async {
    translating = true;

    translated.clear();


    if (resultList.isEmpty){
      translating = false;
      setState(() {});
      return;
    }

    List<Map> items = [];

    for(int i = page * itemsPerPage; i < (page + 1) * itemsPerPage; i++){
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

    Uri url = Uri.http(serverAddress , "/translate",);

    print("Requesting: $url");
    var response = await http.post(url, body: jsonEncode(send));
    List temp = jsonDecode(response.body);

    for(int i = 0; i < temp.length ; i++){

      translated.add({
        "link" : resultList[i + page * itemsPerPage ]["link"],
        "para" : temp[i]["paragraphs"],
        "title" : temp[i]["title"],
        "score" : resultList[i + page * itemsPerPage]["score"],
        "bold" : temp[i]["bold"],
      });
    }

    translating = false;
    setState(() {
    });
  }

  bool sugLoading = false;
  String? sugNext;
  void getSuggestions(String str) async {
    if (sugLoading){
      sugNext = str;
      return;
    }
    sugLoading = true;

    //load it here
    suggestionList.clear();


    Uri url = Uri.http(serverAddress , "/Query" , {"q" : controller.text});
    var response = await http.get(url);

    if (response.body.isNotEmpty) {
      suggestionList = jsonDecode(response.body);
    }

    sugLoading = false;
    if (sugNext != null && sugNext != str){
      String q = sugNext!;
      sugNext = null;
      getSuggestions(q);
    }else{
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    suggestionList.clear();
    search();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: null,
        body:
        searching || translating ?
        const LoadingPage()
            :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0 ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 50,
                            child: Image.asset(

                              "irminsul_golden.png",

                              color: dark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(
                                  255, 40, 40, 40),
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(
                            width: 60,
                            height: 28,
                            child: Image.asset(
                              "irminsul_text.png",
                              color: dark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(
                                  255, 40, 40, 40),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: ThemedSearchBar(
                      onEnterPressed: () => search(),
                      onSuggestionSelected: (str) {
                        controller.text = str;
                        search();
                      },
                      onEdit: (str) {
                        getSuggestions(str);
                      },
                    ),
                  )
                ],
              ),
            ),

            const Divider(),


            Visibility(
              visible: resultList.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(135, 0, 0, 0),
                child: FittedBox(
                  child: Text(
                    'About ${resultList.length} results ($queryTime Seconds)',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: resultList.isNotEmpty,
              child: Expanded(
                child: ListView(
                  children: List.generate(
                    translated.length,
                        (i) =>
                        SearchResultItem(
                          highlight: translated[i]["score"] > minHighlightScore,
                          title: translated[i]["title"],
                          link: translated[i]["link"],
                          paragraph: translated[i]["para"],
                          bold: translated[i]["bold"],
                          score: translated[i]["score"],
                        ),
                  )
                  ,
                ),
              ),
            ),

            Visibility(
              visible: resultList.isNotEmpty,
              child: const Divider(),
            ),

            Visibility(
              visible: resultList.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Row(
                      children: [
                        IconButton(
                          onPressed:(){
                            if(dispStart != 0){
                              setState(() {
                                dispStart--;
                              });
                            }
                          } ,
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),

                        Row(
                            children: List.generate( min(getNumPages() , bottomPageRange) , (index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: (dark) ?
                                    (dispStart + index == page) ?
                                    const MaterialStatePropertyAll(Color.fromARGB(
                                        60, 0, 110, 145)) :  //dark mode
                                    const MaterialStatePropertyAll(Color.fromARGB(
                                        15, 169, 169, 169))
                                        :
                                    (dispStart + index == page) ?
                                    const MaterialStatePropertyAll(
                                        Color.fromARGB(60, 0, 110, 145)
                                    ) : //light mode
                                    const MaterialStatePropertyAll(Color.fromARGB(
                                        115, 169, 169, 169))
                                    ,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      page = dispStart + index;
                                      if (page == dispStart + bottomPageRange - 1){ //last one
                                        if (dispStart < getNumPages() - bottomPageRange){
                                          dispStart++;
                                        }
                                      }

                                      if (page == dispStart && dispStart != 0){
                                        dispStart--;
                                      }
                                      translate();
                                    });
                                  },
                                  child: Text(" ${dispStart + index + 1} "),
                                ),
                              );
                            })
                        ),

                        IconButton(
                          onPressed:(){
                            if(dispStart < getNumPages() - bottomPageRange){
                              setState(() {
                                dispStart++;
                                //print(currPageIndex);
                              });
                            }
                          } ,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ]
                  ),
              ),
            ),

            Visibility(
              visible: resultList.isEmpty,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 35, 35, 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        "not-found.png",
                        color: dark ? const Color.fromARGB(255, 100, 100, 255) : const Color.fromARGB(
                            255, 100, 100, 255),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    const Text(
                      "Oops!",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: resultList.isEmpty,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "your search for \"${controller.text}\" did no return any results",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text(
                        "maybe try:",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "1. make sure you input is correct",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "2. check your internet connection",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "3. WRITE A FKN GOOD QUERY BRUH",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: ThemeSwitcher(
              builder: (context) => FloatingActionButton(
                onPressed: (){
                  ThemeSwitcher.of(context).changeTheme(
                      theme: dark ? ThemeData.light() : ThemeData.dark()
                  );
                  dark = !dark;
                },
                splashColor: dark ? const Color.fromARGB(255, 61, 61, 61) : const Color.fromARGB(255, 238, 238, 238),
                backgroundColor: dark ? const Color.fromARGB(255, 238, 238, 238) : const Color.fromARGB(255, 61, 61, 61),
                elevation: 15,
                child: Icon(
                    dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined
                ),
              )
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  int getNumPages(){
    return resultList.length ~/ itemsPerPage + (resultList.length % itemsPerPage != 0 ? 1 : 0);
  }
}