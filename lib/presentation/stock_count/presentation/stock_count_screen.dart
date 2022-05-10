import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/stock_count/bloc/stock_count_bloc.dart';
import 'package:mobile_warehouse/presentation/stock_count/bloc/stock_count_state.dart';

class StockCountScreen extends StatefulWidget {
  const StockCountScreen({Key? key}) : super(key: key);

  static const String routeName = '/pickTickets';
  static const String screenName = 'pickTicketsScreen';

  static ModalRoute<StockCountScreen> route() => MaterialPageRoute<StockCountScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => StockCountScreen(),
      );

  @override
  _StockCountScreen createState() => _StockCountScreen();
}

class _StockCountScreen extends State<StockCountScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('sdfsdf');
    context.read<StockCountBloc>().getStockCounts(value: '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockCountBloc, StockCountState>(
        listener: (BuildContext context, StockCountState state) {},
        builder: (BuildContext context, StockCountState state) {
          return SafeArea(
              child: Scaffold(
            appBar: ATAppBar(
              title: 'Stock Count',
              icon: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            body: Container(
              color: AppColors.beachSea,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: ATSearchfield(
                      textEditingController: searchController,
                      hintText: I18n.of(context).search,
                      onPressed: () {
                        if (searchController.text.isNotEmpty == true) {
                          setState(() {
                            context.read<StockCountBloc>().searchStock(value: searchController.text);
                          });
                        }
                      },
                      onChanged: (String value) {
                        EasyDebounce.debounce('deebouncer1', Duration(milliseconds: 700), () {
                          setState(() {
                            context.read<StockCountBloc>().searchStock(value: searchController.text);
                          });
                        });
                      }),
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
                        : ListView.builder(
                                itemCount: (state.stockCountItemList?.length ?? 0),
                                itemBuilder: (BuildContext context, int index) {
                                  return Ink(
                                    child: InkWell(
                                      onTap: (){

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
                                                ATText(text: state.stockCountItemList?[index].sku, fontSize: 16, weight: FontWeight.bold,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    ATText(text: '${index + 1} items', fontSize: 16, weight: FontWeight.bold,),
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
                                            Divider(height: 1, color: AppColors.black,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                    ))]),
            ),
          ));
        });
  }
}
