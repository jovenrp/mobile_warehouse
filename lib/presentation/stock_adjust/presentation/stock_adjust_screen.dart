import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_alias_model.dart';
import 'package:mobile_warehouse/presentation/qr/presentation/qr_stock_adjust_screen.dart';
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
  final TextEditingController locationController = TextEditingController();
  final FocusNode locationNode = FocusNode();
  bool isInit = false;

  TextEditingController quantityControllers = TextEditingController();
  List<TextEditingController> qtyControllers = <TextEditingController>[];
  List<TextEditingController> adjustControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    context.read<StockAdjustBloc>().init();
  }

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
                state.isLoading || state.isStockLoading || state.isAdjustLoading
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
                        textEditingController: locationController,
                        focusNode: locationNode,
                        isScanner: true,
                        hintText: '${I18n.of(context).search} Location/Code',
                        onFieldSubmitted: (String? value) {
                          if (searchController.text.trim().isEmpty == true) {
                            searchNode.requestFocus();
                          } else if (locationController.text
                                      .trim()
                                      .isNotEmpty ==
                                  true &&
                              searchController.text.trim().isNotEmpty == true) {
                            context.read<StockAdjustBloc>().stockLookUp(
                                sku: searchController.text,
                                locNum: locationController.text);
                          }
                        },
                        onPressed: () async {
                          String? code = await Navigator.push(context,
                              MaterialPageRoute<String>(
                                  builder: (BuildContext context) {
                            return QRStockAdjustScreen(
                                sku: searchController.text.trim().isNotEmpty
                                    ? searchController.text
                                    : '');
                          }));
                          locationController.text = code ?? '';
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: ATSearchfield(
                        textEditingController: searchController,
                        focusNode: searchNode,
                        isScanner: true,
                        hintText: '${I18n.of(context).search} SKU',
                        onFieldSubmitted: (String? value) {
                          if (locationController.text.trim().isEmpty == true) {
                            locationNode.requestFocus();
                          } else if (locationController.text
                                      .trim()
                                      .isNotEmpty ==
                                  true &&
                              searchController.text.trim().isNotEmpty == true) {
                            context.read<StockAdjustBloc>().stockLookUp(
                                sku: searchController.text,
                                locNum: locationController.text);
                          }
                        },
                        onPressed: () async {
                          String? code = await Navigator.push(context,
                              MaterialPageRoute<String>(
                                  builder: (BuildContext context) {
                            return QRStockAdjustScreen(
                                location:
                                    locationController.text.trim().isNotEmpty
                                        ? locationController.text
                                        : '');
                          }));
                          searchController.text = code ?? '';
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
                                child: state.stockItems?.isNotEmpty == true
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                            Visibility(
                                                visible: state.stockItems
                                                        ?.isNotEmpty ==
                                                    true,
                                                child: Table(
                                                    defaultVerticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    columnWidths: const <int,
                                                        TableColumnWidth>{
                                                      0: FlexColumnWidth(2),
                                                      1: FlexColumnWidth(1),
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
                                                            text: 'ITEM',
                                                            weight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
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
                                                            text: 'ON-HAND',
                                                            weight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ])
                                                    ])),
                                            Flexible(
                                              child: ListView.builder(
                                                  itemCount: (state
                                                          .stockItems?.length ??
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
                                                              .stockItems?[
                                                                  index]
                                                              .qty ??
                                                          '0';
                                                      if (index ==
                                                          state.stockItems!
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
                                                          0: FlexColumnWidth(2),
                                                          1: FlexColumnWidth(1),
                                                        },
                                                        children: <TableRow>[
                                                          TableRow(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
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
                                                                        .stockItems?[
                                                                            index]
                                                                        .sku,
                                                                    fontSize:
                                                                        16,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      bottom: 6,
                                                                      top: 6,
                                                                      right:
                                                                          10),
                                                                  child: ATText(
                                                                      text:
                                                                          '${state.stockItems?[index].qty} ${state.stockItems?[index].uom}',
                                                                      fontSize:
                                                                          16,
                                                                      fontColor:
                                                                          AppColors
                                                                              .white),
                                                                ),
                                                              ]),
                                                          TableRow(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
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
                                                                        .stockItems?[
                                                                            index]
                                                                        .name,
                                                                    fontSize:
                                                                        16,
                                                                    fontColor:
                                                                        AppColors
                                                                            .white,
                                                                  ),
                                                                ),
                                                                SizedBox(),
                                                              ]),
                                                        ]);
                                                  }),
                                            ),
                                            Visibility(
                                                visible: state.stockItems
                                                        ?.isNotEmpty ==
                                                    true,
                                                child: Table(
                                                    defaultVerticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    columnWidths: const <int,
                                                        TableColumnWidth>{
                                                      0: FlexColumnWidth(2),
                                                      1: FlexColumnWidth(1),
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
                                                            text: 'ADJUST',
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
                                                          child: SizedBox(
                                                              height: 16),
                                                        ),
                                                      ])
                                                    ])),
                                            Center(
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10, top: 20),
                                                  child: ATTextfield(
                                                      hintText: '0',
                                                      textEditingController:
                                                          quantityControllers,
                                                      onFieldSubmitted:
                                                          (String? value) {
                                                        context
                                                            .read<
                                                                StockAdjustBloc>()
                                                            .stockAdjust(
                                                                absolute: false,
                                                                containerId: state
                                                                    .stockItems
                                                                    ?.first
                                                                    .containerId,
                                                                sku: state
                                                                    .stockItems
                                                                    ?.first
                                                                    .sku,
                                                                qty: value)
                                                            .then((List<
                                                                    StockAdjustModel>?
                                                                stockModel) {
                                                          quantityControllers
                                                              .clear();
                                                          context
                                                              .read<
                                                                  StockAdjustBloc>()
                                                              .stockLookUp(
                                                                  sku:
                                                                      searchController
                                                                          .text,
                                                                  locNum:
                                                                      locationController
                                                                          .text);
                                                        });
                                                      })),
                                            )
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
