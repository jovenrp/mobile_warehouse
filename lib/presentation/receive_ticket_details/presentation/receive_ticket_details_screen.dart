import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_mini_textfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/bloc/receive_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/bloc/receive_ticket_details_state.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_model.dart';
import 'package:mobile_warehouse/presentation/receive_tickets/data/models/receive_tickets_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

class ReceiveTicketDetailsScreen extends StatefulWidget {
  const ReceiveTicketDetailsScreen({Key? key, this.receiveTicketsModel})
      : super(key: key);

  static const String routeName = '/receiveTicketDetails';
  static const String screenName = 'receiveTicketDetailsScreen';

  final ReceiveTicketsModel? receiveTicketsModel;

  static ModalRoute<ReceiveTicketDetailsScreen> route(
          {ReceiveTicketsModel? receiveTicketsModel}) =>
      MaterialPageRoute<ReceiveTicketDetailsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ReceiveTicketDetailsScreen(
            receiveTicketsModel: receiveTicketsModel),
      );

  @override
  _ReceiveTicketDetailsScreen createState() => _ReceiveTicketDetailsScreen();
}

class _ReceiveTicketDetailsScreen extends State<ReceiveTicketDetailsScreen> {
  final RefreshController refreshController = RefreshController();
  List<TextEditingController> textFieldControllers = <TextEditingController>[];
  final TextEditingController searchController = TextEditingController();

