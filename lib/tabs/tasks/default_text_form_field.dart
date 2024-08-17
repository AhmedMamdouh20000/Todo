import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  DefaultTextFormField({
    required this.controller,
    required this.hintText,
    this.validator,
    this.maxLines,
  });

  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // minLines: 1,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
