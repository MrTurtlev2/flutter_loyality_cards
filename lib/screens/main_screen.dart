import 'dart:convert';
import 'package:flutter_loyality_card/dto/card_list.dart';
import 'package:flutter_loyality_card/screens/add_card_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_loyality_card/dto/loyality_card.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/bar_code_tile.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key, required this.title});

  final String title;

  final CardList cardList = CardList();

  void _addNewCard(BuildContext context) {
    // cardList.addNewItemToList(LoyalityCard(id: '',name: '', image: '', code: ''));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddCardScreen(cardList: cardList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.5),
          child: Text(title),
        ),
        actions: [
          StreamBuilder<bool>(
            stream: cardList.deleteModeStream,
            builder: (context, snapshot) {
              return snapshot.data != true
                  ? const SizedBox.shrink()
                  : IconButton(icon: const Icon(Icons.delete), onPressed: () => cardList.delete());
            },
          ),
          StreamBuilder<bool>(
            stream: cardList.deleteModeStream,
            builder: (context, snapshot) {
              return snapshot.data != true
                  ? const SizedBox.shrink()
                  : IconButton(icon: const Icon(Icons.close), onPressed: () => cardList.clearSelected());
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.5),
            child: StreamBuilder<bool>(
              stream: cardList.deleteModeStream,
              builder: (context, snapshot) {
                return snapshot.data != true
                    ? const SizedBox.shrink()
                    : IconButton(icon: const Icon(Icons.select_all), onPressed: () => cardList.selectAll());
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        child: StreamBuilder<List<LoyalityCard>>(
          stream: Rx.combineLatest2<List<LoyalityCard>, int, List<LoyalityCard>>(
            cardList.listOfCards.stream,
            cardList.deleteCount.stream,
                (items, itemsToDelete) => items,
          ),
          builder: (context, snapshot) {
            final items = snapshot.data;
            if (items == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if (items.isEmpty) {
              const SizedBox.shrink();
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                final numericOrderValue = cardList.itemsToDelete.indexOf(items[index]) + 1;
                final isSelected = numericOrderValue > 0;
                return InkWell(
                  onLongPress: () => cardList.chooseItemToDelete(items[index]),
                  onTap: cardList.getDeleteMode ? () => cardList.chooseInEditMode(items[index]) : null,
                  child: BarCode(code: items[index].code, isSelected: isSelected, image: items[index].image),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 0);
              },
              itemCount: items!.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewCard(context),
        tooltip: 'add new card',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
