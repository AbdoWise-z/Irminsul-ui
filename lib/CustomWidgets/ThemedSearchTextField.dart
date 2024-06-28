
import 'package:flutter/material.dart';

import '../Info.dart';

//imported from our


class ThemedSearchTextField extends StatefulWidget {

  final FocusNode? focusNode;
  final void Function()? onPressed;
  final void Function(String)? onEdit;
  bool openBottom = false;

  ThemedSearchTextField({Key? key , this.focusNode ,this.onPressed , this.onEdit , required this.openBottom}) : super(key: key);

  @override
  State<ThemedSearchTextField> createState() => _ThemedSearchTextFieldState();
}

class _ThemedSearchTextFieldState extends State<ThemedSearchTextField> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: dark ? const Color.fromARGB(255, 215, 215, 215) : const Color.fromARGB(
            255, 33, 33, 33),
      ),
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: (widget.openBottom) ? const BorderRadius.vertical(top: Radius.circular(30)) : BorderRadius.circular(30)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: dark ? const Color.fromARGB(255, 33, 33, 33) : const Color.fromARGB(
            255, 187, 187, 187),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              onEditingComplete: widget.onPressed ?? () {},
              onChanged: widget.onEdit,
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  onPressed: widget.onPressed ?? () {},
                  disabledColor: Colors.red,
                ),
                contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: (widget.openBottom)? const BorderRadius.vertical(top: Radius.circular(30)) : BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: (widget.openBottom)? const BorderRadius.vertical(top: Radius.circular(30)) : BorderRadius.circular(30),
                ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //       color: (dark) ? const Color.fromARGB(255, 33, 33, 33) : const Color.fromARGB(
                //       255, 141, 141, 141)
                //   ),
                //   borderRadius: (tapped)? const BorderRadius.vertical(top: Radius.circular(30)) : BorderRadius.circular(30),
                // ),
                hintText: 'Enter Text ...',
              ),
              controller: controller,
              focusNode: widget.focusNode,
            ),
          ),
        ),
      ),
    );
  }
}
