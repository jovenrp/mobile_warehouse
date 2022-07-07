import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/count_ticket_details/data/models/count_ticket_detail_summary_model.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/bloc/count_ticket_skus_bloc.dart';
import 'package:mobile_warehouse/presentation/count_ticket_skus/bloc/count_ticket_skus_state.dart';
import 'package:mobile_warehouse/presentation/qr/presentation/qr_screen.dart';

class CountTicketSkusScreen extends StatefulWidget {
  const CountTicketSkusScreen({Key? key, this.countTicketDetailSummaryModel})
      : super(key: key);

  static const String routeName = '/countTicketsSkus';
  static const String screenName = 'countTicketsSkusScreen';

  final CountTicketDetailSummaryModel? countTicketDetailSummaryModel;

  static ModalRoute<CountTicketSkusScreen> route(
          {CountTicketDetailSummaryModel? countTicketDetailSummaryModel}) =>
      MaterialPageRoute<CountTicketSkusScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => CountTicketSkusScreen(
            countTicketDetailSummaryModel: countTicketDetailSummaryModel),
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
  void initState() {
    super.initState();
    context
        .read<CountTicketSkusBloc>()
        .beginCount(id: widget.countTicketDetailSummaryModel?.id)
        .then((_) {
      context.read<CountTicketSkusBloc>().getCountTicketDetailSkus(
          id: widget.countTicketDetailSummaryModel?.containerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountTicketSkusBloc, CountTicketSkusState>(
        listener: (BuildContext context, CountTicketSkusState state) {},
        builder: (BuildContext context, CountTicketSkusState state) {
          return SafeArea(
              child: Scaffold(
            appBar: ATAppBar(
              title: I18n.of(context).counting_location_number(
                  widget.countTicketDetailSummaryModel?.containerId),
              icon: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
              onTap: () {
                context
                    .read<CountTicketSkusBloc>()
                    .exitCount(id: widget.countTicketDetailSummaryModel?.id)
                    .then((_) => Navigator.of(context).pop());
              },
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
                            isScanner: true,
                            hintText: I18n.of(context).search,
                            onPressed: () {
                              Future<void>.delayed(Duration.zero, () async {
                                await Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return QRScreen(scanner: 'serial');
                                }));
                                /*ParentLocationModel parentLocationModel =
                                await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return QRScreen(container: widget.container, scanner: 'serial');
                            }));
                            SnackBar snackBar = SnackBar(
                              content: ATText(
                                text: parentLocationModel.message,
                                fontColor: AppColors.white,
                              ),
                              duration: Duration(seconds: 2),
                            );

                            if (parentLocationModel.error == false) {
                              setState(() {
                                isReadOnly = true;
                                serialController.text = parentLocationModel.container?.first.num ?? '';
                              });
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }*/
                              });
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
                                    text: '${I18n.of(context).on_hand} ',
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
