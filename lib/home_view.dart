import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:workshop_flutter_qr_gen/qr_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isExpanded = false;
  List<QrItem> qrItems = [
    QrItem(data: '1234567890', alignment: Alignment.topLeft),
    QrItem(data: null, alignment: Alignment.topCenter),
    QrItem(data: '1357924680', alignment: Alignment.topRight),
    QrItem(data: '1234567890', alignment: Alignment.centerLeft),
    QrItem(data: '1357924680', alignment: Alignment.center),
    QrItem(data: null, alignment: Alignment.centerRight),
    QrItem(data: null, alignment: Alignment.bottomLeft),
    QrItem(data: null, alignment: Alignment.bottomCenter),
    QrItem(data: '1357924680', alignment: Alignment.bottomRight),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Safe Qr Generator",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.expand),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: slotItem(qrItems[0])),
                  Expanded(child: slotItem(qrItems[1])),
                  Expanded(child: slotItem(qrItems[2])),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: slotItem(qrItems[3])),
                  Expanded(child: slotItem(qrItems[4])),
                  Expanded(child: slotItem(qrItems[5])),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: slotItem(qrItems[6])),
                  Expanded(child: slotItem(qrItems[7])),
                  Expanded(child: slotItem(qrItems[8])),
                ],
              ),
            ),
          ],
        ));
  }

  Widget slotItem(QrItem qrItem) {
    return GestureDetector(
      onTap: () {
        if (qrItem.data == null) {
          setState(() {
            qrItem.data = '1234567890';
          });
        } else {
          setState(() {
            qrItem.data = null;
          });
        }
      },
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.all(5),
          alignment: qrItem.alignment ?? Alignment.center,
          child: qrItem.data == null
              ? Icon(
                  Icons.add_box_outlined,
                  size: 100,
                  color: Colors.grey.shade300,
                )
              : FittedBox(
                  fit: BoxFit.none,
                  child: QrImageView(
                    data: qrItem.data!,
                    version: QrVersions.auto,
                    size: 100.0,
                  ),
                ),
        ),
      ),
    );
  }
}
