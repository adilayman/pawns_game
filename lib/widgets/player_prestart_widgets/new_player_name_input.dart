import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPlayerNameInput extends StatelessWidget {
  final Function onSubmitted;

  const NewPlayerNameInput({Key? key, required this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 35,
      child: TextField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
        ),
        onSubmitted: (value) {
          onSubmitted(value);
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: [],
          ); // go back to full screen
        },
        // do the same procedure as in [onSumbitted] to save the input without
        // the need to submit it.
        onChanged: (value) => onSubmitted(value),
      ),
    );
  }
}
