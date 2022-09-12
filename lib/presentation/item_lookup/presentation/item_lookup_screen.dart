import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/item_lookup/bloc/item_lookup_bloc.dart';
import 'package:mobile_warehouse/presentation/item_lookup/bloc/item_lookup_state.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/item_lookup/data/models/item_alias_model.dart';
import 'package:mobile_warehouse/presentation/qr/presentation/qr_item_lookup_screen.dart';

class ItemLookupScreen extends StatefulWidget {
  const ItemLookupScreen({Key? key}) : super(key: key);

  static const String routeName = '/itemLookup';
  static const String screenName = 'itemLookupScreen';

  static ModalRoute<ItemLookupScreen> route() =>
      MaterialPageRoute<ItemLookupScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ItemLookupScreen(),
      );

  @override
  _ItemLookupScreen createState() => _ItemLookupScreen();
}

class _ItemLookupScreen extends State<ItemLookupScreen> {
  final TextEditingController skuController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode skuNode = FocusNode();
  final FocusNode searchNode = FocusNode();
  String? alias;

  @override
  void initState() {
    super.initState();
    alias = '857928006702';
    context.read<ItemLookupBloc>().init();
    searchController.text = '857928006702';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemLookupBloc, ItemLookupState>(
        listener: (BuildContext context, ItemLookupState state) {},
        builder: (BuildContext context, ItemLookupState state) {
          return SafeArea(
            child: Scaffold(
                appBar: ATAppBar(
                  title: 'Item LookUp',
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.white,
                    size: 24.0,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  actions: <Widget>[
                    state.isLoading ||
                            state.isStockLoading ||
                            state.isTrakLoading
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
                            hintText: I18n.of(context).search_alias,
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                              return QRItemLookUpScreen();
                            })),
                            onFieldSubmitted: (String? value) {
                              alias = searchController.text;
                              context
                                  .read<ItemLookupBloc>()
                                  .lookupItemAlias(item: searchController.text)
                                  .then((List<ItemAliasModel>? itemAlias) {
                                //context.read<ItemLookupBloc>().lookupBarcodeStock(item: '4611');
                                context
                                    .read<ItemLookupBloc>()
                                    .lookupBarcodeStock(
                                        item: itemAlias?.first.itemId);
                                context.read<ItemLookupBloc>().getItemTrakList(
                                    item: itemAlias?.first.itemId);
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                            child: !state.isLoading
                                ? Container(
                                    color: AppColors.white,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, top: 0, bottom: 10),
                                    child: state.itemAlias?.isNotEmpty == true
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Visibility(
                                                      visible: state.itemAlias
                                                              ?.isNotEmpty ==
                                                          true,
                                                      child: Table(
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
                                                            TableRow(children: <
                                                                Widget>[
                                                              Container(
                                                                color: AppColors
                                                                    .greyHeader,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                child: ATText(
                                                                  fontColor:
                                                                      AppColors
                                                                          .white,
                                                                  text: 'ITEM',
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Container(
                                                                color: AppColors
                                                                    .greyHeader,
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        top: 5,
                                                                        bottom:
                                                                            5,
                                                                        right:
                                                                            10),
                                                                child: ATText(
                                                                  fontColor:
                                                                      AppColors
                                                                          .white,
                                                                  text: 'SKU',
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ]),
                                                            TableRow(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                    child: ATText(
                                                                        text: state
                                                                            .itemAlias
                                                                            ?.first
                                                                            .itemNum,
                                                                        fontSize:
                                                                            14,
                                                                        fontColor:
                                                                            AppColors
                                                                                .black,
                                                                        weight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        top: 5,
                                                                        bottom:
                                                                            5,
                                                                        right:
                                                                            10),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child: ATText(
                                                                        text: state
                                                                            .itemAlias
                                                                            ?.first
                                                                            .sku,
                                                                        fontSize:
                                                                            14,
                                                                        fontColor:
                                                                            AppColors
                                                                                .black,
                                                                        weight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ])
                                                          ])),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: ATText(
                                                        text: state.itemAlias
                                                            ?.first.itemName,
                                                        fontSize: 20,
                                                        fontColor:
                                                            AppColors.black,
                                                        weight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15),
                                                ],
                                              ),
                                              Visibility(
                                                  visible: state.itemAlias
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
                                                                  AppColors
                                                                      .white,
                                                              text: 'ALIAS',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          Container(
                                                            color: AppColors
                                                                .greyHeader,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 6,
                                                                    bottom: 6,
                                                                    right: 10),
                                                            child: ATText(
                                                              fontColor:
                                                                  AppColors
                                                                      .white,
                                                              text: 'TYPE',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ])
                                                      ])),
                                              Flexible(
                                                child: ListView.builder(
                                                    itemCount: (state.itemAlias
                                                            ?.length ??
                                                        0),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
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
                                                                    color: AppColors
                                                                        .beachSeaTint40),
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    color: AppColors
                                                                        .beachSeaTint20,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            6,
                                                                        top: 6),
                                                                    child: ATText(
                                                                        text: state
                                                                            .itemAlias?[
                                                                                index]
                                                                            .code,
                                                                        fontSize:
                                                                            14,
                                                                        fontColor:
                                                                            AppColors.white),
                                                                  ),
                                                                  Container(
                                                                    color: AppColors
                                                                        .beachSeaTint40,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            6,
                                                                        top: 6,
                                                                        right:
                                                                            10),
                                                                    child: ATText(
                                                                        text: state
                                                                            .itemAlias?[
                                                                                index]
                                                                            .type,
                                                                        fontSize:
                                                                            14,
                                                                        fontColor:
                                                                            AppColors.white),
                                                                  ),
                                                                ])
                                                          ]);
                                                    }),
                                              ),
                                              Visibility(
                                                  visible: state.itemTrak
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
                                                                  AppColors
                                                                      .white,
                                                              text:
                                                                  'TRAK LOCATIONS',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          Container(
                                                            color: AppColors
                                                                .greyHeader,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 6,
                                                                    bottom: 6,
                                                                    right: 10),
                                                            child: ATText(
                                                              fontColor:
                                                                  AppColors
                                                                      .white,
                                                              text: 'NUM',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ])
                                                      ])),
                                              Flexible(
                                                child: ListView.builder(
                                                    itemCount: (state
                                                            .itemTrak?.length ??
                                                        0),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
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
                                                                    color: AppColors
                                                                        .beachSeaTint40),
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    color: AppColors
                                                                        .beachSeaTint20,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            6,
                                                                        top: 6),
                                                                    child: ATText(
                                                                        text: state
                                                                            .itemTrak?[
                                                                                index]
                                                                            .containerCode,
                                                                        fontSize:
                                                                            14,
                                                                        fontColor:
                                                                            AppColors.white),
                                                                  ),
                                                                  Container(
                                                                    color: AppColors
                                                                        .beachSeaTint40,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            6,
                                                                        top: 6,
                                                                        right:
                                                                            10),
                                                                    child: ATText(
                                                                        text: state
                                                                            .itemTrak?[
                                                                                index]
                                                                            .containerNum,
                                                                        fontSize:
                                                                            14,
                                                                        fontColor:
                                                                            AppColors.white),
                                                                  ),
                                                                ])
                                                          ]);
                                                    }),
                                              ),
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
                                                                  AppColors
                                                                      .white,
                                                              text: 'STOCK',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          Container(
                                                            color: AppColors
                                                                .greyHeader,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 6,
                                                                    bottom: 6,
                                                                    right: 10),
                                                            child: ATText(
                                                              fontColor:
                                                                  AppColors
                                                                      .white,
                                                              text: 'QTY',
                                                              weight: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ])
                                                      ])),
                                              Flexible(
                                                child: ListView.builder(
                                                    itemCount: (state.itemStock
                                                            ?.length ??
                                                        0),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
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
                                                                    color: AppColors
                                                                        .beachSeaTint40),
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    color: AppColors
                                                                        .beachSeaTint20,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            6,
                                                                        top: 6),
                                                                    child: ATText(
                                                                        text: state
                                                                            .itemStock?[
                                                                                index]
                                                                            .containerCode,
                                                                        fontSize:
                                                                            14,
                                                                        fontColor:
                                                                            AppColors.white),
                                                                  ),
                                                                  Container(
                                                                    color: AppColors
                                                                        .beachSeaTint40,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            6,
                                                                        top: 6,
                                                                        right:
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: <
                                                                          Widget>[
                                                                        ATText(
                                                                            text:
                                                                                state.itemStock?[index].qty,
                                                                            fontSize: 14,
                                                                            fontColor: AppColors.white),
                                                                        SizedBox(
                                                                            width:
                                                                                2),
                                                                        ATText(
                                                                            text:
                                                                                state.itemStock?[index].uom,
                                                                            fontSize: 10,
                                                                            fontColor: AppColors.white)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ])
                                                          ]);
                                                    }),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            color: AppColors.white,
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: ATText(
                                                  text: state.isInit
                                                      ? I18n.of(context)
                                                          .enter_an_alias_to_be_search
                                                      : I18n.of(context)
                                                          .oops_item_returned_0_results),
                                            ),
                                          ),
                                  )
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
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: ATText(
                                                  text: I18n.of(context)
                                                      .please_wait_while_data_is_loaded),
                                            ))
                                      ],
                                    )))
                      ],
                    ))),
          );
        });
  }
}
