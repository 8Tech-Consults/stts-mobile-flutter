import 'package:STTS/controllers/market_controller.dart';
import 'package:STTS/models/add_order.dart';

import '../../Constants/stts_uganda_exports.dart';

class ProductDetailWidget extends StatefulWidget {
  final Product product;
  const ProductDetailWidget({super.key, required this.product});

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  AddOrder addOrder = AddOrder();
  MarketController marketController = MarketController();
  var qty = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      qty = int.parse(widget.product.productItem.quantity.toString());
    });
    addOrder.administratorId =
        int.parse(widget.product.productItem.administratorId.toString());
    addOrder.productId = widget.product.productItem.id;
    addOrder.orderBy = locator<UserController>().user?.id;
    addOrder.cropVarietyId = widget.product.productItem.cropVariety?.id;
    addOrder.status = 1;
    addOrder.seedClass = widget.product.productItem.seedClass;
    addOrder.totalPrice =
        int.parse(widget.product.productItem.price.toString()) * qty;
    addOrder.paymentType = "Credit card";
    addOrder.detail = "Some details about the order";
    addOrder.quantity = qty;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: marketController,
      child: Consumer<MarketController>(
        builder: (_, model, child) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 22,
                            ),
                          ),
                          const Icon(
                            Icons.favorite,
                            size: 28,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          height: 220,
                          child: Image.network(
                            Constants.imageUrl +
                                widget.product.productItem.imageUrl.toString(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Container(
                            width: 200.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(29.0),
                              color: Colors.amber[300],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber[300]!,
                                  blurRadius: 5.0,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    if (qty > 1) {
                                      setState(() {
                                        qty = qty - 1;
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25),
                                  ),
                                ),
                                Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (qty <
                                        int.parse(widget
                                            .product.productItem.quantity
                                            .toString())) {
                                      setState(() {
                                        qty = qty + 1;
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "+",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.product.productItem.name.toString(),
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Lab test number: ${widget.product.productItem.labTestNumber}",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Crop variety : ${widget.product.productItem.cropVariety?.name}",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Available stock : ${widget.product.productItem!.availableStock}",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      if (model.isLoading)
                        const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      if (!model.isLoading)
                        ElevatedButton(
                          onPressed: () => {
                            print("ahahahhahhhhah: ${jsonEncode(addOrder)} ")
                            //model.submitOrder(addOrder),
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const SizedBox(
                            height: 40,
                            width: 100,
                            child: Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
