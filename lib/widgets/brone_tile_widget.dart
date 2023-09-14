import 'package:flutter/material.dart';

class BroneList extends StatelessWidget {
  BroneList({required this.info, required this.data});

  final String info;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Expanded(
          child: Text(
            info,
            style: TextStyle(
              fontSize: 16 * fem,
              color: const Color(0xFF828796),
            ),
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: TextStyle(
              fontSize: 16 * fem,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
