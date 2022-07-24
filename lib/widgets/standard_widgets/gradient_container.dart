import 'package:flutter/widgets.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color> colors;

  const GradientContainer({Key? key, required this.colors, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: colors,
        ),
      ),
      child: child,
    );
  }
}
