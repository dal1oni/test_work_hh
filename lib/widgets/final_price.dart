import 'package:flutter/material.dart';

class PriceList extends StatelessWidget {
  PriceList({required this.info, required this.data, this.color});

  final String info;
  final dynamic data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text(
          info,
          style: TextStyle(
            fontSize: 16 * fem,
            color: const Color(0xFF828796),
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 16 * fem,
            color: color,
          ),
        ),
      ],
    );
  }
}
