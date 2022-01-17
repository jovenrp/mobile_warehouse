import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/presentation/widgets/ticket_detail_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PickTicketDetailsScreen extends StatefulWidget {
  const PickTicketDetailsScreen({Key? key, this.ticketItemModel})
      : super(key: key);

  final PickTicketsItemModel? ticketItemModel;

  static const String routeName = '/pickTicketDetails';
  static const String screenName = 'pickTicketDetailsScreen';

  static ModalRoute<PickTicketDetailsScreen> route(
          {PickTicketsItemModel? ticketItemModel}) =>
      MaterialPageRoute<PickTicketDetailsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) =>
            PickTicketDetailsScreen(ticketItemModel: ticketItemModel),
      );

  @override
  _PickTicketDetailsScreen createState() => _PickTicketDetailsScreen();
}

class _PickTicketDetailsScreen extends State<PickTicketDetailsScreen> {
  final RefreshController refreshController = RefreshController();
  bool canRefresh = true;

  @override
  void initState() {
    super.initState();
    context
        .read<PickTicketDetailsBloc>()
        .getPickTicketDetails(pickTicketId: widget.ticketItemModel?.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickTicketDetailsBloc, PickTicketDetailsState>(
        listener: (BuildContext context, PickTicketDetailsState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
      }
    }, builder: (BuildContext context, PickTicketDetailsState state) {
      return SafeArea(
          child: Scaffold(
              appBar: ATAppBar(
                title: I18n.of(context)
                    .ticket_ticket_id(widget.ticketItemModel?.num)
                    .capitalizeFirstofEach(),
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: AppColors.white,
                  size: 24.0,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              body: Container(
                  color: AppColors.beachSea,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ATSearchfield(
                              hintText: 'Search', onPressed: () {}),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                            child: Container(
                                color: AppColors.white,
                                child: SmartRefresher(
                                    enablePullDown: canRefresh,
                                    onRefresh: () => _forcedRefresh(
                                        pickTicketId:
                                            widget.ticketItemModel?.id),
                                    controller: refreshController,
                                    child: state.isLoading
                                        ? Container(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: ATText(
                                                  text:
                                                      'Please wait a moment while data is being loaded...'),
                                            ))
                                        : ListView.builder(
                                            itemCount: state
                                                .pickTicketsDetailsResponse
                                                ?.pickTicketsResponse
                                                ?.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (index == 0) {
                                                return Padding(padding: const EdgeInsets.only(top: 15, bottom: 10), child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: SizedBox()),
                                                    Expanded(
                                                        flex: 2,
                                                        child: ATText(
                                                          text: 'Location',
                                                          weight:
                                                          FontWeight.w700,
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: ATText(
                                                          text: 'SKU',
                                                          weight:
                                                          FontWeight.w700,
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: ATText(
                                                            text: 'Quantity',
                                                            weight:
                                                            FontWeight.w700,
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: SizedBox()),
                                                  ],
                                                ),);
                                              }
                                              index -= 1;
                                              return Container(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                color: (index % 2) == 0
                                                    ? AppColors.white
                                                    : AppColors.lightBlue,
                                                child:
                                                    Column(children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: Checkbox(
                                                              value: state
                                                                  .pickTicketsDetailsResponse
                                                                  ?.pickTicketsResponse?[
                                                                      index]
                                                                  .isChecked,
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  print(value);
                                                                  state
                                                                      .pickTicketsDetailsResponse
                                                                      ?.pickTicketsResponse?[
                                                                  index]
                                                                      .setIsChecked(
                                                                      value ??
                                                                          false);
                                                                });
                                                              }),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: ATText(
                                                          text: state
                                                              .pickTicketsDetailsResponse
                                                              ?.pickTicketsResponse?[
                                                                  index]
                                                              .itemId,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: ATText(
                                                          text: state
                                                              .pickTicketsDetailsResponse
                                                              ?.pickTicketsResponse?[
                                                                  index]
                                                              .sku,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: ATText(
                                                            text: '${state
                                                                .pickTicketsDetailsResponse
                                                                ?.pickTicketsResponse?[
                                                            index]
                                                                .qtyPicked} of ${state
                                                                .pickTicketsDetailsResponse
                                                                ?.pickTicketsResponse?[
                                                            index]
                                                                .qtyPick}',
                                                            weight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(
                                                            Icons
                                                                .double_arrow_sharp,
                                                            size: 18,
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(),
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: ATText(
                                                          text: state
                                                              .pickTicketsDetailsResponse
                                                              ?.pickTicketsResponse?[
                                                                  index]
                                                              .description,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: ATText(
                                                            text:
                                                                '${state.pickTicketsDetailsResponse?.pickTicketsResponse?[index].uom} ${state.pickTicketsDetailsResponse?.pickTicketsResponse?[index].unitQty}',
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5)
                                                ]),
                                              );
                                            }))))
                      ]))));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _forcedRefresh({String? pickTicketId}) {
    canRefresh = true;
    context
        .read<PickTicketDetailsBloc>()
        .getPickTicketDetails(pickTicketId: pickTicketId);
  }
}
