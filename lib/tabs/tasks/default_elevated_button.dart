import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  String label;

  VoidCallback onPressed;

  DefaultElevatedButton({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom( fixedSize: Size(
        MediaQuery.of(context).size.width,
        52,
      ),),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.white,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
