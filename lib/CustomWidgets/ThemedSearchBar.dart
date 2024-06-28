
import 'package:flutter/material.dart';
import '../Info.dart';
import 'ThemedSearchTextField.dart';

//fixme: issue related to Focus change , but I can't be bothered about it rn ...

class ThemedSearchBar extends StatefulWidget {

  final void Function(String)? onSuggestionSelected;
  final void Function()? onEnterPressed;
  final void Function(String)? onEdit;
  final List<String> suggestionList;

  const ThemedSearchBar({Key? key,this.onEnterPressed,this.onSuggestionSelected , this.onEdit, required this.suggestionList }) : super(key: key);

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

  List<String> matches = <String>[];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context , constraints) => RawAutocomplete<String>(
        focusNode: focusNode,
        textEditingController: controller,
        optionsBuilder: (TextEditingValue textEditingValue) {

          matches.clear();
          matches.addAll(widget.suggestionList); // <-- suggestions here

          matches.retainWhere((s){
            return s.toLowerCase().contains(textEditingValue.text.toLowerCase()) && !(s == textEditingValue.text);
          });

          if (openBottom != matches.isNotEmpty){
            setState(() {
              openBottom = matches.isNotEmpty;
            });
          }
          return matches;
        },
        onSelected: (str) {
          if (widget.onSuggestionSelected != null){
            widget.onSuggestionSelected!(str);
          }
          setState(() {
          });
        },
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return ThemedSearchTextField(
            focusNode: focusNode,
            onPressed: widget.onEnterPressed,
            onEdit: widget.onEdit,
            openBottom: openBottom && focusNode.hasFocus ,
          );
        },
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
            ),
            child: SizedBox(
              height: 52.0 * options.length,
              width: constraints.biggest.width, // <-- Right here !
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                shrinkWrap: false,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    customBorder: RoundedRectangleBorder(
                      borderRadius: index == options.length - 1 ? const BorderRadius.vertical(bottom: Radius.circular(25.0)) :  BorderRadius.zero,
                      side: BorderSide.none,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color.fromARGB(
                              255, 98, 58, 0),size: 20,),
                          const SizedBox(width: 20,),
                          Text(option),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}