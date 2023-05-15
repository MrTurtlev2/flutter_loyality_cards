import 'package:flutter/material.dart';

import '../widgets/barCodeTile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;
  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: 20,
          right: 20,
          bottom: 0,
        ),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return const BarCode();
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20);
            },
            itemCount: 100),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
