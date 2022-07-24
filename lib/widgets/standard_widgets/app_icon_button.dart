import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;

  const AppIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(7),
          primary: secondaryColor,
        ),
        child: Icon(
          icon,
          color: primaryColor,
        ),
      ),
    );
  }
}
