import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
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
            if (item.qtyOrder?.isEmpty == true) {
              item.setQtyPicked('0');
            }
            if (double.parse(item.qtyOrder ?? '0') > 0 ||
                item.status?.toLowerCase() == 'partial') {
              item.setPickedItem(item.qtyOrder);
              item.setIsChecked(double.parse(item.qtyOrder ?? '0') > 0 ||
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
      }
    }, builder: (BuildContext context, ReceiveTicketDetailsState state) {
      return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              appBar: ATAppBar(
                  title: 'PO${widget.receiveTicketsModel?.num}',
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.white,
                    size: 24.0,
                  )),
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
                                                                          /*context.read<ReceiveTicketDetailsBloc>().exitPick(
                                                                                pickTicketDetailId: state.pickTicketsResponse?[currentIndex].id ?? '');*/
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
                                                                        /*context
                                                                              .read<ReceiveTicketDetailsBloc>()
                                                                              .exitPick(pickTicketDetailId: state.pickTicketsResponse?[index].id ?? '');*/
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
                                                                                    activeColor: state.receiveTicketDetailsModel?[index].status?.toLowerCase() == 'processed'
                                                                                        ? AppColors.successGreen
                                                                                        : double.parse(state.receiveTicketDetailsModel?[index].pickedItem?.isEmpty ?? false ? '0' : state.receiveTicketDetailsModel?[index].pickedItem ?? '0') == double.parse(state.receiveTicketDetailsModel?[index].qtyOrder ?? '0')
                                                                                            ? AppColors.successGreen
                                                                                            : AppColors.warningOrange,
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
                                                                            /*if (value?.isNotEmpty == true) {
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
                                                                                  }*/
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
                      text: I18n.of(context).location.toUpperCase(),
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
                          text: I18n.of(context).quantity_picked.toUpperCase(),
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
                        text: I18n.of(context).quantity_picked.toUpperCase(),
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
                                                      '/pickTicketDetails')),
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
