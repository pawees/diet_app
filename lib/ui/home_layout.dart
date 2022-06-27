import 'package:flutter/material.dart';
import 'package:game_app_training/ui/auth_widget/authWidget.dart';
import 'package:game_app_training/ui/auth_widget/authErrorWidget.dart';
import 'package:game_app_training/ui/auth_widget/authPreloaderWidget.dart';

import 'package:game_app_training/ui/container_body.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HeaderTitle(),
          const SizedBox(height: 40.0),
          ContainerBody(
            children: [
              AuthWidget(),
              // LoginWidget(),
            ],
          )
        ],
      ),
    );
  }
}
