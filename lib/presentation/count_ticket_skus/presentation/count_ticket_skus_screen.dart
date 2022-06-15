import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_details_model.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/bloc/count_ticket_skus_bloc.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/bloc/count_ticket_skus_state.dart';

class CountTicketSkusScreen extends StatefulWidget {
  const CountTicketSkusScreen({Key? key, this.countTicketDetails})
      : super(key: key);

  static const String routeName = '/countTicketsSkus';
  static const String screenName = 'countTicketsSkusScreen';

  final CountTicketDetailsModel? countTicketDetails;

  static ModalRoute<CountTicketSkusScreen> route(
          {CountTicketDetailsModel? countTicketDetails}) =>
      MaterialPageRoute<CountTicketSkusScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) =>
            CountTicketSkusScreen(countTicketDetails: countTicketDetails),
      );

  @override
  _CountTicketSkusScreen createState() => _CountTicketSkusScreen();
}

class _CountTicketSkusScreen extends State<CountTicketSkusScreen> {
  final TextEditingController skuController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final FocusNode skuNode = FocusNode();
  final FocusNode countNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountTicketSkusBloc, CountTicketSkusState>(
        listener: (BuildContext context, CountTicketSkusState state) {},
        builder: (BuildContext context, CountTicketSkusState state) {
          return SafeArea(
              child: Scaffold(
            appBar: ATAppBar(
              title: 'Counting ${widget.countTicketDetails?.containerCode}',
              icon: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
              onTap: () => Navigator.of(context).pop(),
              actions: <Widget>[
                state.isLoading
                    ? Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 18),
                        width: 30,
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
                            textEditingController: skuController,
                            focusNode: skuNode,
                            hintText: I18n.of(context).search,
                            onPressed: () {
                              /*if (searchController.text.isNotEmpty == true) {
                                setState(() {
                                  context
                                      .read<PickTicketsBloc>()
                                      .searchTicket(value: searchController.text);
                                });
                              }*/
                            },
                            onChanged: (String value) {
                              EasyDebounce.debounce(
                                  'deebouncer1', Duration(milliseconds: 700),
                                  () {
                                /*setState(() {
                                  context
                                      .read<PickTicketsBloc>()
                                      .searchTicket(value: searchController.text);
                                });*/
                              });
                            }),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            child: ATSearchfield(
                                textEditingController: countController,
                                focusNode: countNode,
                                hintText: I18n.of(context).search,
                                onPressed: () {
                                  /*if (searchController.text.isNotEmpty == true) {
                                setState(() {
                                  context
                                      .read<PickTicketsBloc>()
                                      .searchTicket(value: searchController.text);
                                });
                              }*/
                                },
                                onChanged: (String value) {
                                  EasyDebounce.debounce('deebouncer1',
                                      Duration(milliseconds: 700), () {
                                    /*setState(() {
                                  context
                                      .read<PickTicketsBloc>()
                                      .searchTicket(value: searchController.text);
                                });*/
                                  });
                                }),
                          )),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ATText(
                                    text: 'On Hand: ',
                                    fontSize: 16,
                                    fontColor: AppColors.white),
                                ATText(
                                    text: '100',
                                    fontSize: 16,
                                    fontColor: AppColors.white),
                              ],
                            ),
                          )
                        ],
                      )
                    ])),
          ));
        });
  }
}
