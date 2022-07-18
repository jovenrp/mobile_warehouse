import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_alias_model.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/bloc/stock_adjust_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/bloc/stock_adjust_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/stock_adjust/data/models/stock_adjust_model.dart';

class StockAdjustScreen extends StatefulWidget {
  const StockAdjustScreen({Key? key}) : super(key: key);

  static const String routeName = '/stockAdjust';
  static const String screenName = 'stockAdjustScreen';

  static ModalRoute<StockAdjustScreen> route() =>
      MaterialPageRoute<StockAdjustScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const StockAdjustScreen(),
      );

  @override
  _StockAdjustScreen createState() => _StockAdjustScreen();
}

class _StockAdjustScreen extends State<StockAdjustScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchNode = FocusNode();
  bool isInit = false;

  List<TextEditingController> qtyControllers = <TextEditingController>[];
  List<TextEditingController> adjustControllers = <TextEditingController>[];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockAdjustBloc, StockAdjustState>(
        listener: (BuildContext context, StockAdjustState state) {},
        builder: (BuildContext context, StockAdjustState state) {
          return SafeArea(
              child: Scaffold(
            appBar: ATAppBar(
              title: 'Stock Adjust',
              icon: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
              actions: <Widget>[
                state.isLoading || state.isStockLoading
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
            ),
            body: Container(
              color: AppColors.beachSea,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: ATSearchfield(
                        textEditingController: searchController,
                        focusNode: searchNode,
                        isScanner: true,
                        hintText: '${I18n.of(context).search} SKU',
                        onFieldSubmitted: (String? value) {
                          context
                              .read<StockAdjustBloc>()
                              .lookupItemAlias(item: searchController.text)
                              .then((List<ItemAliasModel>? itemAlias) {
                            //context.read<ItemLookupBloc>().lookupBarcodeStock(item: '4611');
                            context
                                .read<StockAdjustBloc>()
                                .lookupBarcodeStock(
                                    item: itemAlias?.first.itemId)
                                .then((value) => isInit = false);
                            qtyControllers = <TextEditingController>[];
                            adjustControllers = <TextEditingController>[];
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                        child: !state.isLoading || !state.isStockLoading
                            ? Container(
                                color: AppColors.white,
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 0, bottom: 10),
                                child: state.itemStock?.isNotEmpty == true
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                            Visibility(
                                                visible: state.itemStock
                                                        ?.isNotEmpty ==
                                                    true,
                                                child: Table(
                                                    defaultVerticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    columnWidths: const <int,
                                                        TableColumnWidth>{
                                                      0: FlexColumnWidth(100),
                                                      1: FlexColumnWidth(100),
                                                    },
                                                    children: <TableRow>[
                                                      TableRow(children: <
                                                          Widget>[
                                                        Container(
                                                          color: AppColors
                                                              .greyHeader,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 6,
                                                                  bottom: 6),
                                                          child: ATText(
                                                            fontColor:
                                                                AppColors.white,
                                                            text:
                                                                'LOCATION CODE',
                                                            weight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Container(
                                                          color: AppColors
                                                              .greyHeader,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 6,
                                                                  bottom: 6,
                                                                  right: 10),
                                                          child: ATText(
                                                            fontColor:
                                                                AppColors.white,
                                                            text: 'UOM',
                                                            weight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ])
                                                    ])),
                                            Flexible(
                                              child: ListView.builder(
                                                  itemCount: (state
                                                          .itemStock?.length ??
                                                      0),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    qtyControllers.add(
                                                        TextEditingController());
                                                    adjustControllers.add(
                                                        TextEditingController());
                                                    if (!isInit) {
                                                      qtyControllers[index]
                                                          .text = state
                                                              .itemStock?[index]
                                                              .qty ??
                                                          '0';
                                                      if (index ==
                                                          state.itemStock!
                                                                  .length -
                                                              1) {
                                                        isInit = true;
                                                      }
                                                    }
                                                    return Table(
                                                        defaultVerticalAlignment:
                                                            TableCellVerticalAlignment
                                                                .middle,
                                                        columnWidths: const <
                                                            int,
                                                            TableColumnWidth>{
                                                          0: FlexColumnWidth(
                                                              100),
                                                          1: FlexColumnWidth(
                                                              100),
                                                        },
                                                        children: <TableRow>[
                                                          TableRow(
                                                              decoration: BoxDecoration(
                                                                  color: index
                                                                          .isEven
                                                                      ? AppColors
                                                                          .beachSeaTint40
                                                                      : AppColors
                                                                          .beachSeaTint20),
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      bottom: 6,
                                                                      top: 6),
                                                                  child: ATText(
                                                                    text: state
                                                                        .itemStock?[
                                                                            index]
                                                                        .containerCode,
                                                                    fontSize:
                                                                        18,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      bottom: 6,
                                                                      top: 6,
                                                                      right:
                                                                          10),
                                                                  child: ATText(
                                                                      text: state
                                                                          .itemStock?[
                                                                              index]
                                                                          .uom,
                                                                      fontSize:
                                                                          14,
                                                                      fontColor:
                                                                          AppColors
                                                                              .white),
                                                                ),
                                                              ]),
                                                          TableRow(
                                                              decoration: BoxDecoration(
                                                                  color: index
                                                                          .isEven
                                                                      ? AppColors
                                                                          .beachSeaTint40
                                                                      : AppColors
                                                                          .beachSeaTint20),
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      bottom: 6,
                                                                      top: 6),
                                                                  child: ATText(
                                                                      text:
                                                                          'Quantity',
                                                                      fontSize:
                                                                          14,
                                                                      fontColor:
                                                                          AppColors
                                                                              .white),
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      bottom: 6,
                                                                      top: 6,
                                                                      right:
                                                                          10),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      ATText(
                                                                          text:
                                                                              'Adjust',
                                                                          fontSize:
                                                                              14,
                                                                          fontColor:
                                                                              AppColors.white),
                                                                      ATText(
                                                                          text:
                                                                              ' (minus to subtract)',
                                                                          fontSize:
                                                                              12,
                                                                          style: TextStyle(
                                                                              fontStyle: FontStyle.italic,
                                                                              color: AppColors.white)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ]),
                                                          TableRow(
                                                              decoration: BoxDecoration(
                                                                  color: index
                                                                          .isEven
                                                                      ? AppColors
                                                                          .beachSeaTint40
                                                                      : AppColors
                                                                          .beachSeaTint20),
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            10),
                                                                    child:
                                                                        ATTextfield(
                                                                      hintText:
                                                                          '0',
                                                                      textEditingController:
                                                                          qtyControllers[
                                                                              index],
                                                                      onFieldSubmitted:
                                                                          (String?
                                                                              value) {
                                                                        context
                                                                            .read<
                                                                                StockAdjustBloc>()
                                                                            .stockAdjust(
                                                                                absolute: true,
                                                                                stockId: state.itemStock?[index].id,
                                                                                qty: value)
                                                                            .then((List<StockAdjustModel>? stockModel) {
                                                                          setState(
                                                                              () {
                                                                            qtyControllers[index].text =
                                                                                stockModel?.first.qty ?? '0';
                                                                          });
                                                                        });
                                                                      },
                                                                    )),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            10),
                                                                    child: ATTextfield(
                                                                        hintText: '0',
                                                                        textEditingController: adjustControllers[index],
                                                                        onFieldSubmitted: (String? value) {
                                                                          context
                                                                              .read<StockAdjustBloc>()
                                                                              .stockAdjust(absolute: false, stockId: state.itemStock?[index].id, qty: value)
                                                                              .then((List<StockAdjustModel>? stockModel) {
                                                                            setState(() {
                                                                              qtyControllers[index].text = stockModel?.first.qty ?? '0';
                                                                              adjustControllers[index].text = '';
                                                                            });
                                                                          });
                                                                        })),
                                                              ])
                                                        ]);
                                                  }),
                                            ),
                                          ])
                                    : Container(
                                        color: AppColors.white,
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          child: ATText(
                                              text: I18n.of(context)
                                                  .oops_item_returned_0_results),
                                        ),
                                      ))
                            : Container(
                                color: AppColors.white,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 50),
                                    Container(
                                      child: ATLoadingIndicator(
                                        strokeWidth: 3.0,
                                        width: 30,
                                        height: 30,
                                        color: AppColors.beachSea,
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ATText(
                                              text: I18n.of(context)
                                                  .please_wait_while_data_is_loaded),
                                        ))
                                  ],
                                )))
                  ]),
            ),
          ));
        });
  }
}
