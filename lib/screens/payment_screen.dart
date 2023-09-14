import 'package:flutter/material.dart';
import 'dart:math';

import 'package:test_task_work_hh/screens/hotel_screen.dart';

class Payment extends StatelessWidget {
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
              MaterialPageRoute(builder: (context) => HotelScreen()),
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
                  'Супер!',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Заказ оплачен',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 19 * fem),
            child: CircleAvatar(
              radius: 47 * fem,
              backgroundColor: Color(0xFFF6F6F9),
              child: Image(
                image: AssetImage('assets/Party_Popper.png'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 19 * fem),
            child: Text(
              'Ваш заказ принят в работу',
              style: TextStyle(
                fontSize: 22 * fem,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            'Подтверждение заказа №${Random().nextInt(300000)} может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
            style: TextStyle(
              fontSize: 16 * fem,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF828796),
            ),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
