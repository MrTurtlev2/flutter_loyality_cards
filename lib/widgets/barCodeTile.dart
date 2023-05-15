import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarCode extends StatelessWidget {
  const BarCode({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.purple.shade100,
        child: Column(children: <Widget>[
          Image.asset('assets/images/Biedronka.png'),
          BarcodeWidget(
            barcode: Barcode.code128(),
            data: code,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.65,
          ),
        ]),
      ),
    );
  }
}
