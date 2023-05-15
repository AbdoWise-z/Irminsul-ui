
import 'package:flutter/material.dart';
import '../Info.dart';
import 'package:project/CustomWidgets/SearchTextField.dart';

class SearchBar extends StatefulWidget {

  final void Function(String)? onSuggestionSelected;
  final void Function()? onButtonPressed;
  final Color bodyColor;
  final Color innerColor;

  const SearchBar({Key? key,this.onButtonPressed,this.onSuggestionSelected,required this.bodyColor,required this.innerColor}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: RawAutocomplete(
        focusNode: FocusNode(),
        textEditingController: controller,
        optionsBuilder: (TextEditingValue textEditingValue) {
          List<String> matches = <String>[];
          matches.addAll(suggestionList.map((e) => e));
          matches.retainWhere((s){
            return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
          return matches;
        },
        onSelected: widget.onSuggestionSelected,
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return SearchTextField(
            focusNode: focusNode,
            onPressed: widget.onButtonPressed,
            bodyColor: widget.bodyColor,
            innerColor: widget.innerColor,
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
                            child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  width: 692,
                                  padding: const EdgeInsets.fromLTRB(15, 10, 30, 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.search, color: Colors.lightGreen,size: 20,),
                                          const SizedBox(width: 20,),
                                          FittedBox(
                                              child: SizedBox(
                                                  width: 607,
                                                  child: Text(opt)
                                              )
                                          ),
                                        ],
                                      ),
                                      // const Divider(
                                      //     color: Colors.lightGreen
                                      // ),
                                    ],
                                  ),
                                )
                            )
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
