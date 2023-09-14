import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_work_hh/server_communication.dart';
import 'package:intl/intl.dart';
import 'package:test_task_work_hh/widgets/room_card.dart';
import 'package:test_task_work_hh/widgets/hotel_features_widget.dart';
import 'package:test_task_work_hh/widgets/brone_tile_widget.dart';
import 'package:ru_phone_formatter/ru_phone_formatter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:test_task_work_hh/widgets/tourist_card.dart';
import 'package:test_task_work_hh/widgets/final_price.dart';
import 'payment_screen.dart';

const broneLink = 'e8868481-743f-4eb2-a0d7-2bc4012275c8';

class Check extends ChangeNotifier {
  bool check = false;
  bool checkBayer = false;
  bool isBayerOkay = false;

  List<TouristCard> tourists = [
    TouristCard(
      touristNumber: 1,
    ),
  ];

  bool isEveryTouristDataIsFill() {
    for (var t in tourists) {
      if (!t.isEverythingFill()) {
        return false;
      }
    }
    return true;
  }

  void addTourist(counter) {
    tourists.add(
      TouristCard(
        touristNumber: counter,
        check: check,
      ),
    );
    notifyListeners();
  }

  Color chooseColor(isEmpty) {
    if (check && isEmpty) {
      return Color(0x24EB5757);
    } else if (check && !isEmpty) {}
    return Color(0xfff6f6f9);
  }

  Color chooseColorBayer(isEmpty) {
    if (checkBayer && isEmpty) {
      isBayerOkay = false;
      return Color(0x24EB5757);
    } else if (checkBayer && !isEmpty) {
      isBayerOkay = true;
    }
    return Color(0xfff6f6f9);
  }

  void notCheckBayers() {
    checkBayer = false;
    notifyListeners();
  }

  void checkBayers() {
    checkBayer = true;
    notifyListeners();
  }

  void notCheckFields() {
    check = false;
    notifyListeners();
  }

  void checkFields() {
    check = true;
    notifyListeners();
  }
}

class BroneScreen extends StatefulWidget {
  @override
  State<BroneScreen> createState() => _BroneScreenState();
}

class _BroneScreenState extends State<BroneScreen> {
  @override
  initState() {
    getData();
    super.initState();
  }

  Data data = Data(broneLink);

  final maskFormatter = RuPhoneInputFormatter();
  dynamic rating = '';
  dynamic ratingName = '';
  dynamic hotelName = '';
  dynamic hotelAddress = '';
  dynamic flyFrom = '';
  dynamic flyTo = '';
  dynamic tourDateStart = '';
  dynamic tourDateStop = '';
  dynamic numberOfNights = '';
  dynamic room = '';
  dynamic eat = '';
  dynamic tourPrice = '';
  dynamic fuelPrice = '';
  dynamic servicePrice = '';
  dynamic sum = '';
  var email = "fredrik@gmail.com";

  void getData() async {
    dynamic broneData = await data.getDataHotel();
    setState(
      () {
        rating = broneData['horating'];
        ratingName = broneData['rating_name'];
        hotelName = broneData['hotel_name'];
        hotelAddress = broneData['hotel_adress'];
        flyFrom = broneData['departure'];
        flyTo = broneData['arrival_country'];
        tourDateStart = broneData['tour_date_start'];
        tourDateStop = broneData['tour_date_stop'];
        numberOfNights = broneData['number_of_nights'];
        room = broneData['room'];
        eat = broneData['nutrition'];
        tourPrice = NumberFormat.decimalPattern()
            .format(broneData['tour_price'])
            .replaceAll(',', ' ');
        fuelPrice = NumberFormat.decimalPattern()
            .format(broneData['fuel_charge'])
            .replaceAll(',', ' ');
        servicePrice = NumberFormat.decimalPattern()
            .format(broneData['service_charge'])
            .replaceAll(',', ' ');
        sum = NumberFormat.decimalPattern()
            .format(broneData['service_charge'] +
                broneData['fuel_charge'] +
                broneData['tour_price'])
            .replaceAll(',', ' ');
      },
    );
  }

  int touristCounter = 1;

  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  bool phoneIsEmpty = true;
  bool mailIsEmpty = true;

