import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarCode extends StatelessWidget {
  const BarCode({super.key, required this.code, this.isSelected = false, this.image = ''});

  final String code;
  final bool isSelected;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: !isSelected
            ?  BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        )
            : BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          // borderRadius: BorderRadius.circular(8),
        ),
        child: ColoredBox(
          color: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Image.asset('assets/images/$image.png'),
              BarcodeWidget(
                barcode: Barcode.code128(),
                data: code,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}