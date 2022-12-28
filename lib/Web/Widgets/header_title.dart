import 'package:flutter/material.dart';

class HeaderButton extends StatefulWidget {
  const HeaderButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});

  final String text;
  final IconData icon;
  final VoidCallback onPressed;
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
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                children: [
                  Icon(
                    widget.icon,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    height: 2,
                    width: _controller.value * 50,
                    color: Colors.white,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
