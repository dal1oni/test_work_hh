import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:test_task_work_hh/screens/room_screen.dart';
import 'package:test_task_work_hh/server_communication.dart';
import 'package:intl/intl.dart';
import 'package:test_task_work_hh/widgets/hotel_features_widget.dart';
import 'package:test_task_work_hh/widgets/info_button.dart';

const hotelLink = '35e0d18e-2521-4f1b-a575-f0fe366f66e3';

class HotelScreen extends StatefulWidget {
  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  @override
  initState() {
    getData();
    super.initState();
  }

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  Data data = Data(hotelLink);

  dynamic imageUrls = [];
  dynamic rating = '';
  dynamic ratingName = '';
  dynamic hotelName = '';
  dynamic hotelAddress = '';
  dynamic minimalPrice = '';
  dynamic priceFor = '';
  dynamic hotelFeatures = [];
  dynamic hotelDescription = '';

  List<Widget> listOfHotelFeatures = [];

  void getData() async {
    dynamic hotelData = await data.getDataHotel();
    setState(
      () {
        imageUrls = hotelData['image_urls'];
        rating = hotelData['rating'];
        ratingName = hotelData['rating_name'];
        hotelName = hotelData['name'];
        hotelAddress = hotelData['adress'];
        minimalPrice = hotelData['minimal_price'];
        minimalPrice = NumberFormat.decimalPattern()
            .format(minimalPrice)
            .replaceAll(',', ' ');
        priceFor = hotelData['price_for_it'];
        hotelFeatures = hotelData['about_the_hotel']['peculiarities'];
        for (String featureText in hotelFeatures) {
          listOfHotelFeatures.add(
            Feature(
              featureText: featureText,
            ),
          );
        }
        hotelDescription = hotelData['about_the_hotel']['description'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomScreen(hotelName: hotelName),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15 * fem),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xFF0D72FF),
                borderRadius: BorderRadius.circular(15 * fem),
              ),
              child: Padding(
                padding: EdgeInsets.all(15 * fem),
                child: Text(
                  'К выбору номера',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * fem),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        title: const Text(
          'Отель',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12 * fem),
                  bottomRight: Radius.circular(12 * fem),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(16 * fem, 0 * fem, 16 * fem, 16 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 257 * fem,
                          child: PageView.builder(
                              itemCount: imageUrls.length,
                              controller: _pageController,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(15 * fem),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageUrls[index]),
                                    ),
                                  ),
                                ));
                              },
                              onPageChanged: (int index) {
                                _currentPageNotifier.value = index;
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
                                    currentPageNotifier: _currentPageNotifier,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16 * fem, 0, 16 * fem),
                      child: Material(
                        color: const Color(0xFFFFF4CD),
                        borderRadius: BorderRadius.circular(5 * fem),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 5 * fem, 10 * fem, 5 * fem),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 15 * fem,
                                color: const Color(0xFFFFA800),
                              ),
                              Text(
                                ' $rating $ratingName',
                                style: TextStyle(
                                  fontSize: 15 * fem,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFFA800),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      hotelName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22 * fem,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {},
                      child: Text(
                        hotelAddress,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14 * fem,
                          color: const Color(0xFF0D72FF),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text(
                          'от $minimalPrice ₽ ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30 * fem,
                          ),
                        ),
                        Text(
                          priceFor.toString().toLowerCase(),
                          style: TextStyle(
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF828796),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12 * fem),
              padding:
                  EdgeInsets.fromLTRB(16 * fem, 16 * fem, 15 * fem, 16 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 15 * fem),
                    child: Text(
                      'Об отеле',
                      style: TextStyle(
                        fontSize: 22 * fem,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8 * fem,
                    direction: Axis.horizontal,
                    children: listOfHotelFeatures,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0 * fem, 15 * fem, 0 * fem, 0),
                    child: Text(
                      hotelDescription,
                      style: TextStyle(
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xe5000000),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBFBFC),
                      borderRadius: BorderRadius.circular(15 * fem),
                    ),
                    child: Column(
                      //Сделать что-то с тем что divider далеко от колонки
                      children: [
                        InfoButton(
                            text: 'Удобства',
                            imageIcon: 'assets/emoji-happy.jpg'),
                        InfoButton(
                            text: 'Что включено',
                            imageIcon: 'assets/tick-square.jpg'),
                        InfoButton(
                            text: 'Что не включено',
                            imageIcon: 'assets/close-square.jpg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
