import 'package:flutter/widgets.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 80,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'PAWNS GAME',
          style: TextStyle(
            fontFamily: "GearUp",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 5, 25, 0.6),
          ),
        ),
      ),
    );
  }
}
