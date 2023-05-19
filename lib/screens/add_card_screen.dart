import 'package:flutter/material.dart';
import 'package:flutter_loyality_card/dto/card_list.dart';

import '../dto/loyality_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import 'package:selectable_list/selectable_list.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key, required this.cardList});

  final CardList cardList;

  @override
  State<AddCardScreen> createState() => _AddCard();
}

class _AddCard extends State<AddCardScreen> {
  final barCodeController = TextEditingController();
  String? selectedShop;
  final formKey = GlobalKey<FormState>();

  void addCard() {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    widget.cardList.addNewItemToList(
        LoyalityCard(id: '', code: barCodeController.text, image: selectedShop ?? '', name: selectedShop ?? ''));
    Navigator.of(context).pop();
  }

  final shops = [Shop('Biedronka'), Shop('Lidl'), Shop('Lewiatan'), Shop('Dino')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      style: TextStyle(color: Colors.grey[700], fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: DropdownButtonFormField<String>(
                      value: shops.first.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      dropdownColor: Colors.grey,
                      items: shops
                          .map(
                            (shop) => DropdownMenuItem<String>(
                          value: shop.name,
                          child: Text(shop.name),
                        ),
                      )
                          .toList(),
                      onChanged: (shop) => setState(() => selectedShop = shop),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    keyboardType: TextInputType.number,
                    controller: barCodeController,
                    hintText: 'bar code',
                    obscureText: false,
                    validator: validateBarCode,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 25),
                  CustomButton(
                    text: 'add',
                    onTap: addCard,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateBarCode(String? value) {
    if (value?.isEmpty != false) {
      return 'You need to insert bar code';
    }
    if (value!.length != 9 ) {
      return 'You need to pass 9 length code';
    }
    return null;
  }
}

class Shop {
  final String name;

  Shop(this.name);
}
