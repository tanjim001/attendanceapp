import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget getStyledText(String text,BuildContext context) {
  return text
      .text
      .gray700
      .size(20)
      .semiBold
      .make()
      .box
      .gray100
      .roundedSM
      .width(MediaQuery.of(context).size.width)
      .padding(const EdgeInsets.only(left: 10, top: 5, bottom: 5))
      .border()
      .make();
}