import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/LoggedInUserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../utils/app_config.dart';
import '../../../utils/my_colors.dart';
//my latest!

class home_fragment_old extends StatefulWidget {
  LoggedInUserModel loggedInUserModel;

  home_fragment_old({required LoggedInUserModel this.loggedInUserModel});

  @override
  State<home_fragment_old> createState() => _home_fragment_oldState();
}

class _home_fragment_oldState extends State<home_fragment_old> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText(
                  "Tasks",
                  fontWeight: 700,
                  color: Colors.black,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: CachedNetworkImage(
                    height: 52,
                    width: 52,
                    fit: BoxFit.cover,
                    imageUrl: widget.loggedInUserModel.avatar,
                    placeholder: (context, url) => Image.asset(
                      AppConfig.userIcon,
                      height: 170,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AppConfig.userIcon,
                      height: 170,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText(
                      "May 01, 2022",
                      fontSize: 18,
                      height: 1,
                      textAlign: TextAlign.start,
                      color: Colors.grey.shade700,
                    ),
                    FxText(
                      "Today",
                      height: 1.2,
                      fontWeight: 700,
                      color: Colors.black,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.unfold_more),
                ),
              ],
            ),
            FxCard(
              margin: EdgeInsets.only(top: 20),
              bordered: false,
              shadow: FxShadow(
                  elevation: 3, alpha: 20, offset: Offset.fromDirection(90)),
              color: Colors.white,
              width: double.infinity,
              paddingAll: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText(
                    "PROJECT NAME",
                    color: MyColors.primary,
                    fontWeight: 600,
                  ),
                  Divider(height: 30, color: MyColors.grey_10, thickness: 2),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 5, color: Colors.red.shade700),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          "New web UI Design project..",
                          color: MyColors.grey_90,
                          fontSize: 25,
                          textAlign: TextAlign.start,
                          height: 1,
                          maxLines: 1,
                          fontWeight: 600,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FxText(
                          "This is a simple reason why me and romina love each other .... there should",
                          color: MyColors.grey_60,
                          height: 1,
                          maxLines: 1,
                          fontWeight: 500,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Row(
                                children: [Icon(Icons.height)],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            FxCard(
              margin: EdgeInsets.only(top: 10),
              bordered: false,
              shadow: FxShadow(
                  elevation: 3, alpha: 20, offset: Offset.fromDirection(90)),
              color: Colors.white,
              width: double.infinity,
              paddingAll: 20,
              child: Column(
                children: [
                  Text("PROJECT NAME"),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
