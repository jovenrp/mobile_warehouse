import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/picktickets/presentation/widgets/pick_tickets_status.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/presentation/receive_ticket_details_screen.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/bloc/receive_tickets_bloc.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/bloc/receive_tickets_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mobile_warehouse/generated/i18n.dart';

class ReceiveTicketsScreen extends StatefulWidget {
  const ReceiveTicketsScreen({Key? key}) : super(key: key);

  static const String routeName = '/receiveTickets';
  static const String screenName = 'receiveTicketsScreen';

  static ModalRoute<ReceiveTicketsScreen> route() =>
      MaterialPageRoute<ReceiveTicketsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ReceiveTicketsScreen(),
      );

  @override
  _ReceiveTicketsScreen createState() => _ReceiveTicketsScreen();
}

class _ReceiveTicketsScreen extends State<ReceiveTicketsScreen> {
  final RefreshController refreshController = RefreshController();
  final TextEditingController searchController = TextEditingController();

  bool canRefresh = true;
  int turns = 0;
  late Timer rotatingTimer;

  @override
  void initState() {
    super.initState();
    context.read<ReceiveTicketsBloc>().getReceiveTickets();
    rotatingTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        turns++;
        if (turns == 4) {
          turns = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiveTicketsBloc, ReceiveTicketsState>(
        listener: (BuildContext context, ReceiveTicketsState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
      }

      if (state.hasError) {
        Navigator.of(context).popUntil(ModalRoute.withName('/login'));
      }
    }, builder: (BuildContext context, ReceiveTicketsState state) {
      return SafeArea(
          child: Scaffold(
              appBar: ATAppBar(
                title: 'Purchase Orders',
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
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, right: 18),
                          width: 35,
                          child: ATLoadingIndicator(
                            strokeWidth: 3.0,
                            width: 15,
                            height: 10,
                          ),
                        )
                      : Ink(
                          child: InkWell(
                            onTap: () => Navigator.of(context)
                                .popUntil(ModalRoute.withName('/dashboard')),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: Icon(
                                Icons.home,
                                color: AppColors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                ],
              ),
              body: Container(
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: AppColors.beachSea,
                      padding: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 20),
                      child: ATSearchfield(
                          textEditingController: searchController,
                          hintText: I18n.of(context).search,
                          onFieldSubmitted: (String? value) {
                            if (searchController.text.isNotEmpty == true) {
                              setState(() {
                                context
                                    .read<ReceiveTicketsBloc>()
                                    .searchTicket(value: searchController.text);
                              });
                            }
                          },
                          onPressed: () {
                            if (searchController.text.isNotEmpty == true) {
                              setState(() {
                                context
                                    .read<ReceiveTicketsBloc>()
                                    .searchTicket(value: searchController.text);
                              });
                            }
                          },
                          onChanged: (String value) {
                            EasyDebounce.debounce(
                                'deebouncer1', Duration(milliseconds: 700), () {
                              setState(() {
                                context
                                    .read<ReceiveTicketsBloc>()
                                    .searchTicket(value: searchController.text);
                              });
                            });
                          }),
                    ),
                    Visibility(
                      visible: !state.isLoading,
                      child: Container(
                          color: AppColors.greyRow,
                          padding: const EdgeInsets.only(top: 0, bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                  visible:
                                      state.receiveTicketsModel?.isNotEmpty ==
                                          true,
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const <int,
                                          TableColumnWidth>{
                                        0: FixedColumnWidth(38),
                                        1: FixedColumnWidth(90),
                                        2: FlexColumnWidth(),
                                        3: FixedColumnWidth(70),
                                      },
                                      children: <TableRow>[
                                        TableRow(children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18, top: 20, bottom: 5),
                                            child: SizedBox(),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 5),
                                            child: ATText(
                                              fontColor: AppColors.greyHeader,
                                              text: 'PO#',
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 5),
                                            child: ATText(
                                              fontColor: AppColors.greyHeader,
                                              text: 'VENDOR',
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                                right: 18, top: 20, bottom: 5),
                                            child: ATText(
                                              fontColor: AppColors.greyHeader,
                                              text: I18n.of(context)
                                                  .lines
                                                  .toUpperCase(),
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        ])
                                      ])),
                            ],
                          )),
                    ),
                    Expanded(
                        child: !state.isLoading
                            ? state.receiveTicketsModel?.isNotEmpty == true
                                ? SmartRefresher(
                                    enablePullDown: canRefresh,
                                    onRefresh: _forcedRefresh,
                                    controller: refreshController,
                                    header: WaterDropMaterialHeader(
                                      backgroundColor: AppColors.beachSea,
                                    ),
                                    child: ListView.builder(
                                        itemCount:
                                            state.receiveTicketsModel?.length ??
                                                0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Slidable(
                                              key: ValueKey<int>(index),
                                              startActionPane: ActionPane(
                                                  // A motion is a widget used to control how the pane animates.
                                                  // A motion is a widget used to control how the pane animates.
                                                  motion: const ScrollMotion(),
                                                  children: <Widget>[
                                                    SlidableAction(
                                                      onPressed: (BuildContext
                                                          navContext) {
                                                        Navigator.of(navContext)
                                                            .push(ReceiveTicketDetailsScreen.route(
                                                                receiveTicketsModel:
                                                                    state.receiveTicketsModel?[
                                                                        index]))
                                                            .then((dynamic
                                                                value) {
                                                          context
                                                              .read<
                                                                  ReceiveTicketsBloc>()
                                                              .getReceiveTickets(
                                                                  isScreenLoading:
                                                                      true);
                                                        });
                                                      },
                                                      backgroundColor:
                                                          AppColors.greyRed,
                                                      foregroundColor:
                                                          AppColors.white,
                                                      icon: Icons.list_alt,
                                                    ),
                                                  ]),
                                              child: Table(
                                                defaultVerticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                columnWidths: const <int,
                                                    TableColumnWidth>{
                                                  0: FixedColumnWidth(40),
                                                  1: FixedColumnWidth(90),
                                                  2: FlexColumnWidth(),
                                                  3: FixedColumnWidth(70),
                                                },
                                                children: <TableRow>[
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: (index % 2) ==
                                                                  0
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .lightBlue),
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 18,
                                                                  top: 20,
                                                                  bottom: 20),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child:
                                                                PickTicketsStatusWidget(
                                                              status: state
                                                                  .receiveTicketsModel?[
                                                                      index]
                                                                  .status,
                                                              isPartial: state
                                                                  .receiveTicketsModel?[
                                                                      index]
                                                                  .isPartial,
                                                              turns: turns,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: ATText(
                                                            text: state
                                                                .receiveTicketsModel?[
                                                                    index]
                                                                .num,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: ATText(
                                                            text: state
                                                                .receiveTicketsModel?[
                                                                    index]
                                                                .vendorName,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 18),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: ATText(
                                                              text: state
                                                                  .receiveTicketsModel?[
                                                                      index]
                                                                  .numLines,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: (index % 2) ==
                                                                  0
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .lightBlue),
                                                      children: <Widget>[
                                                        SizedBox(),
                                                        SizedBox(),
                                                        state.receiveTicketsModel?[index]
                                                                    .status
                                                                    ?.toLowerCase() ==
                                                                'processing'
                                                            ? Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            15),
                                                                child: ATText(
                                                                  text:
                                                                      'processing by ${state.receiveTicketsModel?[index].fullName}',
                                                                  fontSize: 13,
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                        SizedBox(),
                                                      ]),
                                                ],
                                              ));
                                        }))
                                : Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    color: AppColors.white,
                                    padding: const EdgeInsets.only(top: 30),
                                    child: ATText(
                                        text: I18n.of(context)
                                            .oops_item_returned_0_results),
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ATText(
                                              text: I18n.of(context)
                                                  .please_wait_while_data_is_loaded),
                                        ))
                                  ],
                                )))
                  ],
                ),
              )));
    });
  }

  void _forcedRefresh() {
    canRefresh = true;
    context.read<ReceiveTicketsBloc>().getReceiveTickets();
  }

  @override
  void dispose() {
    super.dispose();
    rotatingTimer.cancel();
  }
}
