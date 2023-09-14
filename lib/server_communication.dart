import 'network.dart';

const server = 'https://run.mocky.io/v3/';

class Data {
  Data(this.link);
  final String link;

  Future<dynamic> getDataHotel() async {
    var url = '$server$link';
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getData();
    return data;
  }
}
