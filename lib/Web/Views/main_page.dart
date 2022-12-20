import 'package:flutter/material.dart';

import '../colors.dart';

class MainWebPage extends StatefulWidget {
  const MainWebPage({super.key});

  @override
  State<MainWebPage> createState() => _MainWebPageState();
}

class _MainWebPageState extends State<MainWebPage> {
  Widget _buildHeader(Size size) {
    return Container(
      color: WebColors.mainColor,
      height: size.height * 0.1,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: const [
          FlutterLogo(
            size: 20,
          ),
          Spacer(),
          HeaderButton(text: "Home"),
          HeaderButton(text: "Settings"),
          HeaderButton(text: "About"),
          HeaderButton(text: "Contact"),
        ],
      ),
    );
  }

  Widget _buildFooter(Size size) {
    return Container(
      color: WebColors.secondaryColor,
      width: double.infinity,
      height: size.height * 0.4,
      child: Row(
        children: const [
          Expanded(child: Placeholder()),
          Expanded(child: Placeholder()),
          Expanded(child: Placeholder()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(size),
              SizedBox(
                height: size.height,
              ),
              _buildFooter(size),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderButton extends StatefulWidget {
  const HeaderButton({super.key, required this.text});

  final String text;
  @override
  State<HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<HeaderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => _controller.forward(),
      onExit: (event) => _controller.reverse(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.text),
            const Spacer(),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  height: 2,
                  width: _controller.value * 40,
                  color: Colors.black,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
