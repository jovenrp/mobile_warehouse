import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';

class ContainerMoveScreen extends StatefulWidget {
  const ContainerMoveScreen({Key? key}) : super(key: key);

  static const String routeName = '/stockMove';
  static const String screenName = 'stockMoveScreen';

  static ModalRoute<ContainerMoveScreen> route() =>
      MaterialPageRoute<ContainerMoveScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ContainerMoveScreen(),
      );

  @override
  _ContainerMoveScreen createState() => _ContainerMoveScreen();
}

class _ContainerMoveScreen extends State<ContainerMoveScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ATAppBar(
          title: 'Stock Move',
          icon: Icon(
            Icons.arrow_back_sharp,
            color: AppColors.white,
            size: 24.0,
          ),
          onTap: () {
            Navigator.of(context).pop();
          }),
      body: Container(
          color: AppColors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(
              color: AppColors.beachSea,
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
              child: ATSearchfield(
                  hintText: 'Search',
                  isScanner: true,
                  onPressed: () {},
                  onChanged: (String value) {
                    EasyDebounce.debounce(
                        'deebouncer1', Duration(milliseconds: 700), () {});
                  }),
            ),
            Container(
              color: AppColors.beachSea,
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
              child: ATSearchfield(
                  hintText: 'Move To',
                  isScanner: true,
                  onPressed: () {},
                  onChanged: (String value) {
                    EasyDebounce.debounce(
                        'deebouncer1', Duration(milliseconds: 700), () {});
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
              color: AppColors.beachSeaTint20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    color: AppColors.greyHeader,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ATText(
                            text: 'ITEM',
                            fontSize: 16,
                            fontColor: AppColors.white,
                            weight: FontWeight.bold,
                          ),
                          ATText(
                            text: 'QTY',
                            fontSize: 16,
                            fontColor: AppColors.white,
                            weight: FontWeight.bold,
                          )
                        ]),
                  ),
                  SizedBox(height: 6),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ATText(
                          text: '10001',
                          fontSize: 16,
                          fontColor: AppColors.white,
                        ),
                        ATText(
                          text: '20 disp',
                          fontSize: 16,
                          fontColor: AppColors.white,
                        )
                      ]),
                  SizedBox(height: 6),
                  ATText(
                    text: 'A-01-01',
                    fontSize: 18,
                    weight: FontWeight.bold,
                    fontColor: AppColors.white,
                  ),
                  SizedBox(height: 6),
                  ATText(
                    text: '1/2" Elbow - Galvanized',
                    fontSize: 18,
                    weight: FontWeight.bold,
                    fontColor: AppColors.white,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
              color: AppColors.beachSeaTint40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  ATText(
                    text: 'Moving To',
                    fontSize: 16,
                    fontColor: AppColors.white,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ATText(
                          text: '10001',
                          fontSize: 16,
                          fontColor: AppColors.white,
                        ),
                        ATText(
                          text: '20 disp',
                          fontSize: 16,
                          fontColor: AppColors.white,
                        )
                      ]),
                  SizedBox(height: 6),
                  ATText(
                    text: 'B-04-01',
                    fontSize: 18,
                    weight: FontWeight.bold,
                    fontColor: AppColors.atWarningRed,
                  ),
                  SizedBox(height: 6),
                  ATText(
                    text: '1/2" Elbow - Galvanized',
                    fontSize: 18,
                    weight: FontWeight.bold,
                    fontColor: AppColors.white,
                  ),
                ],
              ),
            )
          ])),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ATTextButton(
            buttonText: 'Confirm',
          )),
    ));
  }
}
