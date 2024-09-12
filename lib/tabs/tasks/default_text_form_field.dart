import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.maxLines =1 ,
    this.isPassWord = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool isPassWord ;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObSecure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      validator: widget.validator,
      obscureText: isObSecure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        suffixIcon: widget.isPassWord ? IconButton(
          onPressed: () {
            isObSecure =! isObSecure;
            setState(() {
            });
          },
          icon: Icon(
            isObSecure ? Icons.visibility_off : Icons.visibility,
          ),
        ): null,
        focusColor: AppTheme.backGroundColorDark,
        hintText: widget.hintText,
      ),
    );
  }
}
