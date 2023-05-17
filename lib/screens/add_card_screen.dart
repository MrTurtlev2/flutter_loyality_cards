import 'package:flutter/material.dart';
import 'package:flutter_loyality_card/dto/card_list.dart';

import '../dto/loyality_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import 'package:selectable_list/selectable_list.dart';

import 'main_screen.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key, required this.cardList});
  final CardList cardList;

  @override
  State<AddCardScreen> createState() => _AddCard();
  
}

class _AddCard extends State<AddCardScreen> {

  final barCodeController = TextEditingController();
  String? selectedShop;

  void signUserIn() {

    widget.cardList.addNewItemToList(LoyalityCard(id: '', code: barCodeController.text, image: selectedShop??'', name: selectedShop??''));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainScreen(title: 'Loyal.Io'),
      ),
    );
  }
  final shops = [
    Shop('Biedronka'),
  Shop('Lidl'),
  Shop('Lewiatan'),
  Shop('Dino')
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(
                Icons.add,
                size: 100,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Pick shop from the list and add new card',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SelectableList<Shop, String?>(
                items: shops,
                itemBuilder: (context, shop, selected, onTap) => ListTile(
                  focusColor: Colors.black,
                    selectedColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    title: Text(shop.name),
                    selected: selected,
                    onTap: onTap),
                valueSelector: (shop) => shop.name,
                selectedValue: selectedShop,
                onItemSelected: (shop) =>
                    setState(() => selectedShop = shop.name),
                onItemDeselected: (shop) => setState(() => selectedShop = null),
              ),
              const SizedBox(height: 10),
              CustomInput(
                controller: barCodeController,
                hintText: 'bar code',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 25),
              CustomButton(
                text: 'add',
                // onTap: barCodeController.text == '' ? null : signUserIn,
                onTap:  signUserIn,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
class Shop {
  final String name;

  Shop(this.name);
}