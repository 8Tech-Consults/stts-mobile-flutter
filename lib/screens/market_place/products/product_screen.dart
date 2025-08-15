import 'package:STTS/models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/Utils.dart';
import 'order_confirmation.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel pro;

  const ProductScreen(
    this.pro, {
    Key? key,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  String descText = "SImple title romina";

  int selectedSize = 7;

  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onBackground,
            ),
          ),
          title: FxText("${widget.pro.name} - ${widget.pro.crop_variety_id}",
              fontWeight: 600),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          Utils.get_file_url(widget.pro.image),
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    FxSpacing.height(20),
                    FxText("UGX ${widget.pro.price}",
                        fontSize: 25, fontWeight: 400, letterSpacing: 0),
                    FxSpacing.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FxText("${widget.pro.quantity} KGs, Quantity Available",
                            color: CustomTheme.primary,
                            fontSize: 20,
                            fontWeight: 400,
                            height: 1),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FxContainer.bordered(
              paddingAll: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FxSpacing.height(10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FxButton(
                          elevation: 2,
                          padding: FxSpacing.y(12),
                          borderRadiusAll: 4,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                MdiIcons.cartPlus,
                                color: theme.colorScheme.onPrimary,
                                size: 20,
                              ),
                              FxSpacing.width(4),
                              FxText(
                                "BUY NOW",
                                letterSpacing: 0.4,
                                color: theme.colorScheme.onPrimary,
                                fontWeight: 600,
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderConfirmationScreen(widget.pro)));
                          },
                        ),
                      ),
                      FxSpacing.width(20),
                      InkWell(
                        onTap: () {
                          Utils.launchPhone(widget.pro.phone);
                        },
                        child: FxContainer(
                          padding: FxSpacing.xy(12, 12),
                          borderRadiusAll: 4,
                          color: theme.colorScheme.primary.withAlpha(40),
                          child: Icon(
                            MdiIcons.phone,
                            size: 24,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class SingleSizeWidget extends StatefulWidget {
  final int size;
  final bool isAvailable, isSelected;

  const SingleSizeWidget(
      {Key? key,
      required this.size,
      this.isAvailable = true,
      this.isSelected = false})
      : super(key: key);

  @override
  _SingleSizeWidgetState createState() => _SingleSizeWidgetState();
}

class _SingleSizeWidgetState extends State<SingleSizeWidget> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(
            color: (widget.isAvailable && widget.isSelected)
                ? theme.colorScheme.primary
                : theme.colorScheme.background,
            width: 1.6),
        shape: BoxShape.circle,
        color: widget.isAvailable
            ? (widget.isSelected
                ? theme.colorScheme.primary
                : Colors.transparent)
            : customTheme.cardDark,
      ),
      child: Center(
        child: FxText(widget.size.toString(),
            letterSpacing: -0.2,
            fontWeight: 600,
            color: (widget.isAvailable && widget.isSelected)
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onBackground),
      ),
    );
  }
}
