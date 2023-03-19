import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarCode extends StatelessWidget {
  const BarCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BarcodeWidget(
          barcode: Barcode.code128(),
          data: 96526523215.toString(),
        ),
      ],
    );
  }
}
