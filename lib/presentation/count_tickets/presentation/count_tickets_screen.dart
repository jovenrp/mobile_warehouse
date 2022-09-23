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
import 'package:mobile_warehouse/presentation/count_ticket_details/presentation/count_ticket_details_screen.dart';
import 'package:mobile_warehouse/presentation/count_tickets/bloc/count_tickets_bloc.dart';
import 'package:mobile_warehouse/presentation/count_tickets/bloc/count_tickets_state.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/picktickets/presentation/widgets/pick_tickets_status.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CountTicketsScreen extends StatefulWidget {
  const CountTicketsScreen({Key? key}) : super(key: key);

  static const String routeName = '/countTickets';
  static const String screenName = 'countTicketsScreen';

  static ModalRoute<CountTicketsScreen> route() =>
      MaterialPageRoute<CountTicketsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CountTicketsScreen(),
      );

  @override
  _CountTicketsScreen createState() => _CountTicketsScreen();
}

class _CountTicketsScreen extends State<CountTicketsScreen> {
  final RefreshController refreshController = RefreshController();
  final TextEditingController searchController = TextEditingController();

  bool canRefresh = true;
  late Timer rotatingTimer;
  int turns = 0;

  @override
  void initState() {
    super.initState();
    context.read<CountTicketsBloc>().getCountTickets();
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
    return BlocConsumer<CountTicketsBloc, CountTicketsState>(
        listener: (BuildContext context, CountTicketsState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
      }

      if (state.hasError) {
        Navigator.of(context).popUntil(
            ModalRoute.withName(
                '/login'));
      }
    }, builder: (BuildContext context, CountTicketsState state) {
      return SafeArea(
          child: Scaffold(
        appBar: ATAppBar(
          title: 'Count Tickets',
          icon: Icon(
            Icons.arrow_back_sharp,
            color: AppColors.white,
            size: 24.0,
          ),
          onTap: () => Navigator.of(context).pop(),
          actions: <Widget>[
            state.isLoading
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 20, right: 18),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: ATSearchfield(
                    textEditingController: searchController,
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
                          'deebouncer1', Duration(milliseconds: 700), () {
                        /*setState(() {
                                  context
                                      .read<PickTicketsBloc>()
                                      .searchTicket(value: searchController.text);
                                });*/
                      });
                    }),
              ),
              SizedBox(height: 20),
              state.isLoading
                  ? SizedBox()
                  : Container(
                      color: AppColors.greyRow,
                      padding: const EdgeInsets.only(top: 0, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Visibility(
                              visible: state.countTickets?.isNotEmpty == true,
                              child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FixedColumnWidth(38),
                                    1: FixedColumnWidth(70),
                                    2: FlexColumnWidth(),
                                    3: FlexColumnWidth(),
                                    4: FixedColumnWidth(70),
                                  },
                                  children: <TableRow>[
                                    TableRow(children: <Widget>[
                                      Ink(
                                          child: InkWell(
                                        onTap: () {
                                          /*context
                                                      .read<PickTicketsBloc>()
                                                      .sortPickTicket(
                                                      pickTicket: state
                                                          .pickTicketsItemModel,
                                                      column: 'status',
                                                      sortBy: isStatusSort);
                                                  setState(() {
                                                    isStatusSort = !isStatusSort;
                                                  });*/
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18, top: 20, bottom: 5),
                                          child: SizedBox(),
                                        ),
                                      )),
                                      Ink(
                                        child: InkWell(
                                          onTap: () {
                                            /*context
                                                    .read<PickTicketsBloc>()
                                                    .sortPickTicket(
                                                    pickTicket: state
                                                        .pickTicketsItemModel,
                                                    column:
                                                    'ticketNumber',
                                                    sortBy:
                                                    isTicketNumberSort);
                                                setState(() {
                                                  isTicketNumberSort =
                                                  !isTicketNumberSort;
                                                });*/
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 5),
                                            child: ATText(
                                              fontColor: AppColors.greyHeader,
                                              text: I18n.of(context)
                                                  .ticket_number
                                                  .toUpperCase(),
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Ink(
                                        child: InkWell(
                                          onTap: () {
                                            /*context
                                                    .read<PickTicketsBloc>()
                                                    .sortPickTicket(
                                                    pickTicket: state
                                                        .pickTicketsItemModel,
                                                    column: 'destination',
                                                    sortBy:
                                                    isDestinationSort);
                                                setState(() {
                                                  isDestinationSort =
                                                  !isDestinationSort;
                                                });*/
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 5),
                                            child: ATText(
                                              fontColor: AppColors.greyHeader,
                                              text: 'Name'.toUpperCase(),
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Ink(
                                        child: InkWell(
                                          onTap: () {
                                            /*context
                                                    .read<PickTicketsBloc>()
                                                    .sortPickTicket(
                                                    pickTicket: state
                                                        .pickTicketsItemModel,
                                                    column: 'destination',
                                                    sortBy:
                                                    isDestinationSort);
                                                setState(() {
                                                  isDestinationSort =
                                                  !isDestinationSort;
                                                });*/
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 5),
                                            child: ATText(
                                              fontColor: AppColors.greyHeader,
                                              text: 'Type'.toUpperCase(),
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Ink(
                                        child: InkWell(
                                          onTap: () {
                                            /*context
                                                    .read<PickTicketsBloc>()
                                                    .sortPickTicket(
                                                    pickTicket: state
                                                        .pickTicketsItemModel,
                                                    column: 'numLines',
                                                    sortBy:
                                                    isNumLineSort);
                                                setState(() {
                                                  isNumLineSort =
                                                  !isNumLineSort;
                                                });*/
                                          },
                                          child: Container(
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
                                        ),
                                      )
                                    ])
                                  ])),
                        ],
                      )),
              Expanded(
                child: InteractiveViewer(
                    child: Container(
                  color: AppColors.white,
                  child: SmartRefresher(
                      enablePullDown: canRefresh,
                      onRefresh: _forcedRefresh,
                      controller: refreshController,
                      header: WaterDropMaterialHeader(
                        backgroundColor: AppColors.beachSea,
                      ),
                      child: state.isLoading
                          ? Column(
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
                                      child: ATText(
                                          text: I18n.of(context)
                                              .please_wait_while_data_is_loaded),
                                    ))
                              ],
                            )
                          : state.countTickets?.isNotEmpty == true
                              ? ListView.builder(
                                  itemCount:
                                      (state.countTickets?.length ?? 0) + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == 0) {
                                      return SizedBox();
                                    }
                                    index -= 1;
                                    return Slidable(
                                        key: ValueKey<int>(index),
                                        startActionPane: ActionPane(
                                            // A motion is a widget used to control how the pane animates.
                                            // A motion is a widget used to control how the pane animates.
                                            motion: const ScrollMotion(),
                                            children: <Widget>[
                                              SlidableAction(
                                                onPressed:
                                                    (BuildContext navContext) {
                                                  Navigator.of(navContext).push(
                                                      CountTicketDetailsScreen
                                                          .route(
                                                              countTicketsModel:
                                                                  state.countTickets?[
                                                                      index]));
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
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: const <int,
                                              TableColumnWidth>{
                                            0: FixedColumnWidth(40),
                                            1: FixedColumnWidth(70),
                                            2: FlexColumnWidth(),
                                            3: FlexColumnWidth(),
                                            4: FixedColumnWidth(70),
                                          },
                                          children: <TableRow>[
                                            TableRow(
                                                decoration: BoxDecoration(
                                                    color: (index % 2) == 0
                                                        ? AppColors.white
                                                        : AppColors.lightBlue),
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 18,
                                                            top: 20,
                                                            bottom: 20),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          PickTicketsStatusWidget(
                                                        status: state
                                                            .countTickets?[
                                                                index]
                                                            .status,
                                                        turns: turns,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ATText(
                                                      text: state
                                                              .countTickets?[
                                                                  index]
                                                              .num ??
                                                          '',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ATText(
                                                      text: state
                                                              .countTickets?[
                                                                  index]
                                                              .comments ??
                                                          '',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ATText(
                                                      text: state
                                                              .countTickets?[
                                                                  index]
                                                              .type ??
                                                          '',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 18),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: ATText(
                                                        text: state
                                                                .countTickets?[
                                                                    index]
                                                                .num ??
                                                            '',
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                            TableRow(
                                                decoration: BoxDecoration(
                                                    color: (index % 2) == 0
                                                        ? AppColors.white
                                                        : AppColors.lightBlue),
                                                children: <Widget>[
                                                  SizedBox(),
                                                  SizedBox(),
                                                  state.countTickets?[index]
                                                              .status
                                                              ?.toLowerCase() ==
                                                          'processing'
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  bottom: 15),
                                                          child: ATText(
                                                            text:
                                                                'counting line ${state.countTickets?[index].num}',
                                                            fontSize: 13,
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                  SizedBox(),
                                                  SizedBox(),
                                                ]),
                                          ],
                                        ));
                                  })
                              : Container(
                                  alignment: Alignment.topCenter,
                                  width: double.infinity,
                                  color: AppColors.white,
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ATText(
                                      text: I18n.of(context)
                                          .oops_item_returned_0_results),
                                )),
                )),
              )
            ])),
      ));
    });
  }

  void _forcedRefresh() {
    canRefresh = true;
    context.read<CountTicketsBloc>().getCountTickets();
  }

  @override
  void dispose() {
    super.dispose();
    rotatingTimer.cancel();
  }
}
