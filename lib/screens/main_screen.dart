import 'dart:convert';
import 'package:flutter_loyality_card/dto/card_list.dart';
import 'package:flutter_loyality_card/screens/add_card_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_loyality_card/dto/loyality_card.dart';

import '../widgets/barCodeTile.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key, required this.title});
  final String title;


  final CardList cardList = CardList();


  void _addNewCard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddCardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: 20,
          right: 20,
          bottom: 0,
        ),
        child: StreamBuilder<List<LoyalityCard>>(
          stream: cardList.listOfCards.stream,
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return BarCode(code: snapshot.data![index].code);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemCount: snapshot.data!.length - 1);
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewCard,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
