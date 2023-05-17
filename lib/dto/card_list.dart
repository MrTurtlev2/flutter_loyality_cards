import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'loyality_card.dart';

class CardList {
  CardList() {
    fetchCards();
  }

  Future<void> fetchCards() async {
    final response = await http
        .get(Uri.parse('https://6462882c4dca1a661348afa3.mockapi.io/cards'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      listOfCards.add(jsonData.map((e) => LoyalityCard.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      throw Exception('Failed to load your cards');
    }
  }

  final BehaviorSubject<List<LoyalityCard>> listOfCards = BehaviorSubject<List<LoyalityCard>>();

  void addNewItemToList(LoyalityCard item)  {
    listOfCards.add([item]);
    print(item);
  }


}