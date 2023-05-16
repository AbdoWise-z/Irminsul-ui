
import 'package:flutter/material.dart';
import 'package:project/CustomWidgets/ThemedSearchTextField.dart';
import '../Info.dart';
import 'package:project/CustomWidgets/SearchTextField.dart';

class ThemedSearchBar extends StatefulWidget {

  final void Function(String)? onSuggestionSelected;
  final void Function()? onEnterPressed;
  final void Function(String)? onEdit;

  ThemedSearchBar({Key? key,this.onEnterPressed,this.onSuggestionSelected , this.onEdit }) : super(key: key);

  @override
  State<ThemedSearchBar> createState() => _ThemedSearchBarState();
}

class _ThemedSearchBarState extends State<ThemedSearchBar> {

  final FocusNode focusNode = FocusNode();
  bool openBottom = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: RawAutocomplete(
        focusNode: focusNode,
        textEditingController: controller,
        optionsBuilder: (TextEditingValue textEditingValue) {
          List<String> matches = <String>[];
          matches.addAll(suggestionList.map((e) => e["Query"]));
          matches.retainWhere((s){
            return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
          if (openBottom != matches.isNotEmpty){
            setState(() {
              openBottom = matches.isNotEmpty;
            });
          }
          return matches;
        },
        onSelected: widget.onSuggestionSelected,
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return ThemedSearchTextField(
            focusNode: focusNode,
            onPressed: widget.onEnterPressed,
            onEdit: widget.onEdit,
            openBottom: openBottom && focusNode.hasFocus,
          );
        },
        optionsViewBuilder: (BuildContext context, void Function(String) onSelected,
            Iterable<String> options) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Material(
              elevation: 10,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: options.take(5).map((opt){
                        return InkWell(
                          onTap: (){
                            onSelected(opt);
                          },
                          child: Container(
                            width: 700,
                            padding: const EdgeInsets.fromLTRB(15, 10, 30, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.search, color: Color.fromARGB(
                                        255, 98, 58, 0),size: 20,),
                                    const SizedBox(width: 20,),
                                    FittedBox(
                                      child: SizedBox(
                                          width: 607,
                                          child: Text(opt)
                                      ),
                                    ),
                                  ],
                                ),
                                // const Divider(
                                //     color: Colors.lightGreen
                                // ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15,)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
