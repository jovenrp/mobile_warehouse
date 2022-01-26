import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
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
  bool canRefresh = true;

  @override
  void initState() {
    super.initState();
    context.read<PickTicketsBloc>().getPickTickets(isScreenLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickTicketsBloc, PickTicketsState>(
        listener: (BuildContext context, PickTicketsState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
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
                          hintText: I18n.of(context).search, onPressed: () {}),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        color: AppColors.white,
                        child: SmartRefresher(
                            enablePullDown: canRefresh,
                            onRefresh: _forcedRefresh,
                            controller: refreshController,
                            child: state.isLoading
                                ? Container(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: ATText(
                                          text:
                                              'Please wait a moment while data is being loaded...'),
                                    ))
                                : ListView.builder(
                                    itemCount: state
                                        .pickTicketsModel?.pickTickets?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 10),
                                          child: Table(
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: const <int,
                                                TableColumnWidth>{
                                              0: FixedColumnWidth(38),
                                              1: FixedColumnWidth(70),
                                              2: FlexColumnWidth(),
                                              3: FixedColumnWidth(70),
                                            },
                                            children: <TableRow>[
                                              TableRow(children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: SizedBox(),
                                                ),
                                                Container(
                                                  child: ATText(
                                                      text: I18n.of(context)
                                                          .ticket_number
                                                          .toUpperCase()),
                                                ),
                                                Container(
                                                  child: ATText(
                                                    text: I18n.of(context)
                                                        .location
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerRight,
                                                  padding: const EdgeInsets.only(right: 18),
                                                  child: ATText(
                                                      text: I18n.of(context)
                                                          .lines
                                                          .toUpperCase()),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        );
                                      }
                                      index -= 1;
                                      return Slidable(
                                        key: ValueKey<int>(index),
                                        startActionPane: ActionPane(
                                        // A motion is a widget used to control how the pane animates.
                                        motion: const ScrollMotion(),
                                        children: <Widget>[
                                          SlidableAction(
                                            onPressed: (BuildContext context){},
                                            backgroundColor: Color(0xFFFE4A49),
                                            foregroundColor: Colors.white,
                                            icon: Icons.assignment_ind_outlined,
                                          ),
                                          SlidableAction(
                                            onPressed: (BuildContext context){
                                              Navigator.of(context).push(
                                                  PickTicketDetailsScreen.route(
                                                      ticketItemModel: state
                                                          .pickTicketsModel
                                                          ?.pickTickets?[
                                                      index]));
                                            },
                                            backgroundColor: Color(0xFF21B7CA),
                                            foregroundColor: Colors.white,
                                            icon: Icons.list_alt,
                                            label: 'Ticket List',
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
                                          3: FixedColumnWidth(70),
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
                                                          top: 15,
                                                          bottom: 15),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        PickTicketsStatusWidget(
                                                            status: state
                                                                .pickTicketsModel
                                                                ?.pickTickets?[
                                                                    index]
                                                                .status),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(state
                                                          .pickTicketsModel
                                                          ?.pickTickets?[index]
                                                          .num ??
                                                      ''),
                                                ),
                                                Container(
                                                  child: Text(state
                                                          .pickTicketsModel
                                                          ?.pickTickets?[index]
                                                          .location ??
                                                      ''),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 18) ,
                                                  child: Container(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(state
                                                        .pickTicketsModel
                                                        ?.pickTickets?[index]
                                                        .lines ??
                                                        ''),
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ));
                                    })),
                      ),
                    )
                  ],
                ),
              )));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _forcedRefresh() {
    canRefresh = true;
    context.read<PickTicketsBloc>().getPickTickets();
  }
}
