import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_dialog.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_mini_textfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/presentation/picktickets/data/models/pick_tickets_item_model.dart';
import 'package:mobile_warehouse/presentation/picktickets/presentation/pick_tickets_screen.dart';
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
  final TextEditingController searchController = TextEditingController();

  bool canRefresh = true;
  int currentIndex = -1;
  bool pickLimitSetting = false;
  bool isUndo = false;
  bool isInitialized = false;
  late SnackBar submitSnackbar;

  @override
  void initState() {
    super.initState();
    context
        .read<PickTicketDetailsBloc>()
        .getPickTicketDetails(pickTicketId: widget.ticketItemModel?.id);
    context.read<PickTicketDetailsBloc>().getSettings();
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
    submitSnackbar = SnackBar(
      content: ATText(
        text: 'Ticket Completed',
        fontColor: AppColors.white,
      ),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          isUndo = true;
        },
      ),
    );
    return BlocConsumer<PickTicketDetailsBloc, PickTicketDetailsState>(
        listener: (BuildContext context, PickTicketDetailsState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
        pickLimitSetting = state.pickLimitSetting ?? false;
      }

      if (!state.isUpdateLoading) {
        if (state.isCompleteTicket) {
          context.read<PickTicketDetailsBloc>().resetStates();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: SizedBox(
                    height: 360,
                    width: MediaQuery.of(context).size.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30),
                          ATText(
                            text: 'Completed!',
                            fontSize: 28,
                            weight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.check_circle,
                                color: AppColors.successGreen, size: 120),
                          ),
                          SizedBox(height: 50),
                          Container(
                            width: double.infinity,
                            child: ATTextButton(
                              isLoading: false,
                              buttonText: 'Start next ticket',
                              onTap: () => Navigator.of(context).popUntil(
                                  ModalRoute.withName('/pickTickets')),
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
          actions: <Widget>[
            state.isUpdateLoading
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 20, right: 18),
                    width: 30,
                    child: ATLoadingIndicator(
                      strokeWidth: 3.0,
                      width: 10,
                      height: 10,
                    ),
                  )
                : SizedBox()
          ],
          onTap: () {
            //complete pick ticket here
            //context.read<PickTicketDetailsBloc>().exitPickTicket(pickTicket: widget.ticketItemModel?.id ?? '0');
            Navigator.of(context).popUntil(ModalRoute.withName('/pickTickets'));
          },
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
                        hintText: I18n.of(context).search,
                        textEditingController: searchController,
                        onPressed: () {
                          if (searchController.text.isNotEmpty == true) {
                            setState(() {
                              context
                                  .read<PickTicketDetailsBloc>()
                                  .searchTicket(
                                      value: searchController.text,
                                      pickTicketId:
                                          widget.ticketItemModel?.id ?? '');
                            });
                          }
                        },
                        onChanged: (String value) {
                          EasyDebounce.debounce(
                              'deebouncer1', Duration(milliseconds: 700), () {
                            setState(() {
                              context
                                  .read<PickTicketDetailsBloc>()
                                  .searchTicket(
                                      value: searchController.text,
                                      pickTicketId:
                                          widget.ticketItemModel?.id ?? '');
                            });
                          });
                        }),
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
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: ATText(
                                                  text: I18n.of(context)
                                                      .please_wait_while_data_is_loaded),
                                            ))
                                      ],
                                    )
                                  : state.pickTicketsResponse?.isNotEmpty ==
                                          true
                                      ? ListView.builder(
                                          itemCount: (state.pickTicketsResponse
                                                      ?.length ??
                                                  0) +
                                              1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (index == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15, bottom: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: SizedBox()),
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
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: ATText(
                                                            text: I18n.of(
                                                                    context)
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
                                            if (!isInitialized) {
                                              textFieldControllers
                                                  .add(TextEditingController());
                                              state.pickTicketsResponse?[index]
                                                  .setLocation(state
                                                      .pickTicketResponse?[0]
                                                      .location);
                                              if (double.parse(state
                                                              .pickTicketsResponse?[
                                                                  index]
                                                              .qtyPicked ??
                                                          '0') >
                                                      0 ||
                                                  state
                                                          .pickTicketsResponse?[
                                                              index]
                                                          .status
                                                          ?.toLowerCase() ==
                                                      'partial') {
                                                state
                                                    .pickTicketsResponse?[index]
                                                    .setPickedItem(state
                                                        .pickTicketsResponse?[
                                                            index]
                                                        .qtyPicked);
                                                state
                                                    .pickTicketsResponse?[index]
                                                    .setIsChecked(double.parse(state
                                                                    .pickTicketsResponse?[
                                                                        index]
                                                                    .qtyPicked ??
                                                                '0') >
                                                            0 ||
                                                        state
                                                                .pickTicketsResponse?[
                                                                    index]
                                                                .status
                                                                ?.toLowerCase() ==
                                                            'partial');
                                              }
                                              if (index >=
                                                  num.parse(
                                                      (state.pickTicketsResponse!
                                                                  .length -
                                                              1)
                                                          .toString())) {
                                                isInitialized = true;
                                              }
                                            }
                                            return Slidable(
                                                key: ValueKey<int>(index),
                                                startActionPane: ActionPane(
                                                    // A motion is a widget used to control how the pane animates.
                                                    motion:
                                                        const ScrollMotion(),
                                                    children: <Widget>[
                                                      SlidableAction(
                                                        onPressed: (BuildContext
                                                            context) {},
                                                        backgroundColor:
                                                            AppColors.semiGrey,
                                                        foregroundColor:
                                                            AppColors.white,
                                                        icon: Icons
                                                            .cancel_presentation,
                                                      ),
                                                      SlidableAction(
                                                        onPressed: (BuildContext
                                                            context) {
                                                          Navigator.of(context).push(
                                                              SkuDetailsScreen.route(
                                                                  ticketItemModel:
                                                                      state.pickTicketsResponse?[
                                                                          index],
                                                                  ticketList: state
                                                                      .pickTicketsResponse,
                                                                  currentIndex:
                                                                      index));
                                                        },
                                                        backgroundColor:
                                                            AppColors.greyRed,
                                                        foregroundColor:
                                                            AppColors.white,
                                                        icon: Icons.list_alt,
                                                      ),
                                                    ]),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  /*color: state.pickTicketsResponse?[index]
                                                  .qtyPicked !=
                                              state.pickTicketsResponse?[index]
                                                  .qtyPick
                                          ? AppColors.warningOrange
                                          : (index % 2) == 0
                                              ? AppColors.white
                                              : AppColors.lightBlue,*/
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (state
                                                                  .pickTicketsResponse?[
                                                                      index]
                                                                  .isVisible ==
                                                              false) {
                                                            //set previous open to close
                                                            if (currentIndex !=
                                                                -1) {
                                                              state
                                                                  .pickTicketsResponse?[
                                                                      currentIndex]
                                                                  .setIsVisible(
                                                                      false);
                                                              if (state
                                                                      .pickTicketsResponse?[
                                                                          index]
                                                                      .pickedItem ==
                                                                  null) {
                                                                context
                                                                    .read<
                                                                        PickTicketDetailsBloc>()
                                                                    .exitPick(
                                                                        pickTicketDetailId:
                                                                            state.pickTicketsResponse?[currentIndex].id ??
                                                                                '');
                                                              }
                                                            }
                                                            currentIndex =
                                                                index;
                                                            state
                                                                .pickTicketsResponse?[
                                                                    index]
                                                                .setIsVisible(
                                                                    true);
                                                            context
                                                                .read<
                                                                    PickTicketDetailsBloc>()
                                                                .beginPick(
                                                                    pickTicketDetailId:
                                                                        state.pickTicketsResponse?[index].id ??
                                                                            '');
                                                          } else {
                                                            state
                                                                .pickTicketsResponse?[
                                                                    index]
                                                                .setIsVisible(
                                                                    false);
                                                            if (state
                                                                    .pickTicketsResponse?[
                                                                        index]
                                                                    .pickedItem ==
                                                                null) {
                                                              context
                                                                  .read<
                                                                      PickTicketDetailsBloc>()
                                                                  .exitPick(
                                                                      pickTicketDetailId:
                                                                          state.pickTicketsResponse?[index].id ??
                                                                              '');
                                                            }
                                                          }
                                                          state
                                                              .pickTicketsResponse?[
                                                                  index]
                                                              .setIsVisible(state
                                                                      .pickTicketsResponse?[
                                                                          index]
                                                                      .isVisible ??
                                                                  false);
                                                        });
                                                      },
                                                      child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 24,
                                                                    child: Checkbox(
                                                                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                                                        activeColor: state.pickTicketsResponse?[index].pickedItem == null
                                                                            ? AppColors.successGreen
                                                                            : double.parse(state.pickTicketsResponse?[index].pickedItem?.isEmpty ?? false ? '0' : state.pickTicketsResponse?[index].pickedItem ?? '0') == double.parse(state.pickTicketsResponse?[index].qtyPick ?? '0')
                                                                                ? AppColors.successGreen
                                                                                : AppColors.warningOrange,
                                                                        value: state.pickTicketsResponse?[index].isChecked ?? false,
                                                                        onChanged: (bool? value) {
                                                                          setState(
                                                                              () {
                                                                            if (value ==
                                                                                true) {
                                                                              state.pickTicketsResponse?[index].setPickedItem(state.pickTicketsResponse?[index].qtyPick);
                                                                              state.pickTicketsResponse?[index].setIsVisible(false);
                                                                              state.pickTicketsResponse?[index].setIsChecked(true);
                                                                              context.read<PickTicketDetailsBloc>().submitPick(pickTicketDetailId: state.pickTicketsResponse?[index].id ?? '', qtyPicked: state.pickTicketsResponse?[index].qtyPick ?? '');
                                                                            } else {
                                                                              state.pickTicketsResponse?[index].setPickedItem('0');
                                                                              state.pickTicketsResponse?[index].setIsVisible(false);
                                                                              state.pickTicketsResponse?[index].setIsChecked(false);
                                                                              context.read<PickTicketDetailsBloc>().submitPick(pickTicketDetailId: state.pickTicketsResponse?[index].id ?? '', qtyPicked: '0');
                                                                            }
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
                                                                        .locCode,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: ATText(
                                                                    text: state
                                                                        .pickTicketsResponse?[
                                                                            index]
                                                                        .sku,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child:
                                                                        ATText(
                                                                      text: state.pickTicketsResponse?[index].status?.toLowerCase() ==
                                                                              'partial'
                                                                          ? '${state.pickTicketsResponse?[index].qtyPicked} of ${state.pickTicketsResponse?[index].qtyPick}'
                                                                          : (state.pickTicketsResponse?[index].pickedItem == null || state.pickTicketsResponse?[index].pickedItem?.isEmpty == true)
                                                                              ? '${state.pickTicketsResponse?[index].qtyPick}'
                                                                              : state.pickTicketsResponse?[index].pickedItem == null || state.pickTicketsResponse?[index].pickedItem?.isEmpty == true
                                                                                  ? '${state.pickTicketsResponse?[index].qtyPick} of ${state.pickTicketsResponse?[index].qtyPick}'
                                                                                  : '${state.pickTicketsResponse?[index].pickedItem} of ${state.pickTicketsResponse?[index].qtyPick}',
                                                                      weight: FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 18)
                                                              ],
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      SizedBox(),
                                                                ),
                                                                Expanded(
                                                                  flex: 4,
                                                                  child: ATText(
                                                                    text: state
                                                                        .pickTicketsResponse?[
                                                                            index]
                                                                        .description,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child:
                                                                        ATText(
                                                                      text:
                                                                          '${state.pickTicketsResponse?[index].uom} ${state.pickTicketsResponse?[index].unitQty}',
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 18)
                                                              ],
                                                            ),
                                                            SizedBox(height: 5),
                                                            TicketPicker(
                                                              pickTicketDetailsModel:
                                                                  state.pickTicketsResponse?[
                                                                      index],
                                                              controller:
                                                                  textFieldControllers[
                                                                      index],
                                                              onFieldSubmitted:
                                                                  (String?
                                                                          value) =>
                                                                      setState(
                                                                          () {
                                                                state
                                                                    .pickTicketsResponse?[
                                                                        index]
                                                                    .setPickedItem(
                                                                        textFieldControllers[index]
                                                                            .text);
                                                                state
                                                                    .pickTicketsResponse?[
                                                                        index]
                                                                    .setIsVisible(
                                                                        false);
                                                                state
                                                                    .pickTicketsResponse?[
                                                                        index]
                                                                    .setIsChecked(
                                                                        true);
                                                                context.read<PickTicketDetailsBloc>().submitPick(
                                                                    pickTicketDetailId:
                                                                        state.pickTicketsResponse?[index].id ??
                                                                            '',
                                                                    qtyPicked:
                                                                        textFieldControllers[index]
                                                                            .text);
                                                              }),
                                                              onChanged:
                                                                  (String?
                                                                      text) {
                                                                setState(() {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .hideCurrentSnackBar();
                                                                  if (textFieldControllers[
                                                                              index]
                                                                          .text
                                                                          .isNotEmpty ==
                                                                      true) {
                                                                    if (!pickLimitSetting) {
                                                                      if (double.parse(textFieldControllers[index]
                                                                              .text) >
                                                                          double.parse(state.pickTicketsResponse?[index].qtyPick ??
                                                                              '0')) {
                                                                        textFieldControllers[index]
                                                                            .clear();
                                                                        state
                                                                            .pickTicketsResponse?[index]
                                                                            .setIsChecked(false);
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      }
                                                                    }
                                                                  } else {
                                                                    state
                                                                        .pickTicketsResponse?[
                                                                            index]
                                                                        .setIsChecked(
                                                                            false);
                                                                    state
                                                                        .pickTicketsResponse?[
                                                                            index]
                                                                        .setPickedItem(
                                                                            textFieldControllers[index].text);
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ])),
                                                ));
                                          })
                                      : Container(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: ATText(
                                                text: I18n.of(context)
                                                    .oops_item_returned_0_results),
                                          ),
                                        ))))
                ])),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ATTextButton(
            buttonText: I18n.of(context).complete_tickets,
            isLoading: state.isLoading,
            onTap: () async {
              //complete pick ticket here
              List<PickTicketDetailsModel>? pickDetailResponse =
                  await completeTicketRefresh(
                      pickTicketId: widget.ticketItemModel?.id);

              int openChecker = 0;
              int processedChecker = 0;
              for (PickTicketDetailsModel item
                  in pickDetailResponse ?? <PickTicketDetailsModel>[]) {
                print(item.status);
                if (item.status?.toLowerCase() == 'processed') {
                  processedChecker++;
                } else if (item.status?.toLowerCase() == 'open') {
                  openChecker++;
                }
              }

              if (openChecker == state.pickTicketsResponse?.length) {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width * .5,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 50),
                                ATText(
                                  text:
                                      'No lines on this ticket have been picked.\n\nPick some items before completing a ticket.',
                                  fontSize: 16,
                                  weight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 50),
                                Container(
                                  width: double.infinity,
                                  child: ATTextButton(
                                    isLoading: false,
                                    buttonText: 'Go back',
                                    onTap: () => Navigator.of(context).popUntil(
                                        ModalRoute.withName(
                                            '/pickTicketDetails')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (processedChecker ==
                  state.pickTicketsResponse?.length) {
                isUndo = false;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(submitSnackbar);
                Future<void>.delayed(const Duration(seconds: 1), () {
                  if (!isUndo) {
                    context.read<PickTicketDetailsBloc>().completePickTicket(
                        pickTicket: widget.ticketItemModel?.id ?? '0');
                  }
                });
              } else {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: SizedBox(
                          height: 320,
                          width: MediaQuery.of(context).size.width * .5,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 50),
                                ATText(
                                  text:
                                      'There are lines on this ticket that are partially picked. \n\n Complete ticket anyway?',
                                  fontSize: 16,
                                  weight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 50),
                                Container(
                                  width: double.infinity,
                                  child: ATTextButton(
                                      isLoading: false,
                                      buttonText: 'Yes, Complete pick',
                                      onTap: () {
                                        Navigator.of(context).popUntil(
                                            ModalRoute.withName(
                                                '/pickTicketDetails'));
                                        completePickTicket();
                                      }),
                                ),
                                SizedBox(height: 10),
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
                                    buttonTextStyle:
                                        TextStyle(color: AppColors.beachSea),
                                    isLoading: false,
                                    buttonText: 'Go back',
                                    onTap: () => Navigator.of(context).popUntil(
                                        ModalRoute.withName(
                                            '/pickTicketDetails')),
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
      ));
    });
  }

  void completePickTicket() {
    isUndo = false;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(submitSnackbar);
    Future<void>.delayed(const Duration(seconds: 1), () {
      if (!isUndo) {
        context
            .read<PickTicketDetailsBloc>()
            .completePickTicket(pickTicket: widget.ticketItemModel?.id ?? '0');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _forcedRefresh({String? pickTicketId}) {
    canRefresh = true;
    isInitialized = false;
    context
        .read<PickTicketDetailsBloc>()
        .getPickTicketDetails(pickTicketId: pickTicketId);
  }

  Future<List<PickTicketDetailsModel>?> completeTicketRefresh(
      {String? pickTicketId}) async {
    canRefresh = true;
    isInitialized = false;
    List<PickTicketDetailsModel>? pickDetailResponse = await context
        .read<PickTicketDetailsBloc>()
        .getPickTicketDetails(pickTicketId: pickTicketId);
    return pickDetailResponse;
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
                            text: widget.pickTicketDetailsModel?.status
                                        ?.toLowerCase() ==
                                    'partial'
                                ? '${widget.pickTicketDetailsModel?.qtyPicked} of ${widget.pickTicketDetailsModel?.qtyPick}'
                                : (widget.pickTicketDetailsModel?.pickedItem ==
                                            null ||
                                        widget.pickTicketDetailsModel
                                                ?.pickedItem?.isEmpty ==
                                            true)
                                    ? '${widget.pickTicketDetailsModel?.qtyPick}'
                                    : widget.pickTicketDetailsModel
                                                    ?.pickedItem ==
                                                null ||
                                            widget.pickTicketDetailsModel
                                                    ?.pickedItem?.isEmpty ==
                                                true
                                        ? '${widget.pickTicketDetailsModel?.qtyPick} of ${widget.pickTicketDetailsModel?.qtyPick}'
                                        : '${widget.pickTicketDetailsModel?.pickedItem} of ${widget.pickTicketDetailsModel?.qtyPick}',
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
