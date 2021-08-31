import 'package:flutter/widgets.dart';

class WinsIndicatorWidget extends StatelessWidget {
  final String wins;

  WinsIndicatorWidget({@required this.wins});

  /// Creates an indicator widget.
  Widget _indicatorWidget(Widget child) {
    return Container(height: 25, width: 25, child: child);
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
