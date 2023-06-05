import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  String title;
  CustomProgress({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Colors.redAccent,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
