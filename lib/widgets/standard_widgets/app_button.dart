import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final double fontsize;
  final String text;
  final void Function() onPressed;
  final Color color = const Color.fromRGBO(0, 5, 25, 0.3);

  const AppButton({
    Key? key,
    this.width = 165,
    this.height = 65,
    this.fontsize = 16,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          primary: color,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Spaceboards",
            fontWeight: FontWeight.bold,
            fontSize: fontsize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