  bool canRefresh = true;
  int currentIndex = -1;
  bool pickLimitSetting = false;
  bool isUndo = false;
  bool isInitialized = false;
  bool _isVisible = true;
  late SnackBar submitSnackbar;
  String completeStatus = '';

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    context
        .read<ReceiveTicketDetailsBloc>()
        .getReceiveTicketDetails(id: widget.receiveTicketsModel?.id);
  }

  @override
  Widget build(BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: ATText(
        text: I18n.of(context).quantity_not_greater_than_limit,
        fontColor: AppColors.white,
      ),
      duration: Duration(seconds: 1),
    );
    submitSnackbar = SnackBar(
      content: ATText(
        text: I18n.of(context).ticket_complete,
        fontColor: AppColors.white,
      ),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: I18n.of(context).undo,
        onPressed: () {
          isUndo = true;
        },
      ),
    );
    return BlocConsumer<ReceiveTicketDetailsBloc, ReceiveTicketDetailsState>(
        listener: (BuildContext context, ReceiveTicketDetailsState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
        pickLimitSetting = false;

        int index = 0;
        for (ReceiveTicketDetailsModel item
            in state.receiveTicketDetailsModel ??
                <ReceiveTicketDetailsModel>[]) {
          if (!isInitialized) {
            textFieldControllers.add(TextEditingController());
            //item.setLocation(state.pickTicketResponse?[0].destination);
            if (item.qtyReceived?.isEmpty == true) {
              item.setQtyPicked('0');
            }
            if (double.parse(item.qtyReceived?.isNotEmpty == true
                        ? item.qtyReceived ?? '0'
                        : '0') >
                    0 ||
                item.status?.toLowerCase() == 'partial') {
              item.setPickedItem(item.qtyReceived);
              item.setIsChecked(double.parse(item.qtyReceived ?? '0') > 0 ||
                  item.status?.toLowerCase() == 'partial');
            }
            if (index >=
                int.parse(
                    (state.receiveTicketDetailsModel!.length - 1).toString())) {
              isInitialized = true;
            }
            index++;
          }
        }

        if (!state.isLoading) {
          if (state.isOverPicked == true) {
            context.read<ReceiveTicketDetailsBloc>().resetStates();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 70,
                              color: AppColors.warningOrange,
                            ),
                            SizedBox(height: 10),
                            ATText(
                              text: I18n.of(context).do_you_want_to_continue,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold,
                            ),
                            SizedBox(height: 10),
                            ATText(
                              text: I18n.of(context).this_will_overpick_item,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              child: ATTextButton(
                                  isLoading: false,
                                  buttonText: I18n.of(context).yes_pick_line,
                                  onTap: () {
                                    context
                                        .read<ReceiveTicketDetailsBloc>()
                                        .submitPick(
                                            id: state.dummyPickTicketId ?? '',
                                            containerId: state
                                                    .dummyReceiveTicketDetailsModel
                                                    ?.containerId ??
                                                '0',
                                            qtyReceived:
                                                state.dummyQuantityPicked ??
                                                    '');
                                    Navigator.of(context).popUntil(
                                        ModalRoute.withName(
                                            '/receiveTicketDetails'));
                                  }),
                            ),
                            Container(
                              width: double.infinity,
                              child: ATTextButton(
                                buttonStyle: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side:
                                          BorderSide(color: AppColors.beachSea),
                                    ))),
                                buttonTextStyle:
                                    TextStyle(color: AppColors.beachSea),
                                isLoading: false,
                                buttonText: I18n.of(context).cancel,
                                onTap: () {
                                  currentIndex = -1;
                                  context
                                      .read<ReceiveTicketDetailsBloc>()
                                      .exitReceiveDetail(
                                          id: state
                                                  .dummyReceiveTicketDetailsModel
                                                  ?.id ??
                                              '');
                                  context
                                      .read<ReceiveTicketDetailsBloc>()
                                      .cancelPickRequest(
                                          state.dummyReceiveTicketDetailsModel,
                                          state.dummyQuantityPicked);
                                  Navigator.of(context).popUntil(
                                      ModalRoute.withName(
                                          '/receiveTicketDetails'));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        }

        if (!state.isUpdateLoading) {
          if (state.isCompleteTicket) {
            context.read<ReceiveTicketDetailsBloc>().resetStates();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SizedBox(
                      height: 290,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              child: completeStatus == 'partial'
                                  ? Icon(Icons.warning_amber_rounded,
                                      color: AppColors.warningOrange, size: 80)
                                  : Icon(Icons.check_circle,
                                      color: AppColors.successGreen, size: 80),
                            ),
                            SizedBox(height: 10),
                            ATText(
                              text: completeStatus == 'partial'
                                  ? I18n.of(context).partial_pick_completed
                                  : I18n.of(context).completed_alert,
                              fontSize: completeStatus == 'partial' ? 20 : 20,
                              weight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15),
                            ATText(
                              text: completeStatus == 'partial'
                                  ? I18n.of(context)
                                      .ticket_number_partially_complete(
                                          widget.receiveTicketsModel?.num)
                                  : I18n.of(context).ticket_number_complete(
                                      widget.receiveTicketsModel?.num),
                              fontSize: completeStatus == 'partial' ? 16 : 16,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              child: ATTextButton(
                                isLoading: false,
                                buttonText: I18n.of(context).done_button,
                                onTap: () => Navigator.of(context).popUntil(
                                    ModalRoute.withName(
                                        '/receiveTicketDetails')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        }
      }
    }, builder: (BuildContext context, ReceiveTicketDetailsState state) {
      return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              appBar: ATAppBar(
                  title: 'Receiving',
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.white,
                    size: 24.0,
                  ),
                  actions: <Widget>[
                    state.isLoading || state.isUpdateLoading
                        ? Container(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 18),
                            width: 35,
                            child: ATLoadingIndicator(
                              strokeWidth: 3.0,
                              width: 10,
                              height: 10,
                            ),
                          )
                        : SizedBox()
                  ]),
              body: Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: AppColors.beachSea,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 18, bottom: 10),
                        child: ATText(text: 'PO-${widget.receiveTicketsModel?.num} ${widget.receiveTicketsModel?.vendorName}'.capitalizeFirstofEach(), style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700)),
                      ),
                      Container(
                        color: AppColors.beachSea,
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, bottom: 20),
                        child: ATSearchfield(
                            hintText: I18n.of(context).search,
                            textEditingController: searchController,
                            onPressed: () {
                              if (searchController.text.isNotEmpty == true) {}
                            },
                            onChanged: (String value) {
                              EasyDebounce.debounce('deebouncer1',
                                  Duration(milliseconds: 700), () {});
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
                                    visible: state.receiveTicketDetailsModel
                                            ?.isNotEmpty ==
                                        true,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(flex: 1, child: SizedBox()),
                                        Expanded(
                                            flex: 3,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 5),
                                              child: ATText(
                                                fontColor: AppColors.greyHeader,
                                                text: 'SKU',
                                                weight: FontWeight.bold,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 5),
                                              child: ATText(
                                                fontColor: AppColors.greyHeader,
                                                text: 'LOCATION',
                                                weight: FontWeight.bold,
                                              ),
                                            )),
                                        SizedBox(width: 18),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              padding: const EdgeInsets.only(
                                                  right: 18,
                                                  top: 20,
                                                  bottom: 5),
                                              child: ATText(
                                                fontColor: AppColors.greyHeader,
                                                text: 'QTY RCV\'D',
                                                weight: FontWeight.bold,
                                              ),
                                            )),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      Expanded(
                          child: Container(
                              color: AppColors.white,
                              child: SmartRefresher(
                                  enablePullDown: canRefresh,
                                  onRefresh: () => _forcedRefresh(
                                      id: widget.receiveTicketsModel?.id),
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
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: ATText(
                                                      text: I18n.of(context)
                                                          .please_wait_while_data_is_loaded),
                                                ))
                                          ],
                                        )
                                      : state.receiveTicketDetailsModel
                                                  ?.isNotEmpty ==
                                              true
                                          ? ListView.builder(
                                              //itemScrollController: itemScrollController,
                                              //itemPositionsListener: itemPositionsListener,
                                              itemCount:
                                                  (state.receiveTicketDetailsModel
                                                              ?.length ??
                                                          0) +
                                                      1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (index == 0) {
                                                  return SizedBox();
                                                }
                                                index -= 1;
                                                return Visibility(
                                                    visible: _isVisible ||
                                                        state
                                                                .receiveTicketDetailsModel?[
                                                                    index]
                                                                .isFiltered ==
                                                            false,
                                                    child: Slidable(
                                                        key: ValueKey<int>(
                                                            index),
                                                        startActionPane: ActionPane(
                                                            // A motion is a widget used to control how the pane animates.
                                                            motion: const ScrollMotion(),
                                                            children: <Widget>[
                                                              SlidableAction(
                                                                onPressed:
                                                                    (BuildContext
                                                                        context) {},
                                                                backgroundColor:
                                                                    AppColors
                                                                        .greyRed,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .white,
                                                                icon: Icons
                                                                    .list_alt,
                                                              ),
                                                            ]),
                                                        child: Container(
                                                          color: AppColors
                                                              .backgroundColor,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  bottom: 5),
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      if (state
                                                                              .receiveTicketDetailsModel?[index]
                                                                              .isVisible ==
                                                                          false) {
                                                                        //set previous open to close
                                                                        if (currentIndex !=
                                                                            -1) {
                                                                          state
                                                                              .receiveTicketDetailsModel?[currentIndex]
                                                                              .setIsVisible(false);
                                                                          //call exit pick here
                                                                          context
                                                                              .read<ReceiveTicketDetailsBloc>()
                                                                              .exitReceiveDetail(id: state.receiveTicketDetailsModel?[currentIndex].id ?? '');
                                                                          currentIndex =
                                                                              -1;
                                                                        }
                                                                        currentIndex =
                                                                            index;
                                                                        state
                                                                            .receiveTicketDetailsModel?[index]
                                                                            .setIsVisible(true);
                                                                        //call begin pick here
                                                                        context
                                                                            .read<ReceiveTicketDetailsBloc>()
                                                                            .beginReceiveDetail(id: state.receiveTicketDetailsModel?[index].id ?? '');
                                                                      } else {
                                                                        state
                                                                            .receiveTicketDetailsModel?[index]
                                                                            .setIsVisible(false);
                                                                        //call exit pick here
                                                                        context
                                                                            .read<ReceiveTicketDetailsBloc>()
                                                                            .exitReceiveDetail(id: state.receiveTicketDetailsModel?[index].id ?? '');
                                                                        currentIndex =
                                                                            -1;
                                                                      }
                                                                      state
                                                                          .receiveTicketDetailsModel?[
                                                                              index]
                                                                          .setIsVisible(state.receiveTicketDetailsModel?[index].isVisible ??
                                                                              false);
                                                                    });
                                                                  },
                                                                  child: Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: SizedBox(
                                                                                width: 24,
                                                                                child: Checkbox(
                                                                                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                                                                    activeColor: state.receiveTicketDetailsModel?[index].isOver?.toLowerCase() == 'y' || state.receiveTicketDetailsModel?[index].isUnder?.toLowerCase() == 'y' ? AppColors.warningOrange : AppColors.successGreen,
                                                                                    value: state.receiveTicketDetailsModel?[index].isChecked ?? false,
                                                                                    onChanged: (bool? value) {
                                                                                      context.read<ReceiveTicketDetailsBloc>().updateCheckBox(state.receiveTicketDetailsModel?[index], value, widget.receiveTicketsModel?.id, textFieldControllers[index]);
                                                                                    }),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: ATText(
                                                                                text: state.receiveTicketDetailsModel?[index].sku,
                                                                                weight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: ATText(
                                                                                text: state.receiveTicketDetailsModel?[index].containerCode,
                                                                                weight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Container(
                                                                                alignment: Alignment.centerRight,
                                                                                child: ATText(
                                                                                  text: context.read<ReceiveTicketDetailsBloc>().getQuantityText(state.receiveTicketDetailsModel?[index], textFieldControllers[index].text),
                                                                                  weight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: 18)
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: SizedBox(),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: ATText(
                                                                                text: state.receiveTicketDetailsModel?[index].itemName,
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: ATText(
                                                                                text: state.receiveTicketDetailsModel?[index].itemNum,
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Container(
                                                                                alignment: Alignment.centerRight,
                                                                                child: ATText(
                                                                                  text: '${state.receiveTicketDetailsModel?[index].uom} ${state.receiveTicketDetailsModel?[index].qtyUnit}',
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: 18)
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                5),
                                                                        TicketPicker(
                                                                          receiveTicketDetailsModel:
                                                                              state.receiveTicketDetailsModel?[index],
                                                                          controller:
                                                                              textFieldControllers[index],
                                                                          onFieldSubmitted: (String? value) =>
                                                                              setState(() {
                                                                            if (value?.isNotEmpty ==
                                                                                true) {
                                                                              context.read<ReceiveTicketDetailsBloc>().setQuantityPicked(state.receiveTicketDetailsModel?[index], textFieldControllers[index]);
                                                                              if (state.receiveTicketDetailsModel?[index].isVisible == false) {
                                                                                //set previous open to close
                                                                                if (currentIndex != -1) {
                                                                                  state.receiveTicketDetailsModel?[currentIndex].setIsVisible(false);
                                                                                  currentIndex = -1;
                                                                                }
                                                                                currentIndex = index;
                                                                                state.receiveTicketDetailsModel?[index].setIsVisible(true);
                                                                                context.read<ReceiveTicketDetailsBloc>().beginReceiveDetail(id: state.receiveTicketDetailsModel?[index].id ?? '');
                                                                              } else {
                                                                                currentIndex = -1;
                                                                                state.receiveTicketDetailsModel?[index].setIsVisible(false);
                                                                              }
                                                                              state.receiveTicketDetailsModel?[index].setIsVisible(state.receiveTicketDetailsModel?[index].isVisible ?? false);
                                                                            }
                                                                          }),
                                                                          onChanged:
                                                                              (String? text) {
                                                                            setState(() {
                                                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                              if (textFieldControllers[index].text.isNotEmpty == true) {
                                                                                if (!pickLimitSetting) {
                                                                                  if (double.parse(textFieldControllers[index].text) > double.parse(state.receiveTicketDetailsModel?[index].qtyOrder ?? '0')) {
                                                                                    textFieldControllers[index].clear();
                                                                                    state.receiveTicketDetailsModel?[index].setIsChecked(false);
                                                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                  }
                                                                                }
                                                                              }
                                                                            });
                                                                          },
                                                                          onReset:
                                                                              () async {
                                                                            //submitPick then forcedRefresh then popUntil
                                                                            await context.read<ReceiveTicketDetailsBloc>().submitPick(id: state.receiveTicketDetailsModel?[index].id, containerId: state.receiveTicketDetailsModel?[index].containerId ?? '', qtyReceived: '-1').then((_) {
                                                                              _forcedRefresh(id: widget.receiveTicketsModel?.id);
                                                                              Navigator.of(context).popUntil(ModalRoute.withName('/receiveTicketDetails'));
                                                                            });
                                                                          },
                                                                          iconPressed: () =>
                                                                              setState(() {
                                                                            if (textFieldControllers[index].text.isNotEmpty ==
                                                                                true) {
                                                                              textFieldControllers[index].clear();
                                                                            }
                                                                          }),
                                                                        ),
                                                                      ])),
                                                        )));
                                              })
                                          : Container(
                                              alignment: Alignment.topCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30),
                                                child: ATText(
                                                    text: I18n.of(context)
                                                        .oops_item_returned_0_results),
                                              ),
                                            ))))
                    ],
                  )),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ATTextButton(
                  buttonText: I18n.of(context).complete_ticket,
                  isLoading: state.isLoading,
                  onTap: () async {
                    //complete pick ticket here
                    List<ReceiveTicketDetailsModel>? pickDetailResponse =
                        await completeTicketRefresh(
                            id: widget.receiveTicketsModel?.id);

                    int openChecker = 0;
                    int processedChecker = 0;
                    for (ReceiveTicketDetailsModel item in pickDetailResponse ??
                        <ReceiveTicketDetailsModel>[]) {
                      if (item.status?.toLowerCase() == 'processed') {
                        processedChecker++;
                      } else if (item.status?.toLowerCase() == 'open' ||
                          item.status?.toLowerCase() == '') {
                        openChecker++;
                      } else if (item.isOver?.toLowerCase() == 'y' || item.isUnder?.toLowerCase() == 'y') {
                        completeStatus = 'partial';
                      }
                    }

                    if (openChecker ==
                        state.receiveTicketDetailsModel?.length) {
                      completeStatus = 'open';
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Icon(
                                        Icons.library_add_check_outlined,
                                        size: 70,
                                        color: AppColors.warningOrange,
                                      ),
                                      SizedBox(height: 10),
                                      ATText(
                                        text: I18n.of(context).no_lines_picked,
                                        fontSize: 16,
                                        weight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10),
                                      ATText(
                                        text: I18n.of(context)
                                            .pick_some_items_before_completing,
                                        fontSize: 16,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 40),
                                      Container(
                                        width: double.infinity,
                                        child: ATTextButton(
                                          isLoading: false,
                                          buttonText: I18n.of(context).go_back,
                                          onTap: () => Navigator.of(context)
                                              .popUntil(ModalRoute.withName(
                                                  '/receiveTicketDetails')),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else if (processedChecker ==
                        state.receiveTicketDetailsModel?.length) {
                      completeStatus = 'processed';
                      isUndo = false;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(submitSnackbar);
                      Future<void>.delayed(const Duration(seconds: 1), () {
                        if (!isUndo) {
                          context
                              .read<ReceiveTicketDetailsBloc>()
                              .completeReceiveTicket(
                                  ticketId:
                                      widget.receiveTicketsModel?.id ?? '0');
                        }
                      });
                    } else {
                      completeStatus = 'partial';
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                height: 330,
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        color: AppColors.warningOrange,
                                        size: 70,
                                      ),
                                      SizedBox(height: 10),
                                      ATText(
                                        text: I18n.of(context)
                                            .there_are_lines_partially_picked,
                                        fontSize: 16,
                                        weight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      ATText(
                                        text: I18n.of(context)
                                            .complete_ticket_anyway,
                                        fontSize: 16,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                        width: double.infinity,
                                        child: ATTextButton(
                                            isLoading: false,
                                            buttonText: I18n.of(context)
                                                .yes_complete_pick,
                                            onTap: () {
                                              Navigator.of(context).popUntil(
                                                  ModalRoute.withName(
                                                      '/receiveTicketDetails'));
                                              completePickTicket();
                                            }),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: ATTextButton(
                                          buttonStyle: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColors.white),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                    color: AppColors.beachSea),
                                              ))),
                                          buttonTextStyle: TextStyle(
                                              color: AppColors.beachSea),
                                          isLoading: false,
                                          buttonText: I18n.of(context).go_back,
                                          onTap: () => Navigator.of(context)
                                              .popUntil(ModalRoute.withName(
                                                  '/receiveTicketDetails')),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ),
          ));
    });
  }

  void _forcedRefresh({String? id}) async {
    await context
        .read<ReceiveTicketDetailsBloc>()
        .getReceiveTicketDetails(id: id);
    canRefresh = true;
    _isVisible = true;
    isInitialized = false;
  }

  Future<List<ReceiveTicketDetailsModel>?> completeTicketRefresh(
      {String? id}) async {
    canRefresh = true;
    _isVisible = true;
    isInitialized = false;
    List<ReceiveTicketDetailsModel>? pickDetailResponse = await context
        .read<ReceiveTicketDetailsBloc>()
        .getReceiveTicketDetails(id: id);
    return pickDetailResponse;
  }

  void completePickTicket() {
    isUndo = false;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(submitSnackbar);
    Future<void>.delayed(const Duration(seconds: 1), () {
      if (!isUndo) {
        context.read<ReceiveTicketDetailsBloc>().completeReceiveTicket(
            ticketId: widget.receiveTicketsModel?.id ?? '0');
      }
    });
  }
}

