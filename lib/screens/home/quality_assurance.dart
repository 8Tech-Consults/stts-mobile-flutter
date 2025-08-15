import 'package:STTS/theme/custom_theme.dart';
import 'package:STTS/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';

class QualityAssuranceDash extends StatelessWidget {
  const QualityAssuranceDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FxContainer(
                borderRadiusAll: 0,
                marginAll: 0,
                paddingAll: 5,
                color: CustomTheme.bg_primary_light,
                child: Stack(
                  children: [
                    Image(
                      width: double.infinity,
                      height: (Utils.screen_height(context) / 1.5),
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/seeds_bg_1.png"),
                    ),
                    FxContainer(
                      marginAll: 0,
                      paddingAll: 5,
                      color: Colors.transparent,
                      bordered: true,
                      border: Border.all(color: Colors.transparent, width: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxContainer(
                            borderRadiusAll: 0,
                            margin: EdgeInsets.only(bottom: 10),
                            paddingAll: 0,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.verified_outlined,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                FxText(
                                  "",
                                  fontSize: 16,
                                  fontWeight: 400,
                                  color: Colors.white,
                                ),
                              ],
                              
                            ),
                          ),
                          FxText(
                            "item.title",
                            textAlign: TextAlign.start,
                            color: Colors.grey.shade100,
                            fontSize: 16,
                            height: 1.01,
                            fontWeight: 800,
                          ),
                          Spacer(),
                          FxContainer(
                            color: Colors.yellow.shade800,
                            marginAll: 0,
                            
                            margin: EdgeInsets.only(
                              left: 0,
                              bottom: 0,
                              right: 0,
                              top: 10,
                            ),
                            padding: EdgeInsets.only(
                              left: 10,
                              bottom: 2,
                              right: 5,
                              top: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText(
                                  "View all",
                                  fontSize: 12,
                                  fontWeight: 700,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  size: 15,
                                  color: Colors.black,
                                )
                              ],
                              
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        )
      ],
    );
  }
}
