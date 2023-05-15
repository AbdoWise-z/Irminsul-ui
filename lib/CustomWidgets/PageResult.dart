
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' show utf8;

class PageResult extends StatelessWidget {

  String url;
  List subParagraphs;
  List toBoldIDs;
  // final String paragraph;
  final String title;
  final Color? paragraphColor;
  final Color? titleColor;
  final Color? linkColor;


  PageResult(this.url,this.subParagraphs,this.toBoldIDs,this.title,this.paragraphColor,this.titleColor,this.linkColor, {super.key});

  Future<void> _launchUrl() async {
    //print(url);
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
    List<TextSpan> subParagraphsSpan = [];

    for(int i = 0; i < subParagraphs.length; i++){
      String encoded = subParagraphs[i];
      String val = utf8.decode(encoded.codeUnits);

      subParagraphsSpan.add(TextSpan(
        text: val,
        style: TextStyle(
          fontWeight: (toBoldIDs[i] == true)? FontWeight.bold : FontWeight.normal,
          color: paragraphColor,
        )
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 350,
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: _launchUrl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(utf8.decode(title.codeUnits),
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                    ),
                  ),
                  Text(url,
                    style: const TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                  ),),
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Colors.transparent,
          elevation: 0,
          child: FittedBox(
             child: SizedBox(
               width: 700,
               child: RichText(
                 text: TextSpan(
                   children: subParagraphsSpan,
                 ),
               ),
             )
         ),
       )
      ],
    );
  }
}
