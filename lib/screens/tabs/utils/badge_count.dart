import 'package:flutter/material.dart';

/// Custom UI para mostrar la cantidad de mensajes no leidos
class BadgeCount extends StatelessWidget {

  final int count;
 // final int totalCount;

  const BadgeCount({
    Key? key,
    required this.count,
   //required this.totalCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox();
    final label = count <= 99 ? '$count' : '99+';
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(24),
      ),
      constraints: BoxConstraints(minWidth: 20, maxHeight: 20),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            shadows: const [
              Shadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                blurRadius: 2,
              )
            ]
        ),
      ),
    );
  }
}