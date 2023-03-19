import 'package:flutter/material.dart';
import 'package:flutter_loyality_card/widgets/barCodeTile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo12',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Loyal.io'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  Widget buildCard(int index) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.red.shade200,
          height: 150,
          width: double.infinity,
        ),
      );
}
