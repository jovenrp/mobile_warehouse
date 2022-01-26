import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_mini_textfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';
import 'package:mobile_warehouse/presentation/sku_details/presentation/sku_details_screen.dart';
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
  List<TextEditingController> textFieldControllers = <TextEditingController>[];
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
    SnackBar snackBar = SnackBar(
      content: ATText(
        text: 'Quantity must not be greater than the limit.',
        fontColor: AppColors.white,
      ),
      duration: Duration(seconds: 1),
    );
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
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
                          onRefresh: () => _forcedRefresh(
                              pickTicketId: widget.ticketItemModel?.id),
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
                                  itemCount:
                                      (state.pickTicketsResponse?.length ?? 0) +
                                          1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1, child: SizedBox()),
                                            Expanded(
                                                flex: 2,
                                                child: ATText(
                                                  text: I18n.of(context)
                                                      .location
                                                      .toUpperCase(),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: ATText(
                                                  text: I18n.of(context)
                                                      .sku
                                                      .toUpperCase(),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: ATText(
                                                    text: I18n.of(context)
                                                        .quantity
                                                        .toUpperCase(),
                                                  ),
                                                )),
                                            SizedBox(width: 18)
                                          ],
                                        ),
                                      );
                                    }
                                    index -= 1;
                                    textFieldControllers.add(
                                        TextEditingController(
                                            text: state
                                                .pickTicketsResponse?[index]
                                                .qtyPick));
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
                                                  Navigator.of(
                                                      context)
                                                      .push(SkuDetailsScreen.route(
                                                      ticketItemModel:
                                                      state.pickTicketsResponse?[
                                                      index],
                                                      ticketList: state
                                                          .pickTicketsResponse,
                                                      currentIndex:
                                                      index));
                                                },
                                                backgroundColor: Color(0xFF21B7CA),
                                                foregroundColor: Colors.white,
                                                icon: Icons.list_alt,
                                                label: 'SKU',
                                              ),
                                            ]), child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      /*color: state.pickTicketsResponse?[index]
                                                  .qtyPicked !=
                                              state.pickTicketsResponse?[index]
                                                  .qtyPick
                                          ? AppColors.warningOrange
                                          : (index % 2) == 0
                                              ? AppColors.white
                                              : AppColors.lightBlue,*/
                                      child: Column(children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (state
                                                        .pickTicketsResponse?[
                                                            index]
                                                        .isVisible ==
                                                    false) {
                                                  state.pickTicketsResponse?[
                                                          index]
                                                      .setIsVisible(true);
                                                } else {
                                                  state.pickTicketsResponse?[
                                                          index]
                                                      .setIsVisible(false);
                                                }
                                                state
                                                    .pickTicketsResponse?[index]
                                                    .setIsVisible(state
                                                            .pickTicketsResponse?[
                                                                index]
                                                            .isVisible ??
                                                        false);
                                                print(state
                                                    .pickTicketsResponse?[index]
                                                    .isVisible);
                                              });
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 24,
                                                    child: Checkbox(
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: -4,
                                                                vertical: -4),
                                                        activeColor: state.pickTicketsResponse?[index].pickedItem == null ? AppColors.successGreen : double.parse(state.pickTicketsResponse?[index].pickedItem?.isEmpty ?? false
                                                            ? '0' : state.pickTicketsResponse?[index].pickedItem ?? '0')
                                                            < double.parse(state.pickTicketsResponse?[index].qtyPick ?? '0') ? AppColors.warningOrange
                                                            : AppColors.successGreen,
                                                        value: state
                                                                .pickTicketsResponse?[
                                                                    index]
                                                                .isChecked ??
                                                            false,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            state
                                                                .pickTicketsResponse?[
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
                                                        .pickTicketsResponse?[
                                                            index]
                                                        .location,
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: ATText(
                                                    text: state
                                                        .pickTicketsResponse?[
                                                            index]
                                                        .sku,
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ATText(
                                                      text: double.parse(state
                                                                      .pickTicketsResponse?[
                                                                          index]
                                                                      .qtyPicked ??
                                                                  '0') == 0 && (state.pickTicketsResponse?[index].pickedItem == null ||
                                                          state.pickTicketsResponse?[index].pickedItem?.isEmpty == true)
                                                          ? '${state.pickTicketsResponse?[index].qtyPick}'
                                                          : state.pickTicketsResponse?[index].pickedItem == null ||  state.pickTicketsResponse?[index].pickedItem?.isEmpty == true ?
                                                      '${state.pickTicketsResponse?[index].qtyPick} of ${state.pickTicketsResponse?[index].qtyPick}' :
                                                      '${state.pickTicketsResponse?[index].pickedItem} of ${state.pickTicketsResponse?[index].qtyPick}',
                                                      weight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 18)
                                              ],
                                            )),
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
                                                    .pickTicketsResponse?[index]
                                                    .description,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ATText(
                                                  text:
                                                      '${state.pickTicketsResponse?[index].uom} ${state.pickTicketsResponse?[index].unitQty}',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 18)
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        TicketPicker(
                                          pickTicketDetailsModel:
                                              state.pickTicketsResponse?[index],
                                          controller:
                                              textFieldControllers[index],
                                          onFieldSubmitted: (String? value) =>
                                              setState(() {
                                            state.pickTicketsResponse?[index]
                                                .setPickedItem(
                                                    textFieldControllers[index]
                                                        .text);
                                            state.pickTicketsResponse?[index]
                                                .setIsVisible(false);
                                            state.pickTicketsResponse?[index]
                                                .setIsChecked(true);
                                            print(state
                                                .pickTicketsResponse?[index]
                                                .pickedItem);
                                          }),
                                          onChanged: (String? text) {
                                            setState(() {
                                              if (textFieldControllers[index]
                                                      .text
                                                      .isNotEmpty ==
                                                  true) {
                                                if (double.parse(
                                                        textFieldControllers[
                                                                index]
                                                            .text) >
                                                    double.parse(state
                                                            .pickTicketsResponse?[
                                                                index]
                                                            .qtyPick ??
                                                        '0')) {
                                                  textFieldControllers[index]
                                                      .clear();
                                                  state.pickTicketsResponse?[
                                                          index]
                                                      .setIsChecked(false);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              } else {
                                                state
                                                    .pickTicketsResponse?[index]
                                                    .setIsChecked(false);
                                                state
                                                    .pickTicketsResponse?[index]
                                                    .setPickedItem(
                                                        textFieldControllers[
                                                                index]
                                                            .text);
                                              }
                                            });
                                          },
                                        ),
                                      ]),
                                    ));
                                  }))))
            ])),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ATTextButton(
            buttonText: I18n.of(context).complete_tickets,
            isLoading: state.isUpdateLoading,
            onTap: () {
              List<PickTicketDetailsModel> itemsChecked =
                  <PickTicketDetailsModel>[];
              for (PickTicketDetailsModel item
                  in state.pickTicketsResponse ?? <PickTicketDetailsModel>[]) {
                if (item.isChecked ?? false) {
                  if (double.parse(item.pickedItem ?? '0') > 0) {
                    //if the user tick the checkbox and enter a value for the
                    //input field then the item.pickedItem will be the new value of qtyPicked
                    PickTicketDetailsModel itemAdded = PickTicketDetailsModel(
                        id: item.id,
                        pickTicketId: item.pickTicketId,
                        itemId: item.itemId,
                        qtyPicked: item.pickedItem);
                    itemsChecked.add(itemAdded);
                  } else {
                    PickTicketDetailsModel itemAdded = PickTicketDetailsModel(
                        id: item.id,
                        pickTicketId: item.pickTicketId,
                        itemId: item.itemId,
                        qtyPicked: item.qtyPick);
                    itemsChecked.add(itemAdded);
                  }
                }
              }
              context
                  .read<PickTicketDetailsBloc>()
                  .updateTicketDetails(pickTicketDetailsModel: itemsChecked);
            },
          ),
        ),
      ));
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

