import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/stock_move/bloc/stock_move_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_move/bloc/stock_move_state.dart';

class StockMoveScreen extends StatefulWidget {
  const StockMoveScreen({Key? key}) : super(key: key);

  static const String routeName = '/stockMove';
  static const String screenName = 'stockMoveScreen';

  static ModalRoute<StockMoveScreen> route() =>
      MaterialPageRoute<StockMoveScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const StockMoveScreen(),
      );

  @override
  _StockMoveScreen createState() => _StockMoveScreen();
}

class _StockMoveScreen extends State<StockMoveScreen> {
  final TextEditingController containerFromController = TextEditingController();
  final FocusNode containerFromNode = FocusNode();

  final TextEditingController containerToController = TextEditingController();
  final FocusNode containerToNode = FocusNode();

  final TextEditingController skuController = TextEditingController();
  final FocusNode skuNode = FocusNode();

  final TextEditingController qtyController = TextEditingController();
  final FocusNode qtyNode = FocusNode();

  bool isFromEmpty = false;
  bool isToEmpty = false;
  bool isSkuEmpty = false;
  bool isQtyEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockMoveBloc, StockMoveState>(
        listener: (BuildContext context, StockMoveState state) {},
        builder: (BuildContext context, StockMoveState state) {
          return SafeArea(
              child: Scaffold(
                  appBar: ATAppBar(
                      title: 'Stock Move',
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        color: AppColors.white,
                        size: 24.0,
                      ),
                      actions: <Widget>[
                        state.isLoading
                            ? Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, right: 18),
                                width: 35,
                                child: ATLoadingIndicator(
                                  strokeWidth: 3.0,
                                  width: 15,
                                  height: 10,
                                ),
                              )
                            : SizedBox()
                      ],
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  body: Container(
                    color: AppColors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Visibility(
                            visible: isFromEmpty,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, bottom: 5),
                              width: double.infinity,
                              color: AppColors.beachSea,
                              child: ATText(
                                text: 'Container from must have a value.',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.atWarningRed,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.beachSea,
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 20),
                            child: ATSearchfield(
                                hintText: 'Container From',
                                textEditingController: containerFromController,
                                focusNode: containerFromNode,
                                isScanner: true,
                                /*onPressed: () => Navigator.push(context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return QRContainerMoveScreen(
                                          scanner: 'serial',
                                          isDestination: false);
                                    })),*/
                                onFieldSubmitted: (String? value) {
                                  setState(() {
                                    if (containerFromController.text
                                            .trim()
                                            .isNotEmpty ==
                                        true) {
                                      skuNode.requestFocus();
                                      isFromEmpty = false;
                                      context
                                          .read<StockMoveBloc>()
                                          .searchContainer(
                                              containerNum:
                                                  containerFromController.text
                                                      .trim(),
                                              isDestination: false);
                                    } else {
                                      isFromEmpty = true;
                                    }
                                  });
                                }),
                          ),
                          Visibility(
                            visible: isSkuEmpty,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, bottom: 5),
                              width: double.infinity,
                              color: AppColors.beachSea,
                              child: ATText(
                                text: 'SKU must have a value.',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.atWarningRed,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.beachSea,
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 20),
                            child: ATSearchfield(
                                hintText: 'SKU',
                                textEditingController: skuController,
                                focusNode: skuNode,
                                isScanner: true,
                                onFieldSubmitted: (String? value) {
                                  setState(() {
                                    if (skuController.text.trim().isNotEmpty ==
                                        true) {
                                      qtyNode.requestFocus();
                                      isSkuEmpty = false;
                                    } else {
                                      isSkuEmpty = true;
                                    }
                                  });
                                }),
                          ),
                          Visibility(
                            visible: isQtyEmpty,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, bottom: 5),
                              width: double.infinity,
                              color: AppColors.beachSea,
                              child: ATText(
                                text: 'Qty must have a value.',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.atWarningRed,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.beachSea,
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 20),
                            child: ATSearchfield(
                                hintText: 'Qty',
                                textEditingController: qtyController,
                                focusNode: qtyNode,
                                isScanner: false,
                                onFieldSubmitted: (String? value) {
                                  setState(() {
                                    if (qtyController.text.trim().isNotEmpty ==
                                        true) {
                                      containerToNode.requestFocus();
                                      isQtyEmpty = false;
                                    } else {
                                      isQtyEmpty = true;
                                    }
                                  });
                                }),
                          ),
                          Visibility(
                            visible: isToEmpty,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, bottom: 5),
                              width: double.infinity,
                              color: AppColors.beachSea,
                              child: ATText(
                                text: 'Container To must have a value.',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.atWarningRed,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.beachSea,
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 20),
                            child: ATSearchfield(
                                hintText: 'Container To',
                                textEditingController: containerToController,
                                focusNode: containerToNode,
                                isScanner: true,
                                /*onPressed: () => Navigator.push(context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return QRContainerMoveScreen(
                                          scanner: 'serial',
                                          isDestination: false);
                                    })),*/
                                onFieldSubmitted: (String? value) {
                                  setState(() {
                                    if (containerFromController.text
                                            .trim()
                                            .isNotEmpty ==
                                        true) {
                                      isFromEmpty = false;
                                      if (skuController.text
                                              .trim()
                                              .isNotEmpty ==
                                          true) {
                                        isSkuEmpty = false;
                                        if (qtyController.text
                                                .trim()
                                                .isNotEmpty ==
                                            true) {
                                          isQtyEmpty = false;
                                          if (containerToController.text
                                                  .trim()
                                                  .isNotEmpty ==
                                              true) {
                                            isToEmpty = false;
                                            //execute logic here
                                            context
                                                .read<StockMoveBloc>()
                                                .searchContainer(
                                                    containerNum:
                                                        containerToController
                                                            .text
                                                            .trim(),
                                                    isDestination: true);
                                          } else {
                                            isToEmpty = true;
                                            containerToNode.requestFocus();
                                          }
                                        } else {
                                          isQtyEmpty = true;
                                          qtyNode.requestFocus();
                                        }
                                      } else {
                                        isSkuEmpty = true;
                                        skuNode.requestFocus();
                                      }
                                    } else {
                                      isFromEmpty = true;
                                      containerFromNode.requestFocus();
                                    }
                                  });

                                  /*context
                                  .read<ContainerMoveBloc>()
                                  .searchContainer(
                                  containerNum: value,
                                  isDestination: false)
                                  .then((List<ContainerModel> container) {
                                destContainerNumNode.requestFocus();
                              });*/
                                }),
                          ),
                        ]),
                  )));
        });
  }
}
