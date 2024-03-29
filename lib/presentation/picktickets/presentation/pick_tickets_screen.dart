import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/login/presentation/login_screen.dart';
import 'package:mobile_warehouse/presentation/picktickets/bloc/pick_tickets_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets/bloc/pick_tickets_state.dart';
import 'package:mobile_warehouse/presentation/picktickets/presentation/widgets/pick_tickets_status.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/presentation/pick_ticket_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PickTicketsScreen extends StatefulWidget {
  const PickTicketsScreen({Key? key}) : super(key: key);

  static const String routeName = '/pickTickets';
  static const String screenName = 'pickTicketsScreen';

  static ModalRoute<PickTicketsScreen> route() =>
      MaterialPageRoute<PickTicketsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const PickTicketsScreen(),
      );

  @override
  _PickTicketsScreen createState() => _PickTicketsScreen();
}

class _PickTicketsScreen extends State<PickTicketsScreen> {
  final RefreshController refreshController = RefreshController();
  final TextEditingController searchController = TextEditingController();

  late Timer rotatingTimer;
  int turns = 0;
  bool canRefresh = true;
  bool isTicketNumberSort = false;
  bool isDestinationSort = false;
  bool isNumLineSort = false;
  bool isStatusSort = false;

  @override
  void initState() {
    super.initState();
    context.read<PickTicketsBloc>().getPickTickets(isScreenLoading: true);
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
    return BlocConsumer<PickTicketsBloc, PickTicketsState>(
        listener: (BuildContext context, PickTicketsState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
      }

      if (state.hasError) {
        Navigator.of(context).popUntil(ModalRoute.withName('/login'));
      }
    }, builder: (BuildContext context, PickTicketsState state) {
      return SafeArea(
          child: Scaffold(
              appBar: ATAppBar(
                title: I18n.of(context).pick_tickets.capitalizeFirstofEach(),
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
                color: AppColors.beachSea,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: ATSearchfield(
                          textEditingController: searchController,
                          hintText: I18n.of(context).search,
                          onPressed: () {
                            if (searchController.text.isNotEmpty == true) {
                              setState(() {
                                context
                                    .read<PickTicketsBloc>()
                                    .searchTicket(value: searchController.text);
                              });
                            }
                          },
                          onChanged: (String value) {
                            EasyDebounce.debounce(
                                'deebouncer1', Duration(milliseconds: 700), () {
                              setState(() {
                                context
                                    .read<PickTicketsBloc>()
                                    .searchTicket(value: searchController.text);
                              });
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
                                    visible: state
                                            .pickTicketsItemModel?.isNotEmpty ==
                                        true,
                                    child: Table(
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        columnWidths: const <int,
                                            TableColumnWidth>{
                                          0: FixedColumnWidth(38),
                                          1: FixedColumnWidth(70),
                                          2: FlexColumnWidth(),
                                          3: FixedColumnWidth(70),
                                        },
                                        children: <TableRow>[
                                          TableRow(children: <Widget>[
                                            Ink(
                                                child: InkWell(
                                              onTap: () {
                                                context
                                                    .read<PickTicketsBloc>()
                                                    .sortPickTicket(
                                                        pickTicket: state
                                                            .pickTicketsItemModel,
                                                        column: 'status',
                                                        sortBy: isStatusSort);
                                                setState(() {
                                                  isStatusSort = !isStatusSort;
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18,
                                                    top: 20,
                                                    bottom: 5),
                                                child: SizedBox(),
                                              ),
                                            )),
                                            Ink(
                                              child: InkWell(
                                                onTap: () {
                                                  context
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
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 5),
                                                  child: ATText(
                                                    fontColor:
                                                        AppColors.greyHeader,
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
                                                  context
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
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 5),
                                                  child: ATText(
                                                    fontColor:
                                                        AppColors.greyHeader,
                                                    text: I18n.of(context)
                                                        .location
                                                        .toUpperCase(),
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Ink(
                                              child: InkWell(
                                                onTap: () {
                                                  context
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
                                                  });
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 18,
                                                          top: 20,
                                                          bottom: 5),
                                                  child: ATText(
                                                    fontColor:
                                                        AppColors.greyHeader,
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
                    Visibility(
                        visible: state.pickTicketsItemModel?.isEmpty == true,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          color: AppColors.white,
                          padding: const EdgeInsets.only(top: 30),
                          child: ATText(
                              text: I18n.of(context)
                                  .oops_item_returned_0_results),
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
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: ATText(
                                                text: I18n.of(context)
                                                    .please_wait_while_data_is_loaded),
                                          ))
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount:
                                        (state.pickTicketsItemModel?.length ??
                                                0) +
                                            1,
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
                                                  onPressed: (BuildContext
                                                      navContext) {
                                                    Navigator.of(navContext)
                                                        .push(PickTicketDetailsScreen
                                                            .route(
                                                                ticketItemModel:
                                                                    state.pickTicketsItemModel?[
                                                                        index]))
                                                        .then((dynamic value) {
                                                      context
                                                          .read<
                                                              PickTicketsBloc>()
                                                          .getPickTickets(
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
                                              1: FixedColumnWidth(70),
                                              2: FlexColumnWidth(),
                                              3: FixedColumnWidth(70),
                                            },
                                            children: <TableRow>[
                                              TableRow(
                                                  decoration: BoxDecoration(
                                                      color: (index % 2) == 0
                                                          ? AppColors.white
                                                          : AppColors
                                                              .lightBlue),
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 18,
                                                              top: 20,
                                                              bottom: 20),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child:
                                                            PickTicketsStatusWidget(
                                                          status: state
                                                              .pickTicketsItemModel?[
                                                                  index]
                                                              .status,
                                                          turns: turns,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: ATText(
                                                        text: state
                                                                .pickTicketsItemModel?[
                                                                    index]
                                                                .num ??
                                                            '',
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: ATText(
                                                        text: state
                                                                .pickTicketsItemModel?[
                                                                    index]
                                                                .destination ??
                                                            '',
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 18),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ATText(
                                                          text: state
                                                                  .pickTicketsItemModel?[
                                                                      index]
                                                                  .numLines ??
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
                                                          : AppColors
                                                              .lightBlue),
                                                  children: <Widget>[
                                                    SizedBox(),
                                                    SizedBox(),
                                                    state.pickTicketsItemModel?[index]
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
                                                                  'processing by ${state.pickTicketsItemModel?[index].fullName}',
                                                              fontSize: 13,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(),
                                                  ]),
                                            ],
                                          ));
                                    })),
                      )),
                    )
                  ],
                ),
              )));
    });
  }

  @override
  void dispose() {
    super.dispose();
    rotatingTimer.cancel();
  }

  void _forcedRefresh() {
    canRefresh = true;
    context.read<PickTicketsBloc>().getPickTickets();
  }
}