  bool isEmail(String em) {
    String p = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}";

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Consumer<Check>(
        builder: (BuildContext context, check, Widget? child) {
      return Scaffold(
        backgroundColor: const Color(0xFFF6F6F9),
        appBar: AppBar(
          title: const Text(
            'Бронирование',
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
                margin: EdgeInsets.symmetric(vertical: 5 * fem),
                padding: EdgeInsets.all(16 * fem),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
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
                    Padding(
                      padding: EdgeInsets.only(top: 8 * fem),
                      child: Text(
                        hotelName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22 * fem,
                        ),
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
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5 * fem),
                padding: EdgeInsets.all(16 * fem),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15 * fem),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: BroneList(info: 'Вылет из', data: flyFrom),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: BroneList(info: 'Страна, город', data: flyTo),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: BroneList(
                          info: 'Даты', data: '$tourDateStart-$tourDateStop'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: BroneList(
                          info: 'Кол-во ночей', data: '$numberOfNights ночей'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: BroneList(info: 'Отель', data: hotelName),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: BroneList(info: 'Номер', data: room),
                    ),
                    BroneList(info: 'Питание', data: eat),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5 * fem),
                padding: EdgeInsets.all(16 * fem),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16 * fem),
                      child: Text(
                        'Информация о покупателе',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22 * fem,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: fem * 8.0),
                      child: TextField(
                        controller: phoneController,
                        onChanged: (newValue) {
                          if (phoneController.text.isNotEmpty) {
                            setState(() {
                              phoneIsEmpty = false;
                            });
                          } else {
                            setState(() {
                              phoneIsEmpty = true;
                            });
                          }
                        },
                        inputFormatters: [maskFormatter],
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: '+7 (***) ***-**-**',
                          labelStyle: TextStyle(
                              color: const Color(0xFFA9ABB7),
                              fontSize: 17 * fem,
                              fontWeight: FontWeight.w400),
                          floatingLabelStyle: TextStyle(
                              color: const Color(0xFFA9ABB7),
                              fontSize: 17 * fem,
                              fontWeight: FontWeight.w400),
                          labelText: 'Номер телефона',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          filled: true,
                          fillColor: check.chooseColorBayer(phoneIsEmpty),
                          //const Color(0xfff6f6f9),
                        ),
                      ),
                    ),
                    TextField(
                      controller: mailController,
                      onChanged: (newValue) {
                        if (mailController.text.isNotEmpty) {
                          setState(() {
                            mailIsEmpty = false;
                          });
                        } else {
                          setState(() {
                            mailIsEmpty = true;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: const Color(0xFFA9ABB7),
                            fontSize: 17 * fem,
                            fontWeight: FontWeight.w400),
                        floatingLabelStyle: TextStyle(
                            color: const Color(0xFFA9ABB7),
                            fontSize: 17 * fem,
                            fontWeight: FontWeight.w400),
                        labelText: 'Почта',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10 * fem),
                        ),
                        filled: true,
                        fillColor: check.chooseColorBayer(mailIsEmpty),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: check.tourists,
              ),
              Container(
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
                        Text(
                          'Добавить туриста',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22 * fem,
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(6 * fem),
                          color: const Color(0xFF0D72FF),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            iconSize: 28 * fem,
                            onPressed: () {
                              setState(() {
                                //  check.checkFields();
                                touristCounter++;
                                check.addTourist(touristCounter);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5 * fem),
                padding: EdgeInsets.all(16 * fem),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15 * fem),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: PriceList(info: 'Тур', data: '$tourPrice ₽'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: PriceList(
                          info: 'Топливный сбор', data: '$fuelPrice ₽'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: PriceList(
                          info: 'Сервисный сбор', data: '$servicePrice ₽'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8 * fem),
                      child: PriceList(
                        info: 'К оплате',
                        data: '$sum ₽',
                        color: const Color(0xFF0D72FF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: TextButton(
            onPressed: () {
              setState(() {
                if (check.isEveryTouristDataIsFill() &&
                    isEmail(mailController.text)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(),
                    ),
                  );
                }
                check.checkFields();
                check.checkBayers();
              });
              //  check.goNext();
              //    print(check.isBayerOkay);
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
                    'Оплатить $sum ₽',
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
      );
    });
  }
}
