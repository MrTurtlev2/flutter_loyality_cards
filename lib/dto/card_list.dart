import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'loyality_card.dart';

class CardList {
  CardList() {
    fetchCards();
  }

  Future<void> fetchCards() async {
    final response = await http.get(Uri.parse('https://6462882c4dca1a661348afa3.mockapi.io/cards'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      listOfCards.add(jsonData.map((e) => LoyalityCard.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      throw Exception('Failed to load your cards');
    }
  }

  final BehaviorSubject<List<LoyalityCard>> listOfCards = BehaviorSubject<List<LoyalityCard>>();
  final BehaviorSubject<int> deleteCount = BehaviorSubject<int>.seeded(0);
  List<LoyalityCard> itemsToDelete = [];
  final BehaviorSubject<bool> _deleteMode = BehaviorSubject<bool>.seeded(false);

  bool get getDeleteMode => _deleteMode.value;
  Stream<bool> get deleteModeStream => _deleteMode.stream;

  void chooseItemToDelete(LoyalityCard item) {
    final enableDeleteMode = !_deleteMode.value;
    if (enableDeleteMode) {
      _deleteMode.add(enableDeleteMode);
      itemsToDelete.add(item);
      deleteCount.add(itemsToDelete.length);
      return;
    }
    clearSelected();
    return;
  }

  void chooseInEditMode(LoyalityCard item) {
    if (!itemsToDelete.remove(item)) {
      itemsToDelete.add(item);
    }
    deleteCount.add(itemsToDelete.length);
  }

  void selectAll(){
    itemsToDelete.clear();
    itemsToDelete.addAll(listOfCards.value);
    deleteCount.add(itemsToDelete.length);
  }

  void clearSelected() {
    _deleteMode.add(false);
    itemsToDelete.clear();
    deleteCount.add(0);
  }

  void delete(){
    final newList = listOfCards.value;
    newList.removeWhere((element) => itemsToDelete.contains(element));
    listOfCards.add(newList);
    clearSelected();
  }

  void addNewItemToList(LoyalityCard item) {
    final newList = listOfCards.value;
    newList.add(item);
    listOfCards.add(newList);
  }
}