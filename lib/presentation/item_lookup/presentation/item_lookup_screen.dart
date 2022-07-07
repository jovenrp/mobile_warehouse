import 'package:easy_debounce/easy_debounce.dart';
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
    //context.read<ItemLookupBloc>().lookupItemAlias(item: alias);
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
                    state.isLoading
                        ? Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 18),
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
                            hintText: I18n
                                .of(context)
                                .search,
                            onChanged: (String value) {
                              EasyDebounce.debounce('deebouncer1', Duration(milliseconds: 700), () {
                                setState(() {
                                  context.read<ItemLookupBloc>().searchItem(searchItem: searchController.text, value: alias);
                                  //FocusManager.instance.primaryFocus?.unfocus();
                                });
                              });
                            },
                            onFieldSubmitted: (String? value) {
                              alias = searchController.text;
                              context.read<ItemLookupBloc>().lookupItemAlias(item: searchController.text).then((_) {
                                context.read<ItemLookupBloc>().lookupBarcodeStock(item: '4611');
                                context
                                    .read<ItemLookupBloc>()
                                    .getItemTrakList(item: state.itemAlias?.first.itemId);
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                            child: !state.isLoading
                                ? Container(
                              color: AppColors.white,
                              padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
                              child: state.itemAlias?.isNotEmpty == true
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppColors.beachSea,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              ATText(
                                                  text: state.itemAlias?.first.itemId,
                                                  fontSize: 14,
                                                  fontColor: AppColors.white,
                                                  weight: FontWeight.bold),
                                              ATText(
                                                  text: state.itemAlias?.first.itemNum,
                                                  fontSize: 14,
                                                  fontColor: AppColors.white,
                                                  weight: FontWeight.bold),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          ATText(
                                              text: state.itemAlias?.first.itemName,
                                              fontSize: 20,
                                              fontColor: AppColors.white,
                                              weight: FontWeight.bold)
                                        ],
                                      )),
                                  Visibility(
                                      visible: state.itemAlias?.isNotEmpty == true,
                                      child: Table(
                                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                          columnWidths: const <int, TableColumnWidth>{
                                            0: FlexColumnWidth(100),
                                            1: FlexColumnWidth(100),
                                          },
                                          children: <TableRow>[
                                            TableRow(children: <Widget>[
                                              Container(
                                                color: AppColors.greyHeader,
                                                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                                                child: ATText(
                                                  fontColor: AppColors.white,
                                                  text: 'CODE',
                                                  weight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                color: AppColors.greyHeader,
                                                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                                                child: ATText(
                                                  fontColor: AppColors.white,
                                                  text: 'TYPE',
                                                  weight: FontWeight.bold,
                                                ),
                                              ),
                                            ])
                                          ])),
                                  Expanded(
                                    child: ListView.separated(
                                        itemCount: (state.itemAlias?.length ?? 0),
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Divider(
                                            height: .1,
                                          );
                                        },
                                        itemBuilder: (BuildContext context, int index) {
                                          return Table(
                                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                              columnWidths: const <int, TableColumnWidth>{
                                                0: FlexColumnWidth(100),
                                                1: FlexColumnWidth(100),
                                              },
                                              children: <TableRow>[
                                                TableRow(children: <Widget>[
                                                  Container(
                                                    color: AppColors.beachSeaTint20,
                                                    padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                                                    child: ATText(
                                                        text: state.itemAlias?[index].code,
                                                        fontSize: 14,
                                                        fontColor: AppColors.white,
                                                        weight: FontWeight.bold),
                                                  ),
                                                  Container(
                                                    color: AppColors.beachSeaTint40,
                                                    padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                                                    child: ATText(
                                                        text: state.itemAlias?[index].type,
                                                        fontSize: 14,
                                                        fontColor: AppColors.white,
                                                        weight: FontWeight.bold),
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
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ATText(text: I18n
                                      .of(context)
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
                                          padding: const EdgeInsets.only(top: 10),
                                          child: ATText(text: I18n
                                              .of(context)
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
