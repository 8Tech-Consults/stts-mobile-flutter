import 'package:STTS/models/add_order.dart';
import 'package:STTS/models/order.dart';
import 'package:STTS/models/quotation.dart';

import '../Constants/stts_uganda_exports.dart';

class MarketRepository {
  static Future<List<Product>> getProducts() async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('products');

      List<Product> products = [];
      for (Map<String, dynamic> product in response.data) {
        products.add(Product.fromJson(product));
      }

      return products;
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> updateOrder(id, status) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.put('orders/$id', data: {"status": status});
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<Order>> getOrders(id, {isMine}) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final Response response;
      if (isMine) {
        response = await dio.request('assigned-orders/$id');
      } else {
        response = await dio.request('orders/$id');
      }
      final List<Order> orders = [];
      for (Map<String, dynamic> order in response.data) {
        orders.add(Order.fromJson(order));
      }

      return orders;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<Order>> getPreOrders(id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('pre-orders/$id');

      List<Order> orders = [];
      for (Map<String, dynamic> order in response.data) {
        orders.add(Order.fromJson(order));
      }

      return orders;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<Quotation>> getQuotations(id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('quotations/$id');

      List<Quotation> quotations = [];
      for (Map<String, dynamic> quotation in response.data) {
        quotations.add(Quotation.fromJson(quotation));
      }

      return quotations;
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitOrder(AddOrder addOrder) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('orders', data: addOrder);
    } catch (e) {
      rethrow;
    }
  }
}