class TicketPicker extends StatefulWidget {
  const TicketPicker(
      {Key? key,
      this.receiveTicketDetailsModel,
      this.controller,
      required this.onFieldSubmitted,
      required this.onChanged,
      required this.onReset,
      required this.iconPressed})
      : super(key: key);

  final ReceiveTicketDetailsModel? receiveTicketDetailsModel;
  final TextEditingController? controller;
  final Function(String?) onFieldSubmitted;
  final Function(String?) onChanged;
  final VoidCallback onReset;
  final VoidCallback iconPressed;

  @override
  _TicketPicker createState() => _TicketPicker();
}

class _TicketPicker extends State<TicketPicker> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.receiveTicketDetailsModel?.isVisible ?? false,
        child: Container(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ATText(
                      text: 'LOCATION',
                      fontSize: 12,
                      fontColor: AppColors.greyText,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ATText(
                      text: I18n.of(context).sku.toUpperCase(),
                      fontSize: 12,
                      fontColor: AppColors.greyText,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: ATText(
                          text: 'QTY RCV\'D',
                          fontSize: 12,
                          fontColor: AppColors.greyText,
                        )),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ATText(
                        text: widget.receiveTicketDetailsModel?.containerCode,
                        fontSize: 14),
                  ),
                  Expanded(
                    flex: 1,
                    child: ATText(
                        text: widget.receiveTicketDetailsModel?.itemId,
                        fontSize: 14),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ATText(
                            text: context
                                .read<ReceiveTicketDetailsBloc>()
                                .getQuantityText(
                                    widget.receiveTicketDetailsModel,
                                    widget.controller?.text ?? '0'),
                            fontSize: 14,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ATText(
                        text: 'QTY RCV\'D',
                        fontSize: 14,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 130,
                        child: ATMiniTextfield(
                          qtyPick: widget.receiveTicketDetailsModel?.qtyOrder,
                          textEditingController: widget.controller,
                          onChanged: widget.onChanged,
                          autoFocus: true,
                          hintText: widget.receiveTicketDetailsModel?.qtyOrder,
                          onFieldSubmitted: widget.onFieldSubmitted,
                          iconPressed: widget.iconPressed,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.close,
                          size: 25,
                          color: AppColors.greyIcon,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    height: 330,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            size: 70,
                                            color: AppColors.warningOrange,
                                          ),
                                          SizedBox(height: 10),
                                          ATText(
                                            text: I18n.of(context)
                                                .are_you_sure_you_want_to_continue,
                                            fontSize: 18,
                                            weight: FontWeight.bold,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 10),
                                          ATText(
                                            text: I18n.of(context)
                                                .this_will_reset_to_untouched,
                                            fontSize: 16,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 20),
                                          Container(
                                            width: double.infinity,
                                            child: ATTextButton(
                                                isLoading: false,
                                                buttonText: I18n.of(context)
                                                    .yes_reset_line,
                                                onTap: widget.onReset),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: ATTextButton(
                                              buttonStyle: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppColors.white),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    side: BorderSide(
                                                        color:
                                                            AppColors.beachSea),
                                                  ))),
                                              buttonTextStyle: TextStyle(
                                                  color: AppColors.beachSea),
                                              isLoading: false,
                                              buttonText:
                                                  I18n.of(context).cancel,
                                              onTap: () => Navigator.of(context)
                                                  .popUntil(ModalRoute.withName(
                                                      '/receiveTicketDetails')),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.restart_alt,
                              size: 25,
                              color: AppColors.greyIcon,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
