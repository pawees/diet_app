import 'dart:ffi';

import 'package:flutter/material.dart';

final styleBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xffF07C01)),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    elevation: MaterialStateProperty.all<double>(0),
    textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(11.0),
    )));

final styleBtn2 = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(11.0),
    )));

final styleGreyBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xffF2F2F7)),
    elevation: MaterialStateProperty.all<double>(0),
    foregroundColor:
        MaterialStateProperty.all(const Color.fromARGB(100, 114, 114, 114)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(11.0),
    )));

Container GreenBtn(context, on_pressed,String text) {
  return Container(
    height: 48,
    width: 152,
    child: ElevatedButton(
      style: styleBtn2,
      onPressed: on_pressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
        ],
      ),
    ),
  );
}

Container OrangeBtn(context, on_pressed, String text) {
  return Container(
    height: 48,
    width: 152,
    child: ElevatedButton(
      style: styleBtn,
      onPressed: on_pressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
        ],
      ),
    ),
  );
}

Container GreyBtn(context, on_pressed, String text) {
  return Container(
    height: 48,
    width: 152,
    child: ElevatedButton(
      style: styleGreyBtn,
      onPressed: on_pressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ImageIcon(
                AssetImage('assets/images/copy.png'),
                color: Color.fromARGB(255, 64, 105, 153),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: const Color.fromARGB(100, 114, 114, 114)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
