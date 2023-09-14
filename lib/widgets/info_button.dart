import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final String text;
  final String imageIcon;

  InfoButton({required this.text, required this.imageIcon});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () {},
      child: Column(
        children: [
          ListTile(
            leading: Image(
              image: AssetImage(imageIcon),
            ),
            title: Text(
              text,
              style: TextStyle(
                fontSize: 16 * fem,
                fontWeight: FontWeight.w500,
                color: Color(0xff2c3035),
              ),
            ),
            subtitle: Text(
              'Самое необходимое',
              style: TextStyle(
                fontSize: 14 * fem,
                fontWeight: FontWeight.w500,
                color: Color(0xff828696),
              ),
            ),
            trailing: Icon(
              Icons.navigate_next,
              size: 24 * fem,
            ),
          ),
          Divider(
            indent: MediaQuery.of(context).size.width * 0.15,
            endIndent: MediaQuery.of(context).size.width * 0.07,
            color: const Color(0xFF828796),
          ),
        ],
      ),
    );
  }
}
