import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_work_hh/widgets/counter.dart';

import '../screens/brone_screen.dart';

class InfoText extends StatefulWidget {
  InfoText({
    required this.text,
    this.check = false,
  });

  final String text;
  final bool check;
  bool isEmpty = true;

  @override
  State<InfoText> createState() => _InfoTextState();
}

class _InfoTextState extends State<InfoText> {
  Color color = Color(0xFFEB5757);
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Consumer<Check>(
        builder: (BuildContext context, check, Widget? child) {
      return Padding(
        padding: EdgeInsets.only(bottom: fem * 8.0),
        child: TextField(
          onTap: () {
            check.checkBayers();
          },
          onChanged: (newValue) {
            if (textController.text.isNotEmpty) {
              setState(() {
                widget.isEmpty = false;
              });
            } else {
              setState(() {
                widget.isEmpty = true;
              });
            }
          },
          controller: textController,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: const Color(0xFFA9ABB7),
                fontSize: 17 * fem,
                fontWeight: FontWeight.w400),
            floatingLabelStyle: TextStyle(
                color: const Color(0xFFA9ABB7),
                fontSize: 17 * fem,
                fontWeight: FontWeight.w400),
            labelText: widget.text,
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10 * fem),
            ),
            filled: true,
            fillColor: check.chooseColor(widget.isEmpty),
          ),
        ),
      );
    });
  }
}

class TouristCard extends StatefulWidget {
  TouristCard({required this.touristNumber, this.check = false});
  final int touristNumber;
  final bool check;
  List<InfoText> infoTexts = [];
  bool isEverythingFill() {
    for (var infotext in infoTexts) {
      if (infotext.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  State<TouristCard> createState() => _TouristCardState();
}

class _TouristCardState extends State<TouristCard> {
  bool showMore = true;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    widget.infoTexts = [
      InfoText(
        text: 'Имя',
        check: widget.check,
      ),
      InfoText(
        text: 'Фамилия',
        check: widget.check,
      ),
      InfoText(
        text: 'Дата рождения',
        check: widget.check,
      ),
      InfoText(
        text: 'Гражданство',
        check: widget.check,
      ),
      InfoText(
        text: 'Номер загранпаспорта',
        check: widget.check,
      ),
      InfoText(
        text: 'Срок действия загранпаспорта',
        check: widget.check,
      )
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5 * fem),
      padding: EdgeInsets.all(16 * fem),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * fem),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.touristNumber < touristCounter.length)
                Text(
                  '${touristCounter[widget.touristNumber]!} турист',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22 * fem,
                  ),
                ),
              Material(
                borderRadius: BorderRadius.circular(6 * fem),
                color: const Color(0xfff6f6f9),
                child: IconButton(
                  icon: showMore
                      ? const Icon(Icons.expand_less)
                      : const Icon(Icons.expand_more),
                  color: const Color(0xFF0D72FF),
                  iconSize: 32 * fem,
                  onPressed: () {
                    setState(() {
                      showMore = !showMore;
                    });
                  },
                ),
              )
            ],
          ),
          if (showMore)
            SizedBox(
              height: 16 * fem,
            ),
          if (showMore) widget.infoTexts[0],
          // InfoText(
          //   text: 'Имя',
          //   check: widget.check,
          // ),
          if (showMore) widget.infoTexts[1],
          if (showMore) widget.infoTexts[2],
          if (showMore) widget.infoTexts[3],
          if (showMore) widget.infoTexts[4],
          if (showMore) widget.infoTexts[5],
        ],
      ),
    );
  }
}
