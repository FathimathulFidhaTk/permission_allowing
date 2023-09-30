import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main(){
  runApp(MaterialApp(home: permission(),
    debugShowCheckedModeBanner: false,));
}

class permission extends StatefulWidget {
  @override
  State<permission> createState() => _permissionState();
}

class _permissionState extends State<permission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permission Handler",),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed:requestcameraPermission ,

                  child: Text("Request camera permission",)),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed:
                  multipleaccessPermission,
                  child: Text("Request multiple permission")),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed:
                  settingsPermissionRequest,
                  child: Text("Open Settings Permission")),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void requestcameraPermission() async {
    var status = await Permission.camera.status;
    if(status.isGranted) {
      print("Permission is Granted");
    } else if (status.isDenied){
      if(await Permission.camera.request().isGranted){
        print("Permission was Granted");
      }
    }
  }
  void multipleaccessPermission() async {
    Map<Permission, PermissionStatus> datas = await [
      Permission.contacts,
      Permission.phone,
      Permission.storage,
    ].request();
    print("Contacts Permission: ${datas[Permission.contacts]},"
        "Phone Permission: ${datas[Permission.phone]},"
        "Storage Permission: ${datas[Permission.storage]},"
    );
  }
  void settingsPermissionRequest() async {
    openAppSettings();
  }
}
