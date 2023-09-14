import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:test_task_work_hh/widgets/hotel_features_widget.dart';

class RoomCard extends StatelessWidget {
  RoomCard(
      {required this.numberName,
      required this.imageUrls,
      required this.priceForNumber,
      required this.pricePer,
      required this.listOfRoomFeatures,
      required this.currentPageNotifier,
      required this.callback});

  final dynamic numberName;
  final dynamic imageUrls;
  final dynamic priceForNumber;
  final dynamic pricePer;
  final dynamic listOfRoomFeatures;
  final dynamic currentPageNotifier;
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5 * fem),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * fem),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 16 * fem, 16 * fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10 * fem),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 257 * fem,
                    child: PageView.builder(
                        itemCount: imageUrls.length,
                        controller: PageController(),
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15 * fem),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageUrls[index]),
                                ),
                              ),
                            ),
                          );
                        },
                        onPageChanged: (int index) {
                          currentPageNotifier.value = index;
                        }),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 5.0 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5 * fem),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                10 * fem, 5 * fem, 10 * fem, 5 * fem),
                            child: CirclePageIndicator(
                              dotColor: const Color(0xFFC7C7C7),
                              selectedDotColor: Colors.black,
                              //    selectedDotColor: Colors.black,
                              itemCount: imageUrls.length,
                              currentPageNotifier: currentPageNotifier,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              numberName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22 * fem,
              ),
            ),
            Wrap(
              spacing: 8 * fem,
              direction: Axis.horizontal,
              children: listOfRoomFeatures,
            ),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {},
              child: Material(
                color: const Color(0xFFE7F1FF),
                borderRadius: BorderRadius.circular(5 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Подробнее о номере',
                      style: TextStyle(
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0D72FF),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_outlined,
                      size: 24 * fem,
                      color: const Color(0xFF0D72FF),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  '$priceForNumber ₽ ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30 * fem,
                  ),
                ),
                Text(
                  pricePer.toString().toLowerCase(),
                  style: TextStyle(
                    fontSize: 14 * fem,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF828796),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: callback,
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(top: 15 * fem),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D72FF),
                  borderRadius: BorderRadius.circular(15 * fem),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15 * fem),
                  child: Text(
                    'Выбрать номер',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16 * fem),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
