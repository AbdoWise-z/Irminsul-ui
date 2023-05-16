import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/Info.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultItem extends StatelessWidget {
  final bool highlight;
  final String title;
  final String link;
  final List paragraph;
  final List bold;
  final double score;

  const SearchResultItem({Key? key, required this.highlight, required this.title, required this.link, required this.paragraph, required this.bold, required this.score}) : super(key: key);

  Future<void> _launchUrl() async {
    //print(url);
    String url = link;
    if(!url.contains("https://") && !url.contains("http://")){
      url = "https://$url";
    }

    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        color: dark? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 220, 220, 220),
        child: InkWell(
          onTap: (){
            _launchUrl();
          },
          hoverColor: dark? const Color.fromARGB(255, 48, 48, 48) : const Color.fromARGB(255, 215, 215, 215),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: null,

                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: highlight ? Colors.blueAccent : Colors.transparent,
                          width: 2.5,
                        )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: SelectableText.rich(
                          TextSpan(
                              text: utf8.decode(title.codeUnits , allowMalformed: true),
                              style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: SelectableText.rich(
                          TextSpan(
                              text: link,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blueAccent[100]
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: SelectableText.rich(
                            TextSpan(
                              children: List.generate(
                                paragraph.length,
                                    (index) {
                                  String str = paragraph[index];
                                  return TextSpan(
                                    text: utf8.decode(str.codeUnits , allowMalformed: true) ,
                                    style: TextStyle(
                                        fontWeight: bold[index] ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 14,
                                        color: dark ? Color.fromARGB(255, 240, 240, 240) : Color.fromARGB(255, 0, 0, 0)
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      SelectableText(
                        "Score: $score",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.blueAccent[100]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
