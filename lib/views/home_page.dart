import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:superhands_app/utils/dialogs.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:superhands_app/controllers/device_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final deviceController = Get.put(DeviceController(), permanent: true);
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  Connectivity _connectivity = Connectivity();

  var active = false;
  String qrCode = '';

  void checkConnectivity() async {
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile) {
      MyDialogs.success("Mobile Network", "", seconds: 2);
    } else if (connectionResult == ConnectivityResult.wifi) {
      MyDialogs.success("Wifi Network", "", seconds: 2);
    } else {
      MyDialogs.error("No Internet", "Check Your Connectivity", seconds: 2);
    }
  }

  Future<void> resetAll() async {
    _ipController.clear();
    _portController.clear();

    setState(() {
      active = false;
      qrCode = '';
    });
  }

  //'192.168.0.12', 62687
  void connectTcpServer(String ip, int port) async {
    try {
      Socket socket = await Socket.connect(ip, port);
      MyDialogs.success('Connected to the TCP Server', "${ip}:${port}");
    } catch (e) {
      MyDialogs.error("Failed To Connect", "${ip}:${port}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Superhands App"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: RefreshIndicator(
          onRefresh: resetAll,
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SMART DEVICE CONTROLLER",
                    ),
                  )),
                ),
                SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: active
                          ? DecorationImage(
                              image: NetworkImage(
                                  "https://thumbs.dreamstime.com/b/abstract-blue-light-grid-technology-background-illu-illustration-design-65069866.jpg"),
                              fit: BoxFit.cover)
                          : null),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: active
                            ? Text("You're blinding me")
                            : Text("It's getting dark"),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            active = !active;
                          });
                          active ? _turnOnFlash() : _turnOffFlash();
                        },
                        backgroundColor: active ? Colors.red : Colors.white,
                        child: active
                            ? Icon(Icons.flashlight_on)
                            : Icon(Icons.flashlight_off),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {
                            checkConnectivity();
                          },
                          icon: Icon(Icons.network_check),
                          label: Text("Check connection"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {
                            _vibrate();
                          },
                          icon: Icon(Icons.vibration),
                          label: Text("Brrrr, It's freezing!"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple
                          ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Center(
                  child: TextButton(
                      onPressed: () {
                        deviceController.getMyIP();

                        Get.defaultDialog(
                          title: "Your Public IP:",
                          content: Obx(() => Text(deviceController.ip.value)),
                        );
                      },
                      child: Text(
                        'What is my IP address?',
                        style: TextStyle(color: Colors.amber),
                      )),
                ),

                SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("TCP Server")),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: TextField(
                                controller: _ipController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Icon(Icons.computer,
                                      color: Colors.indigoAccent),
                                  labelText: 'IP Address',
                                  contentPadding: EdgeInsets.all(0),
                                ),
                              )),
                          SizedBox(width: 30),
                          Expanded(
                              child: TextField(
                            controller: _portController,
                            keyboardType: TextInputType.number,
                            // maxLength: 5,
                            decoration: InputDecoration(
                                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                labelText: ' PORT',
                                labelStyle: TextStyle(fontSize: 12),
                                contentPadding: EdgeInsets.all(0)),
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            if (_ipController.text.isEmpty || _portController.text.isEmpty) {
                              MyDialogs.error("IP and Port are required!", "Please fill both fields");
                            } else {
                              connectTcpServer(_ipController.text, int.parse(_portController.text));
                              // _ipController.clear();
                              // _portController.clear();
                            }
                          },
                          child: Text('Connect'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigoAccent,
                            minimumSize: Size(double.infinity, 35),
                          ))
                    ],
                  ),
                ),

                // Spacer(),
                SizedBox(
                  height: 50,
                ),

                Center(
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.qr_code, size: 40),
                        onPressed: () {
                          _scanQRCode();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Scan QR Code")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _turnOnFlash() async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      MyDialogs.error('Could not enable Flashlight', "");
    }
  }

  Future<void> _turnOffFlash() async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      MyDialogs.error('Could not disable Flashlight', "");
    }
  }

  Future<void> _vibrate() async {
    try {
      await Vibration.vibrate(duration: 1000, amplitude: 128);
    } on Exception catch (_) {
      MyDialogs.error('Could not vibrate', "");
    }
  }

  Future<void> _scanQRCode() async {
    try {
      var code = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.QR);
      print("######" + code);

      if (code.isNotEmpty) {
        setState(() {
          qrCode = code;
        });
      }

      switch (qrCode) {
        case "It's getting dark":
          _turnOnFlash();
          break;
        case "You're blinding me":
          _turnOffFlash();
          break;
        case "Brrrr, It's freezing!":
          _vibrate();
          break;
        default:
        // executeUnknown();
      }
    } on Exception {
      MyDialogs.error("Failed To get qrCode", "Try Again!");
    }
  }
}
