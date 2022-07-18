import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/dashboard/presentation/action_cards_widget.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/presentation/stock_adjust_screen.dart';

class StockActionsScreen extends StatefulWidget {
  const StockActionsScreen({Key? key}) : super(key: key);

  static const String routeName = '/stockActions';
  static const String screenName = 'stockActionsScreen';

  static ModalRoute<StockActionsScreen> route() =>
      MaterialPageRoute<StockActionsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const StockActionsScreen(),
      );

  @override
  _StockActionsScreen createState() => _StockActionsScreen();
}

class _StockActionsScreen extends State<StockActionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ATAppBar(
              title: 'Stock Actions',
              icon: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            body: Stack(children: <Widget>[
              Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.beachSea,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 20),
                    child: ATText(
                      text: 'Which action would you like to do today?',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, bottom: 15),
                        child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: <Widget>[
                              InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(StockAdjustScreen.route()),
                                child: ActionCardsWidget(
                                  title: 'Stock Adjust',
                                  description: '',
                                  icon: Icon(Icons.note,
                                      color: AppColors.white, size: 70),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: ActionCardsWidget(
                                  title: 'Stock Move',
                                  description: '',
                                  icon: Icon(Icons.edit_location_outlined,
                                      color: AppColors.white, size: 70),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: ActionCardsWidget(
                                  title: 'Stock Yield',
                                  description:
                                      I18n.of(context).stock_count_description,
                                  icon: Icon(Icons.warning_amber_rounded,
                                      color: AppColors.white, size: 70),
                                  quarterTurns: 2,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: ActionCardsWidget(
                                  title: 'Stock Consume',
                                  icon: Icon(Icons.data_usage,
                                      color: AppColors.white, size: 70),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: ActionCardsWidget(
                                  title: 'Stock Receive',
                                  description: '',
                                  icon: Icon(Icons.call_received,
                                      color: AppColors.white, size: 70),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: ActionCardsWidget(
                                  title: 'Stock Ship',
                                  description: '',
                                  icon: Icon(Icons.local_shipping,
                                      color: AppColors.white, size: 70),
                                ),
                              ),
                            ])),
                  )
                ],
              )
            ])));
  }
}
