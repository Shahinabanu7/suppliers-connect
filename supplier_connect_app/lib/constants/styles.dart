import 'package:flutter/material.dart';

class Styles {
  normalS(
      {required double fontS,
        required FontWeight fontW,
        required Color color,
        required String fontF,
        required FontStyle fontStl}) {
    return  TextStyle(
        fontSize: fontS,
        fontWeight: fontW ,
        color: color,
        fontFamily: fontF,
        height: 1.2,
        fontStyle: fontStl
    );
  }

  normalHeight(
      {required double fontS,
        required FontWeight fontW,
        required Color color,
        required String fontF,
        required FontStyle fontStl}) {
    return  TextStyle(
        fontSize: fontS,
        fontWeight: fontW ,
        color: color,
        fontFamily: fontF,
        height: 1.2,
        fontStyle: fontStl
    );
  }

  normalSWithUnderline(
      {required double fontS,
        required FontWeight fontW,
        required Color color,
        required String fontF,
        required FontStyle fontStl}) {
    return  TextStyle(
        fontSize: fontS,
        fontWeight: fontW ,
        color: color,
        fontFamily: fontF,
        height: 1.2,
        fontStyle: fontStl,
        decoration: TextDecoration.underline
    );
  }
}
