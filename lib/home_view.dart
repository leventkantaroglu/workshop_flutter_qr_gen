import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:workshop_flutter_qr_gen/qr_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isExpanded = true;
  List<QrItem> qrItems = [
    QrItem(data: null, alignment: Alignment.topLeft),
    QrItem(data: null, alignment: Alignment.topCenter),
    QrItem(data: null, alignment: Alignment.topRight),
    QrItem(data: null, alignment: Alignment.centerLeft),
    QrItem(data: null, alignment: Alignment.center),
    QrItem(data: null, alignment: Alignment.centerRight),
    QrItem(data: null, alignment: Alignment.bottomLeft),
    QrItem(data: null, alignment: Alignment.bottomCenter),
    QrItem(data: null, alignment: Alignment.bottomRight),
  ];
  TextEditingController textEditingController = TextEditingController();
  int? selectedQrItemIndex;
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Safe QR Generator",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(isExpanded ? Icons.zoom_in_map : Icons.zoom_out_map),
            color: Colors.indigo,
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
          Opacity(
            opacity: selectedQrItemIndex != null ? 1 : 0,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      focusNode: myFocusNode,
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          qrItems[selectedQrItemIndex!].data = value;
                        });
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textEditingController.clear();
                    setState(() {
                      qrItems[selectedQrItemIndex!].data = null;
                    });
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
      ),
    );
  }

  Widget get addWidget => Icon(
        Icons.add_box_outlined,
        size: 100,
        color: Colors.grey.shade300,
      );

  Widget slotItem(QrItem qrItem) {
    return GestureDetector(
      onTap: () {
        textEditingController.text = qrItem.data ?? '';
        FocusScope.of(context).requestFocus(myFocusNode);
        setState(() {
          selectedQrItemIndex = qrItems.indexOf(qrItem);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: qrItem.alignment ?? Alignment.center,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedQrItemIndex == qrItems.indexOf(qrItem)
                    ? Colors.grey.shade400
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: FittedBox(
              fit: isExpanded ? BoxFit.contain : BoxFit.none,
              child: qrItem.data == null
                  ? addWidget
                  : Column(
                      children: [
                        QrImageView(
                          data: qrItem.data!,
                          version: QrVersions.auto,
                          size: 100.0,
                        ),
                        Text(
                          qrItem.data ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
