import 'package:STTS/controllers/market_controller.dart';
import 'package:STTS/widgets/market/product_details.dart';
import 'package:STTS/widgets/market/product_widget.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../Constants/stts_uganda_exports.dart';
import '../../models/ProductModel.dart';
import '../market_place/products/product_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MarketFragment extends StatefulWidget {
  const MarketFragment({super.key});

  @override
  _MarketFragmentState createState() => _MarketFragmentState();
}

class _MarketFragmentState extends State<MarketFragment>
    with SingleTickerProviderStateMixin {
  double findAspectRatio(double width) {
    //Logic for aspect ratio of grid view
    return (width / 2 - 24) / ((width / 2 - 24) + 66);
  }

  MarketController marketController = MarketController();
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    marketController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: marketController,
      child: Consumer<MarketController>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Market',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: model.isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        children: [
                          Center(
                            child: Text(
                              "Found ${model.products.length} products",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          for (var i = 0; i < model.products.length; i++)
                            InkWell(
                              onTap: () => {
                                Get.to(
                                  ProductDetailWidget(
                                    product: model.products[i],
                                  ),
                                )
                              },
                              child: ProductWidget(
                                product: model.products[i],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext _context) async {
    return;
  }

  Widget SingleProduct(ProductModel item) {
    return _ProductListWidget(
      pro: item,
      name: item.name,
      image: Utils.get_file_url(item.image),
      shopName: 'El Primo',
      star: 3,
      price: 29.59,
      rootContext: context,
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool colorBlack = false,
      colorRed = true,
      colorOrange = false,
      colorTeal = true,
      colorPurple = false;

  bool sizeXS = false,
      sizeS = true,
      sizeM = false,
      sizeL = true,
      sizeXL = false;

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
      decoration: BoxDecoration(
          color: customTheme.card,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      padding: FxSpacing.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Center(child: FxText("Filter", fontWeight: 700))),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: FxSpacing.all(8),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    child: Icon(
                      MdiIcons.check,
                      size: 20,
                      color: theme.colorScheme.onPrimary,
                    )),
              )
            ],
          ),
          FxSpacing.height(8),
          FxText("Type", fontWeight: 600, letterSpacing: 0),
          Container(
            child: _TypeChipWidget(),
          ),
          FxSpacing.height(8),
          FxText("Color", fontWeight: 600, letterSpacing: 0),
          FxSpacing.height(16),
          Row(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    setState(() {
                      colorBlack = !colorBlack;
                    });
                  },
                  child: colorWidget(color: Colors.black, checked: colorBlack)),
              FxSpacing.width(8),
              InkWell(
                onTap: () {
                  setState(() {
                    colorRed = !colorRed;
                  });
                },
                child: colorWidget(color: Colors.red, checked: colorRed),
              ),
              FxSpacing.width(8),
              InkWell(
                onTap: () {
                  setState(() {
                    colorOrange = !colorOrange;
                  });
                },
                child: colorWidget(color: Colors.orange, checked: colorOrange),
              ),
              FxSpacing.width(8),
              InkWell(
                onTap: () {
                  setState(() {
                    colorTeal = !colorTeal;
                  });
                },
                child: colorWidget(color: Colors.teal, checked: colorTeal),
              ),
              FxSpacing.width(8),
              InkWell(
                onTap: () {
                  setState(() {
                    colorPurple = !colorPurple;
                  });
                },
                child: colorWidget(color: Colors.purple, checked: colorPurple),
              ),
            ],
          ),
          FxSpacing.height(16),
          FxText("Size", fontWeight: 600, letterSpacing: 0),
          FxSpacing.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    sizeXS = !sizeXS;
                  });
                },
                child: SingleSizeWidget(size: "XS", isSelected: sizeXS),
              )),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      sizeS = !sizeS;
                    });
                  },
                  child: SingleSizeWidget(size: "S", isSelected: sizeS),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      sizeM = !sizeM;
                    });
                  },
                  child: SingleSizeWidget(size: "M", isSelected: sizeM),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      sizeL = !sizeL;
                    });
                  },
                  child: SingleSizeWidget(size: "L", isSelected: sizeL),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      sizeXL = !sizeXL;
                    });
                  },
                  child: SingleSizeWidget(size: "XL", isSelected: sizeXL),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget colorWidget({Color? color, bool checked = true}) {
    return FxContainer.none(
      width: 36,
      height: 36,
      color: color,
      borderRadiusAll: 18,
      child: checked
          ? Center(
              child: Icon(
                MdiIcons.check,
                color: Colors.white,
                size: 20,
              ),
            )
          : Container(),
    );
  }
}

