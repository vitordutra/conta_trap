import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String text;
  final Widget child;

  const Badge({
    Key? key,
    required this.text,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColorDark;

    return Stack(
      children: <Widget>[
        child,
        Positioned(
          right: 0,
          child: Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
