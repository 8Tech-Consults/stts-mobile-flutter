import 'package:STTS/screens/account/account_fragment.dart';
import 'package:STTS/screens/market_place/orders/OrdersList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCreated extends StatelessWidget {
  const OrderCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white)),
            child: const Icon(
              Icons.account_box,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Order successful.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                    onPressed: () {
                      Get.to(
                        AccountFragment(
                          root: context,
                        ),
                      );
                      //Get.to(OrdersList());
                    },
                    child: const Text('Proceed to orders')),
              )
            ],
          )
        ],
      ),
    );
  }
}
