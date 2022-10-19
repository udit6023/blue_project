import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

class BluePage extends StatefulWidget {
  BluePage({Key? key, required this.title}) : super(key: key);
  final String title;
  
final FlutterBlue flutterBlue = FlutterBlue.instance;
final List<ScanResult> devicesList = <ScanResult>[];


  @override
  State<BluePage> createState() => _BluePageState();
}
class _BluePageState extends State<BluePage> {
  Map<dynamic, dynamic> map = {};
  ValueNotifier <double> _notifier = ValueNotifier<double>(-1.0);
late double powerValue;

   @override
 void initState() {
      widget.flutterBlue.startScan();
   super.initState();
    SCANRESULTS();

//  new Timer.periodic(Duration (seconds: 5), (Timer t) => setState(() {
 
//     widget.flutterBlue.stopScan();
//      }));


 }
Future<void> SCANRESULTS()async {
  widget.flutterBlue.scanResults
   .listen((List<ScanResult> devices) {
     for (ScanResult devices in devices) {
       addDeviceToList(devices);
       map[devices]=devices.rssi;
       print(map);
       setState(() {
         
       });
     }
   });

  //  widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
  //    for (ScanResult result in results) {
  //      addDeviceToList(result);
  //    }
  //  });
 
  return Future.delayed(Duration(seconds: 5));

 }
 
  @override
  Widget build(BuildContext context) {

ListView viewDevices() {
   
   List<Container> containers = <Container>[];
   for (ScanResult device in widget.devicesList) {
     powerValue=(double.parse(((pow(10, (-69-device.rssi)/30))).toStringAsFixed(5))) as double;
     
     
   
  setState(() {
     powerValue;
     print(device.rssi);

     });
     containers.add(
      
       Container(
         height: 100,
         width: 100,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            
               child: Center(
                
                 child: Column(
                   children:[
                    
                    SizedBox(height: 20,),
                     Text(device.advertisementData.localName== '' ? '(unknown device)' : device.advertisementData.localName),
                 Text("Distance from beacon: "),
                     Text(powerValue.toString()+" meters"),
                    
                   ],
                 ),
                
               ),
             ),
     );
     SizedBox(height: 10,);
   }
 
   return ListView(
     padding: const EdgeInsets.all(8),
     children:[
       ...containers,
     ],
   );


 }
    return Scaffold(
      appBar: AppBar(
         title: Text(widget.title),
         backgroundColor: Colors.black,
       ),
       body: viewDevices(),
    );
  }
  addDeviceToList(final ScanResult device) {
   if (!widget.devicesList.contains(device)) {
     setState(() {
       widget.devicesList.add(device);
        map[device]=device.rssi;
       print(map);
     });
   }
   
 }
  
}
