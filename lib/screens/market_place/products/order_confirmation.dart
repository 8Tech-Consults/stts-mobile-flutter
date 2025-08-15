import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../models/ProductModel.dart';
import '../../../models/RespondModel.dart';
import '../../../utils/Utils.dart';
import '../../../utils/my_colors.dart';
import '../../../widgets/my_text.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final ProductModel pro;

  OrderConfirmationScreen(this.pro);

  @override
  OrderConfirmationStateScreen createState() =>
      new OrderConfirmationStateScreen();
}

class OrderConfirmationStateScreen extends State<OrderConfirmationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> submit_form() async {
    if (!_formKey.currentState!.validate()) {
      Utils.showSnackBar("Please fix errors in the form.", context,
          background_color: Colors.red, color: Colors.white);
      return;
    }

    if (Utils.int_parse(_formKey.currentState?.fields['quantity']?.value) >
        Utils.int_parse(widget.pro.quantity)) {
      Utils.showSnackBar(
          "Quantity you order for should be less or equal to quantity available.",
          context,
          background_color: Colors.red,
          color: Colors.white);
    }

    Map<String, dynamic> form_data_map = {};
    form_data_map = {
      'quantity': _formKey.currentState?.fields['quantity']?.value,
      'note': _formKey.currentState?.fields['note']?.value,
      'product_id': widget.pro.id.toString(),
    };

    is_loading = true;
    error_message = "";
    setState(() {});

    RespondModel resp_1 =
        RespondModel(await Utils.http_post('order/new', form_data_map));

    if (resp_1.code != 1) {
      is_loading = false;
      error_message = '${resp_1.message}';
      setState(() {});
      return;
    }

    is_loading = false;
    setState(() {});

    Utils.showSnackBar(resp_1.message, context,
        color: Colors.white, background_color: Colors.green);

    Navigator.pop(context);
    Navigator.pop(context);
  }

  String error_message = "";
  bool is_loading = false;

  @override
  void initState() {
    Utils.init_theme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(color: Colors.white)),
      body: Stack(
        children: [
          ListView(
            children: [
              FxContainer(
                  borderRadiusAll: 0,
                  marginAll: 0,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  color: Colors.white,
                  child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            height: 20,
                            color: Colors.white,
                          ),
                          FxText("Order confirmation",
                              style: MyText.title(context)?.copyWith(
                                  color: MyColors.primary,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 30,
                          ),
                          FxText(
                              "You are purchasing ${widget.pro.name} at  ${widget.pro.price} per Kilogram. "
                              "\nAvailable Quantity: ${widget.pro.quantity}.",
                              color: Colors.black,
                              fontSize: 20,
                              textAlign: TextAlign.justify,
                              fontWeight: 400,
                              height: 1),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(0),
                            child: Column(
                              children: <Widget>[
                                Container(height: 25),
                                FormBuilderTextField(
                                  name: 'quantity',
                                  autofocus: true,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      // context,
                                      errorText: "Quantity is required.",
                                    ),
                                  ]),
                                  decoration: InputDecoration(
                                      labelText: "Quantity",
                                      labelStyle: MyText.caption(context)),
                                ),
                                Container(height: 25),
                                FormBuilderTextField(
                                  name: 'note',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      labelText: "Short note",
                                      labelStyle: MyText.caption(context)),
                                ),
                                Container(height: 10),
                                Container(
                                  child: error_message.isEmpty
                                      ? Text("")
                                      : FxText(
                                          error_message,
                                          color: Colors.red,
                                          fontWeight: 400,
                                          fontSize: 12,
                                        ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ))),
              SizedBox(
                height: 200,
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: is_loading
                ? Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(15),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 55,
                    child: FxButton.block(
                      borderRadiusAll: 0,
                      child: Text("SUBMIT ORDER",
                          style: MyText.headline(context)
                              ?.copyWith(color: Colors.white)),
                      onPressed: () {
                        //Utils.showSnackBar("SImple tamp", context);
                        submit_form();
                        //Utils.init_theme();
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
