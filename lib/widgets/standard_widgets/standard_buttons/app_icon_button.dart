import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;

  AppIconButton({
    required this.onPressed,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Icon(
          icon,
          color: primaryColor,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(7),
          primary: secondaryColor,
        ),
      ),
    );
  }
}
