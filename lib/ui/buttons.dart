import 'package:flutter/cupertino.dart';

class Buttons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTap;
  const Buttons({this.color, this.textColor, required this.buttonText, this.buttonTap});

  @override
  Widget build(BuildContext context) {

    return
      GestureDetector(
        onTap: buttonTap,
          child: Padding(
            padding: EdgeInsets.all(7.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                alignment: Alignment.center,
                color: color,
                child: Text(
                  buttonText,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18
                  ),
                ),

              ),
            ),
          )
      );
  }
}
