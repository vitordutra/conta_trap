import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final Widget child;
  final bool disabled;

  const FAB({
    Key? key,
    required this.child,
    required this.onPressed,
    this.size = 56,
    this.disabled = false,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: RawMaterialButton(
        shape: const CircleBorder(),
        fillColor: Colors.white,
        elevation: 4,
        child: child,
        onPressed: disabled ? null : onPressed,
      ),
    );
  }
}
