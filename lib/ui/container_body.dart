import 'package:flutter/material.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: children,
        ),
      ),
    );
  }
}
