import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewText extends StatelessWidget {
  final Future<String>? textFuture;
  TextStyle? styles;
  NewText({super.key, this.textFuture, this.styles});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String>(
      future: textFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(snapshot.data.toString(), style: styles);
        }
      },
    );
  }
}


 buildOption1(Future<String> titleFuture)async {
  String newValue = await titleFuture;
  return  newValue;
}





 