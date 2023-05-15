import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Info.dart';

class RippleTextFormField extends StatefulWidget {
  final Color ripple;
  final Color background;
  final double corners;
  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final EdgeInsets padding;
  final TextStyle? style;
  final bool autoFocus;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatter;
  final Function(String)? onSubmit;
  final Function()? onEditingComplete;
  final int? maxLength;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final String? initialText;
  final Function(bool)? onFocusChanged;



  RippleTextFormField({Key? key, this.ripple = Colors.blue, this.background = const Color(0x1200ff00), this.corners = 20, this.decoration, this.onChanged, this.controller, this.focusNode, this.padding = const EdgeInsets.fromLTRB(0 , 0, 0, 0), this.style, this.autoFocus = false, this.validator, this.formatter, this.keyboardType, this.onSubmit, this.onEditingComplete, this.maxLength, this.readOnly = false, this.maxLines, this.minLines,this.initialText,this.onFocusChanged,}) : super(key: key);

  @override
  State<RippleTextFormField> createState() => _RippleTextFormFieldState();
}

class _RippleTextFormFieldState extends State<RippleTextFormField> {


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: widget.ripple),
        child: Material(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: (tapped)? BorderRadius.vertical(top: Radius.circular(widget.corners)) : BorderRadius.circular(widget.corners)),
          clipBehavior: Clip.hardEdge,
          color: widget.background,
          child: InkWell(
            onFocusChange: (bool tap){
              setState(() {
                tapped = tap;
                print('tapped = $tapped');
              });
            },
            child: Padding(
              padding: widget.padding,
              child: TextFormField(
                initialValue: widget.initialText,
                maxLength: widget.maxLength,
                validator: widget.validator,
                decoration: widget.decoration,
                onChanged: widget.onChanged,
                style: widget.style,
                autofocus: widget.autoFocus,
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.formatter,
                onEditingComplete: widget.onEditingComplete,
                onFieldSubmitted: widget.onSubmit,
                readOnly: widget.readOnly,
                maxLines: widget.maxLength,
                minLines: widget.minLines,
              ),
            ),
          ),
      ),
    );
  }
}
