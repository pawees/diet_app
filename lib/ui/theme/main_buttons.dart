import 'package:flutter/material.dart';

final styleBtn = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        )));

ElevatedButton mainBtn(context,on_pressed){
  return ElevatedButton(
              style: styleBtn,
              onPressed: on_pressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                     Icons.add,
                     color: Colors.white,
                     size: 24.0,
                      ),
                  SizedBox(width: 10),
                  Text('Готово'),
                ],
              ),
                      );

}