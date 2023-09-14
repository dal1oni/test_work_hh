import 'package:flutter/material.dart';

class Feature extends StatelessWidget {
  final String featureText;

  Feature({required this.featureText});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Material(
      color: const Color(0xFFFBFBFC),
      child: Text(
        featureText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16 * fem,
          fontWeight: FontWeight.w500,
          color: const Color(0xff828796),
        ),
      ),
    );
  }
}
