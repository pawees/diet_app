import 'package:flutter/material.dart';
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _prev_screen(){}
    return SafeArea(

      child: Column(
        children: [
                  Row(children: [
            IconButton(
                icon: ImageIcon(AssetImage('assets/images/chevron.png')),
                onPressed: _prev_screen),
            Transform(
              transform:  Matrix4.translationValues( MediaQuery.of(context).size.width/5, 0.0, 0.0),
              child: const Text('Список заявки',
                  style: TextStyle(
                    color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                          ),
            ),    
                ],),
            Divider(height: 3,)]

      ));
}
}