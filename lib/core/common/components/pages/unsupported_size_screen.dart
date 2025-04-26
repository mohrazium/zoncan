
import 'package:flutter/material.dart';

class UnsupportedSizeScreen extends StatelessWidget {
  const UnsupportedSizeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error_outline,
                size: 100,
                color: Colors.amber,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "اندازه صفحه نمایش پشتیبانی نمی شود.",
                style: TextStyle(
                    color: Colors.amber, fontSize: 18, fontFamily: 'B Titr'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
