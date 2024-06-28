
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:project/CustomWidgets/ThemedSearchBar.dart';
import 'package:http/http.dart' as http;
import '../Info.dart';
import 'dart:convert';

class Home2 extends StatelessWidget {
  const Home2({super.key});
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: dark ? ThemeData.dark() : ThemeData.light(),
      builder: (_ , theme) {
        return Home2Page();
      },
    );
  }
}

class Home2Page extends StatefulWidget {
  const Home2Page({Key? key}) : super(key: key);

  @override
  State<Home2Page> createState() => _Home2PagePageState();
}

class _Home2PagePageState extends State<Home2Page> {

  void search() {
    if (controller.text.isEmpty) {
      return;
    }
    setState(() {
      Navigator.pushNamed(context, "/results");
    });
  }

  bool sugLoading = false;
  String? sugNext;
  void getSuggestions(String str) async {
    //print("trying to get suggestions for : " + str);
    if (sugLoading){
      sugNext = str;
      return;
    }
    sugLoading = true;

    //load it here
    suggestionList.clear();

    //print("Loading suggestions");

    Uri url = Uri.http(serverAddress , "/Query" , {"q" : controller.text});
    var response = await http.get(url);

    if (response.body.isNotEmpty) {
      suggestionList = jsonDecode(response.body);
    }

    //print("Done suggestions");

    sugLoading = false;
    if (sugNext != null && sugNext != str){
      String q = sugNext!;
      sugNext = null;
      getSuggestions(q);

    }else{
      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();

    suggestionList.clear();

  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    List<String> sugg = [];
    for (var item in suggestionList){
      sugg.add(item["Query"]);
    }

    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: null,
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 0,
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        "assets/irminsul_white.png",
                        color: dark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(
                            255, 40, 40, 40),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 100,
                    height: 75,
                    child: Image.asset(
                      "assets/irminsul_text.png",
                      color: dark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(
                          255, 40, 40, 40),
                    ),
                  ),

                  Row(
                    children: [
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 4,
                        child: ThemedSearchBar(
                          onEnterPressed: () => search(),
                          onSuggestionSelected: (str) {
                            controller.text = str;
                            search();
                          },
                          onEdit: (str) {
                            getSuggestions(str);
                          },
                          suggestionList: sugg,
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: ThemeSwitcher(
              builder: (context) => SizedBox(
                width: 40,
                height: 40,
                child: FloatingActionButton(
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
                    dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    size: 20,
                  ),
                ),
              )
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}


