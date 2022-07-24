import 'package:flutter/widgets.dart';

class WinsIndicatorWidget extends StatelessWidget {
  final String wins;

  const WinsIndicatorWidget({Key? key, required this.wins}) : super(key: key);

  /// Creates an indicator widget.
  Widget _indicatorWidget(Widget child) {
    return SizedBox(height: 25, width: 25, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _indicatorWidget(Image.asset("assets/png/trophy.png")),
        _indicatorWidget(Text(wins, textAlign: TextAlign.center)),
      ],
    );
  }
}
