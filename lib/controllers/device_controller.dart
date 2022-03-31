import 'package:get/get.dart';
import 'package:superhands_app/services/api_service.dart';
import 'package:superhands_app/utils/dialogs.dart';

class DeviceController extends GetxController {
  var ip = ''.obs;

  void getMyIP() async {
    try {
      ip.value = await ApiService.getMyIP();
    } catch (e) {
      MyDialogs.error("failed to get your IP", "Try again");
    }
  }


}
