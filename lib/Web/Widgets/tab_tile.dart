import 'package:flutter/material.dart';

class TabTile extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final bool isSmall;

  const TabTile(
      {Key? key,
      required this.isSelected,
      required this.text,
      required this.icon,
      required this.isSmall})
      : super(key: key);

  @override
  State<TabTile> createState() => _TabTileState();
}

class _TabTileState extends State<TabTile> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _hovering = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) {
            _controller.forward();
            setState(() {
              _hovering = true;
            });
          },
          onExit: (_) {
            _controller.reverse();
            setState(() {
              _hovering = false;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 4,
                  height: widget.isSelected ? 20 : 20 * _animation.value,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(4)),
                    color: widget.isSelected
                        ? Theme.of(context).primaryColor
                        : (_hovering
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                ),
                const SizedBox(width: 15),
                Icon(
                  widget.icon,
                  color: widget.isSelected
                      ? Theme.of(context).primaryColor
                      : (_hovering
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                  size: 22,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
