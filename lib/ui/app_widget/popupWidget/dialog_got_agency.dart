import 'package:flutter/material.dart';


class AgencyWidget extends StatelessWidget {
  const AgencyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  elevation: 0,
  backgroundColor: Colors.transparent,
  child: contentBox(context),

    );
  }

  contentBox(content){
    return Column(children:[
      Row(
        children: [
          Text('Выберите учреждение'),
          Icon(Icons.abc)
          // List.builder
        ],
      )]
    );
  }
}