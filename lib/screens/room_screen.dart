import 'package:flutter/material.dart';
import 'package:test_task_work_hh/server_communication.dart';
import 'package:intl/intl.dart';
import 'package:test_task_work_hh/widgets/room_card.dart';
import 'package:test_task_work_hh/widgets/hotel_features_widget.dart';
import 'package:test_task_work_hh/screens/brone_screen.dart';

const roomLink = 'f9a38183-6f95-43aa-853a-9c83cbb05ecd';

class RoomScreen extends StatefulWidget {
  RoomScreen({required this.hotelName});

  final String hotelName;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  dynamic numberName = '';
  dynamic imageUrls = [];
  dynamic priceForNumber = '';
  dynamic roomFeatures = [];
  dynamic pricePer = '';
  dynamic rooms = [];
  List<Widget> roomsCards = [];
  List<Widget> listOfRoomFeatures = [];
  final currentPageNotifier = ValueNotifier<int>(0);

  @override
  initState() {
    getData();
    super.initState();
  }

  Data data = Data(roomLink);

  void getData() async {
    dynamic roomData = await data.getDataHotel();
    setState(
      () {
        rooms = roomData['rooms'];
        roomsCards = rooms.map<Widget>((room) {
          List<Widget> listOfCurrentRoomFeatures = [];
          final ourCurrentPageNotifier = ValueNotifier<int>(0);
          for (String featureText in room['peculiarities']) {
            listOfCurrentRoomFeatures.add(
              Feature(
                featureText: featureText,
              ),
            );
          }
          return RoomCard(
            numberName: room['name'],
            imageUrls: room['image_urls'],
            priceForNumber: NumberFormat.decimalPattern()
                .format(room['price'])
                .replaceAll(',', ' '),
            pricePer: room['price_per'],
            listOfRoomFeatures: listOfCurrentRoomFeatures,
            currentPageNotifier: ourCurrentPageNotifier,
            callback: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BroneScreen()));
            },
          );
        }).toList();
        roomsCards = roomsCards.toList();
        numberName = rooms[0]['name'];
        imageUrls = rooms[0]['image_urls'];
        priceForNumber = rooms[0]['price'];
        priceForNumber = NumberFormat.decimalPattern()
            .format(priceForNumber)
            .replaceAll(',', ' ');
        pricePer = rooms[0]['price_per'];
        roomFeatures = rooms[0]['peculiarities'];
        for (String featureText in roomFeatures) {
          listOfRoomFeatures.add(
            Feature(
              featureText: featureText,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        title: Text(
          widget.hotelName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: roomsCards.toList(),
        ),
      ),
    );
  }
}