class TicketPicker extends StatefulWidget {
  const TicketPicker(
      {Key? key,
      this.pickTicketDetailsModel,
      this.controller,
      required this.onFieldSubmitted,
      required this.onChanged})
      : super(key: key);

  final PickTicketDetailsModel? pickTicketDetailsModel;
  final TextEditingController? controller;
  final Function(String?) onFieldSubmitted;
  final Function(String?) onChanged;

  @override
  _TicketPicker createState() => _TicketPicker();
}

class _TicketPicker extends State<TicketPicker> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.pickTicketDetailsModel?.isVisible ?? false,
        child: Container(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 30),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(2)),
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
                        text: widget.pickTicketDetailsModel?.location,
                        fontSize: 14),
                  ),
                  Expanded(
                    flex: 1,
                    child: ATText(
                        text: widget.pickTicketDetailsModel?.sku, fontSize: 14),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ATText(
                            text:
                                '${widget.pickTicketDetailsModel?.qtyPicked} of ${widget.pickTicketDetailsModel?.qtyPick}',
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
                      ATText(text: I18n.of(context).quantity_picked.toUpperCase(), fontSize: 14, weight: FontWeight.bold,),
                      SizedBox(height: 10),
                      Container(
                        width: 80,
                        child: ATMiniTextfield(
                          qtyPick: widget.pickTicketDetailsModel?.qtyPick,
                          textEditingController: widget.controller,
                          onChanged: widget.onChanged,
                          autoFocus: true,
                          hintText: widget.pickTicketDetailsModel?.qtyPick,
                          onFieldSubmitted: widget.onFieldSubmitted,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
