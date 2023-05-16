
import 'package:flutter/material.dart';
import 'package:project/Info.dart';

class SearchTextField extends StatefulWidget {

  final FocusNode? focusNode;
  final void Function()? onPressed;
  final Color bodyColor;
  final Color innerColor;

  const SearchTextField({Key? key , this.focusNode ,this.onPressed,required this.bodyColor,required this.innerColor}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: (dark)? Colors.white: Colors.lightGreen,),
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: (tapped) ? const BorderRadius.vertical(top: Radius.circular(30)) : BorderRadius.circular(30)),
        clipBehavior: Clip.hardEdge,
        color: widget.bodyColor,
        child: InkWell(
          onFocusChange: (bool tap){
            setState(() {
              tapped = tap;
              //print('tapped = $tapped');
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              style: TextStyle(
                  color: widget.innerColor,
              ),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: widget.innerColor,
                    icon: const Icon(Icons.search),
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    onPressed: widget.onPressed,
                    disabledColor: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  hintStyle: TextStyle(
                      color: widget.innerColor,
                  ),
                  hintText: '     Enter Text ...',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.bodyColor,
                    ),
                    borderRadius: (tapped)? const BorderRadius.vertical(top: Radius.circular(30)) : BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.bodyColor,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30))
                  )
              ),
              controller: controller,
              focusNode: widget.focusNode,
              // onChanged: (String s){
              //   print(s);
              // },
            ),
          ),
        ),
      ),
    );
  }
}