class SingleSizeWidget extends StatefulWidget {
  final String size;
  final bool isSelected;

  const SingleSizeWidget(
      {Key? key, required this.size, required this.isSelected})
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
    ThemeData themeData = Theme.of(context);
    return FxCard(
      width: 44,
      height: 44,
      paddingAll: 0,
      bordered: !widget.isSelected,
      border: Border.all(color: customTheme.border, width: 1.6),
      color: widget.isSelected
          ? themeData.colorScheme.primary
          : Colors.transparent,
      child: Center(
        child: FxText(widget.size.toString(),
            letterSpacing: -0.2,
            fontWeight: 700,
            color: widget.isSelected
                ? themeData.colorScheme.onPrimary
                : themeData.colorScheme.onBackground),
      ),
    );
  }
}

class _TypeChipWidget extends StatefulWidget {
  final List<String> typeList = ["Man", "Woman", "Shoes", "Sale"];

  @override
  _TypeChipWidgetState createState() => _TypeChipWidgetState();
}

class _TypeChipWidgetState extends State<_TypeChipWidget> {
  List<String> selectedChoices = ["Man"];
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.typeList.forEach((item) {
      choices.add(Container(
        padding: FxSpacing.all(8),
        child: ChoiceChip(
          backgroundColor: customTheme.card,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          selectedColor: theme.colorScheme.primary,
          label: FxText(item,
              color: selectedChoices.contains(item)
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.onBackground,
              fontWeight: selectedChoices.contains(item) ? 700 : 600),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class SortBottomSheet extends StatefulWidget {
  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  int _radioValue = 0;
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
      color: Colors.transparent,
      child: Container(
        padding: FxSpacing.xy(24, 16),
        decoration: BoxDecoration(
            color: customTheme.card,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FxSpacing.height(8),
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _radioValue = 0;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                        onChanged: (dynamic value) {
                          setState(() {
                            _radioValue = 0;
                          });
                        },
                        groupValue: _radioValue,
                        value: 0,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                      ),
                      FxText("Price - ", fontWeight: 60),
                      FxText("High to Low"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _radioValue = 1;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                        onChanged: (dynamic value) {
                          setState(() {
                            _radioValue = 1;
                          });
                        },
                        groupValue: _radioValue,
                        value: 1,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                      ),
                      FxText("Price - ", fontWeight: 600),
                      FxText("Low to High"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _radioValue = 2;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                        onChanged: (dynamic value) {
                          setState(() {
                            _radioValue = 2;
                          });
                        },
                        groupValue: _radioValue,
                        value: 2,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                      ),
                      FxText("Name - ", fontWeight: 600),
                      FxText("A to Z"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _radioValue = 3;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                        onChanged: (dynamic value) {
                          setState(() {
                            _radioValue = 3;
                          });
                        },
                        groupValue: _radioValue,
                        value: 3,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                      ),
                      FxText("Name - ", fontWeight: 600),
                      FxText("Z to A"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ProductListWidget extends StatefulWidget {
  final String name, image, shopName;
  final double star;
  final ProductModel pro;
  final double price;
  final BuildContext rootContext;

  const _ProductListWidget(
      {Key? key,
      required this.pro,
      required this.name,
      required this.image,
      required this.shopName,
      required this.star,
      required this.price,
      required this.rootContext})
      : super(key: key);

  @override
  __ProductListWidgetState createState() => __ProductListWidgetState();
}

class __ProductListWidgetState extends State<_ProductListWidget> {
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
    String key = '20';

    return FxContainer(
      paddingAll: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      borderRadiusAll: 4,
      onTap: () {
        Navigator.push(widget.rootContext,
            MaterialPageRoute(builder: (context) => ProductScreen(widget.pro)));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: key,
                child: Image.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  right: 8,
                  top: 8,
                  child: Icon(
                    MdiIcons.heartOutline,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ))
            ],
          ),
          Container(
            padding: FxSpacing.nBottom(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FxText(widget.pro.name + ", ", fontWeight: 500),
                FxSpacing.height(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FxText("\UGX " + widget.pro.price.toString(),
                        fontWeight: 700),
                    FxContainer(
                      borderRadiusAll: 4,
                      color: theme.colorScheme.primary,
                      paddingAll: 6,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            MdiIcons.star,
                            color: theme.colorScheme.onPrimary,
                            size: 12,
                          ),
                          FxSpacing.width(4),
                          FxText(widget.star.toString(),
                              color: theme.colorScheme.onPrimary,
                              fontWeight: 600),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
