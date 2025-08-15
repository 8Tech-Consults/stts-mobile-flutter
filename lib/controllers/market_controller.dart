import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/add_order.dart';
import 'package:STTS/models/order.dart';
import 'package:STTS/models/quotation.dart';
import 'package:STTS/repositories/market_repository.dart';
import 'package:STTS/widgets/market/success.dart';
import 'package:get/get.dart';

class MarketController extends ChangeNotifier {
  bool isLoading = false;
  dynamic exception;
  List<Product> products = [];
  List<Order> orders = [];
  List<Order> preOrders = [];
  List<Quotation> quotations = [];

  void fetchProducts() async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      products = [];
      List<Product> results = await MarketRepository.getProducts();
      products.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchOrders(id, {isMine}) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      orders = [];
      List<Order> results =
          await MarketRepository.getOrders(id, isMine: isMine);
      orders.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchPreOrders(id) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      preOrders = [];
      List<Order> results = await MarketRepository.getPreOrders(id);
      preOrders.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchQuotations(id) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      quotations = [];
      List<Quotation> results = await MarketRepository.getQuotations(id);
      quotations.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void submitOrder(AddOrder addOrder) async {
    try {
      isLoading = true;
      notifyListeners();
      await MarketRepository.submitOrder(addOrder);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
      Get.to(const OrderCreated());
    } catch (e, s) {
      print("ajajajajjjjkjak: $e");
      print("ajajajajjjjkjak: $s");
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void updateOrder(id, status) async {
    try {
      isLoading = true;
      notifyListeners();
      await MarketRepository.updateOrder(id, status);
      MethodHelpers.showSuccessWithNoActionButton("Order updated successfully");
    } catch (e) {
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
