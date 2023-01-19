import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login_form.dart';

class FormsPanel extends StatefulWidget {
  const FormsPanel({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<FormsPanel> createState() => _FormsPanelState();
}

class _FormsPanelState extends State<FormsPanel> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isPortrait = constraints.maxWidth < constraints.maxHeight;
        double aspectRatio = isPortrait
            ? constraints.maxWidth / constraints.maxHeight
            : constraints.maxHeight / constraints.maxWidth;
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: Hero(
            tag: "MainPage",
            child: Card(
              elevation: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(
                    child: LoginForm(
                      width: 800,
                      height: 500,
                    ),
                  ),
                  if (aspectRatio < 0.6)
                    VerticalDivider(
                      indent: widget.height / 6,
                      endIndent: widget.height / 6,
                    ),
                  if (aspectRatio < 0.6)
                    Lottie.asset(
                      "assets/animations/online-learning.json",
                      frameRate: FrameRate(60), //ACHRAF added this
                      repeat: true,
                      height: widget.height / 2,
                      width: widget.width / 2,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class SignUpToogle extends StatefulWidget {
//   const SignUpToogle({Key? key}) : super(key: key);

//   @override
//   State<SignUpToogle> createState() => _SignUpToogleState();
// }

// class _SignUpToogleState extends State<SignUpToogle> {
//   bool isLogin = true;
//   @override
//   Widget build(BuildContext context) => isLogin
//       ? 
//       : SignUpForm(
//           onClickSignUp: toggle,
//           width: 800,
//           height: 500,
//         );

//   void toggle() {
//     setState(() => isLogin = !isLogin);
//   }
// }
