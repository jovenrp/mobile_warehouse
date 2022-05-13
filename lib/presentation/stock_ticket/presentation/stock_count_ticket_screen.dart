import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/stock_count/bloc/stock_count_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_count/bloc/stock_count_state.dart';
import 'package:mobile_warehouse/presentation/stock_count/data/models/stock_count_item_model.dart';
import 'package:mobile_warehouse/presentation/stock_ticket/bloc/stock_count_ticket_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_ticket/bloc/stock_count_ticket_state.dart';

class StockCountTicketScreen extends StatefulWidget {
  StockCountTicketScreen({Key? key, this.stockCountItemModel}) : super(key: key);

  static const String routeName = '/stockCountTicketScreen';
  static const String screenName = 'stockCountTicketScreen';

  final StockCountItemModel? stockCountItemModel;

  static ModalRoute<StockCountTicketScreen> route({StockCountItemModel? stockCountItemModel}) => MaterialPageRoute<StockCountTicketScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => StockCountTicketScreen(stockCountItemModel: stockCountItemModel),
      );

  @override
  _StockCountTicketScreen createState() => _StockCountTicketScreen();
}

class _StockCountTicketScreen extends State<StockCountTicketScreen> {
  final TextEditingController skuController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final FocusNode skuNode = FocusNode();
  final FocusNode locationNode = FocusNode();

  @override
  void initState() {
    super.initState();
    skuController.text = widget.stockCountItemModel?.sku ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockCountTicketBloc, StockCountTicketState>(
        listener: (BuildContext context, StockCountTicketState state) {},
        builder: (BuildContext context, StockCountTicketState state) {
          return SafeArea(
              child: Scaffold(
                  appBar: ATAppBar(
                    title: 'Stock Count Ticket',
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      color: AppColors.white,
                      size: 24.0,
                    ),
                    onTap: () => Navigator.of(context).pop(),
                    actions: <Widget>[
                      state.isLoading
                          ? Container(
                              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 18),
                              width: 35,
                              child: ATLoadingIndicator(
                                strokeWidth: 3.0,
                                width: 10,
                                height: 10,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                  body: Container(
                      color: AppColors.beachSea,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ATSearchfield(
                            textEditingController: locationController,
                            hintText: 'Location',
                            focusNode: locationNode,
                            isScanner: true,
                            onPressed: () {},
                            onChanged: (String value) {},
                            onFieldSubmitted: (String? value) {},
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ATSearchfield(
                              textEditingController: skuController,
                              hintText: 'SKU',
                              focusNode: skuNode,
                              isScanner: true,
                              onFieldSubmitted: (String? value) {},
                              onPressed: () {},
                              onChanged: (String value) {}),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ATTextfield(
                              textEditingController: descriptionController, hintText: 'Description', onFieldSubmitted: (String? value) {}),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ATTextfield(textEditingController: quantityController, hintText: 'Quantity', onFieldSubmitted: (String? value) {}),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                            child: InteractiveViewer(
                                child: Container(
                                    color: AppColors.white,
                                    child: state.isLoading
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              SizedBox(height: 50),
                                              Padding(
                                                padding: const EdgeInsets.all(20),
                                                child: Icon(
                                                  Icons.move_to_inbox,
                                                  size: 100,
                                                  color: AppColors.grayElevent,
                                                ),
                                              ),
                                              Container(
                                                  alignment: Alignment.topCenter,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 10),
                                                    child: ATText(text: I18n.of(context).please_wait_while_data_is_loaded),
                                                  ))
                                            ],
                                          )
                                        : state.stockCountItemList?.isEmpty == true || state.stockCountItemList == null
                                            ? Container(
                                                alignment: Alignment.topCenter,
                                                width: double.infinity,
                                                color: AppColors.white,
                                                padding: const EdgeInsets.only(top: 30),
                                                child: ATText(text: I18n.of(context).oops_item_returned_0_results),
                                              )
                                            : ListView.builder(
                                                itemCount: (state.stockCountItemList?.length ?? 0),
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Ink(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            StockCountTicketScreen.route(stockCountItemModel: state.stockCountItemList?[index]));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.only(left: 20, right: 20),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            SizedBox(height: 10),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ATText(
                                                                  text: state.stockCountItemList?[index].sku,
                                                                  fontSize: 16,
                                                                  weight: FontWeight.bold,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    ATText(
                                                                      text: '${index + 1} items',
                                                                      fontSize: 16,
                                                                      weight: FontWeight.bold,
                                                                    ),
                                                                    Icon(
                                                                      // Based on passwordVisible state choose the icon
                                                                      Icons.navigate_next,
                                                                      color: AppColors.black,
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5),
                                                            ATText(text: state.stockCountItemList?[index].name, fontSize: 14),
                                                            ATText(text: state.stockCountItemList?[index].description, fontSize: 14),
                                                            SizedBox(height: 15),
                                                            Divider(
                                                              height: 1,
                                                              color: AppColors.black,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }))))
                      ]))));
        });
  }
}
