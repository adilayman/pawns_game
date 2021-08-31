import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPlayerNameInput extends StatelessWidget {
  final Function onSubmitted;

  NewPlayerNameInput({@required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
        ),
        onSubmitted: (value) {
          onSubmitted(value);
          SystemChrome.setEnabledSystemUIOverlays([]); // go back to full screen
        },
        // do the same procedure as in [onSumbitted] to save the input without
        // the need to submit it.
        onChanged: (value) => onSubmitted(value),
      ),
    );
  }
}
