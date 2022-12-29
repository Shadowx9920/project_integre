import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.height * 0.1),
            child: Lottie.asset(
              "assets/animations/work.json",
              frameRate: FrameRate(60),
              repeat: true,
            ),
          ),
        ],
      ),
    );
  }
}
