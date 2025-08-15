import 'package:STTS/controllers/market_controller.dart';
import 'package:STTS/models/order.dart';
import 'package:flutter/material.dart';

import '../../../Constants/stts_uganda_exports.dart';

// ignore: must_be_immutable
class UpdateStatusWidget extends StatefulWidget {
  final Order order;
  int selectedOption;
  final bool isMine;
  UpdateStatusWidget(
      {super.key,
      required this.selectedOption,
      required this.order,
      required this.isMine});

  @override
  State<UpdateStatusWidget> createState() => _UpdateStatusWidgetState();
}

class _UpdateStatusWidgetState extends State<UpdateStatusWidget> {
  MarketController marketController = MarketController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: marketController,
      child: Consumer<MarketController>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Change Order Status'),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Update Order",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        if (!widget.isMine)
                          ListTile(
                            title: const Text('Pending'),
                            leading: Radio(
                              value: 1,
                              groupValue: widget.selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  widget.selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        if (!widget.isMine)
                          ListTile(
                            title: const Text('Processing'),
                            leading: Radio(
                              value: 5,
                              groupValue: widget.selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  widget.selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        if (!widget.isMine)
                          ListTile(
                            title: const Text('Shipping'),
                            leading: Radio(
                              value: 2,
                              groupValue: widget.selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  widget.selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        if (!widget.isMine)
                          ListTile(
                            title: const Text('Delivered'),
                            leading: Radio(
                              value: 3,
                              groupValue: widget.selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  widget.selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        if (!widget.isMine)
                          if (widget.isMine)
                            ListTile(
                              title: const Text('Cancelled'),
                              leading: Radio(
                                value: 4,
                                groupValue: widget.selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    widget.selectedOption = value!;
                                  });
                                },
                              ),
                            ),
                        if (widget.isMine)
                          ListTile(
                            title: const Text('Received'),
                            leading: Radio(
                              value: 6,
                              groupValue: widget.selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  widget.selectedOption = value!;
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    if (model.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                    if (!model.isLoading)
                      FxButton.block(
                        borderRadiusAll: 0,
                        onPressed: () {
                          model.updateOrder(
                              widget.order.id, widget.selectedOption);
                        },
                        backgroundColor: CustomTheme.primary,
                        child: FxText(
                          "SUBMIT",
                          fontSize: 18,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
