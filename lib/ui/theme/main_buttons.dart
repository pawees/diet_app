import 'package:flutter/material.dart';

final styleBtn = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        foregroundColor: MaterialStateProperty.all(Colors.white),
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

ElevatedButton mainBtn(context,on_pressed){
  return ElevatedButton(
              style: styleBtn2,
              onPressed: on_pressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Следующий'),
                ],
              ),
                      );

}
ElevatedButton formedBtn(context,on_pressed){
  return ElevatedButton(
              style: styleBtn,
              onPressed: on_pressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Готово'),
                ],
              ),
                      );

}