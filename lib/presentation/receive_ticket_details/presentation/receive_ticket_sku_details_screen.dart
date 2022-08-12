import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_mini_textfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/picktickets/presentation/widgets/pick_tickets_status.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/bloc/receive_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/bloc/receive_ticket_details_state.dart';
import 'package:mobile_warehouse/presentation/receive_ticket_details/data/models/receive_ticket_details_model.dart';

class ReceieveTicketSkuDetailsScreen extends StatefulWidget {
  const ReceieveTicketSkuDetailsScreen(
      {Key? key,
      this.ticketItemModel,
      this.ticketList,
      required this.currentIndex})
      : super(key: key);

  final ReceiveTicketDetailsModel? ticketItemModel;
  final List<ReceiveTicketDetailsModel>? ticketList;
  final int currentIndex;

  static const String routeName = '/receieveTicketSkuDetails';
  static const String screenName = 'receieveTicketSkuDetailsScreen';

  static ModalRoute<ReceieveTicketSkuDetailsScreen> route(
          {ReceiveTicketDetailsModel? ticketItemModel,
          List<ReceiveTicketDetailsModel>? ticketList,
          required int currentIndex}) =>
      MaterialPageRoute<ReceieveTicketSkuDetailsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ReceieveTicketSkuDetailsScreen(
            ticketItemModel: ticketItemModel,
            ticketList: ticketList,
            currentIndex: currentIndex),
      );

  @override
  _ReceieveTicketSkuDetailsScreen createState() =>
      _ReceieveTicketSkuDetailsScreen();
}

class _ReceieveTicketSkuDetailsScreen
    extends State<ReceieveTicketSkuDetailsScreen> {
  TextEditingController controller = TextEditingController();

  bool pickLimitSetting = false;
  int turns = 0;

  late Timer rotatingTimer;

  @override
  void initState() {
    super.initState();
    context.read<ReceiveTicketDetailsBloc>().getSettings();
    context
        .read<ReceiveTicketDetailsBloc>()
        .beginReceiveDetail(id: widget.ticketItemModel?.id ?? '');
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
    SnackBar snackBar = SnackBar(
      content: ATText(
        text: I18n.of(context).quantity_not_greater_than_limit,
        fontColor: AppColors.white,
      ),
      duration: Duration(seconds: 1),
    );
    return BlocConsumer<ReceiveTicketDetailsBloc, ReceiveTicketDetailsState>(
        listener: (BuildContext context, ReceiveTicketDetailsState state) {},
        builder: (BuildContext context, ReceiveTicketDetailsState state) {
          pickLimitSetting = state.pickLimitSetting ?? false;
          return SafeArea(
            child: Scaffold(
                backgroundColor: AppColors.backgroundColor,
                appBar: ATAppBar(
                  title: I18n.of(context).sku_id(widget.ticketItemModel?.sku),
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.white,
                    size: 24.0,
                  ),
                  onTap: () {
                    context
                        .read<ReceiveTicketDetailsBloc>()
                        .exitReceiveDetail(id: widget.ticketItemModel?.id ?? '')
                        .then((_) => Navigator.of(context).pop());
                  },
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
                body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 18, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ATText(
                                  text: widget.ticketItemModel?.containerCode,
                                  weight: FontWeight.w700,
                                  fontSize: 24),
                              Visibility(
                                  visible: (widget.ticketItemModel?.qtyReceived
                                              ?.isNotEmpty ==
                                          true &&
                                      widget.ticketItemModel?.qtyReceived !=
                                          '0'),
                                  child: widget.ticketItemModel?.qtyReceived
                                                  ?.isNotEmpty ==
                                              true &&
                                          widget.ticketItemModel?.qtyReceived !=
                                              '0'
                                      ? Icon(
                                          Icons.check_circle,
                                          color: double.parse(widget
                                                          .ticketItemModel
                                                          ?.qtyReceived ??
                                                      '0') ==
                                                  double.parse(widget
                                                          .ticketItemModel
                                                          ?.qtyOrder ??
                                                      '0')
                                              ? AppColors.successGreen
                                              : AppColors.warningOrange,
                                          size: 25,
                                        )
                                      : PickTicketsStatusWidget(
                                          status:
                                              widget.ticketItemModel?.status,
                                          turns: turns,
                                          size: 25,
                                        )),
                            ],
                          ),
                          SizedBox(height: 6),
                          ATText(
                              text: widget.ticketItemModel?.itemName,
                              fontSize: 14,
                              fontColor: AppColors.semiDarkText),
                          Container(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.broken_image,
                              color: AppColors.greyText,
                              size: 200,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: ATText(
                                  text: I18n.of(context).sku.toUpperCase(),
                                  weight: FontWeight.w700,
                                  fontSize: 14,
                                  fontColor: AppColors.greyText,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: ATText(
                                  text: I18n.of(context).loc_code.toUpperCase(),
                                  weight: FontWeight.w700,
                                  fontSize: 14,
                                  fontColor: AppColors.greyText,
                                ),
                              ),
                              /*Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: ATText(
                                text: I18n.of(context).on_hand.toUpperCase(),
                                weight: FontWeight.w700,
                                fontSize: 12,
                                fontColor: AppColors.greyText,
                              ),
                            ),
                          ),*/
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: ATText(
                                    text: widget.ticketItemModel?.sku,
                                    weight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              Expanded(
                                flex: 4,
                                child: ATText(
                                    text: widget.ticketItemModel?.containerCode,
                                    weight: FontWeight.w700,
                                    fontSize: 15),
                              ),

                              /*Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: ATText(
                                  text: widget.ticketItemModel?.qtyOrd,
                                  weight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ),*/
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: ATText(
                                  text: 'UOM',
                                  weight: FontWeight.w700,
                                  fontSize: 14,
                                  fontColor: AppColors.greyText,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ATText(
                                  text: I18n.of(context).quantity.toUpperCase(),
                                  weight: FontWeight.w700,
                                  fontSize: 14,
                                  fontColor: AppColors.greyText,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: ATText(
                                    text: 'QTY RCV\'D',
                                    weight: FontWeight.w700,
                                    fontSize: 14,
                                    fontColor: AppColors.greyText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: ATText(
                                    text:
                                        '${widget.ticketItemModel?.uom} ${widget.ticketItemModel?.qtyUnit}',
                                    weight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              Expanded(
                                flex: 2,
                                child: ATText(
                                    text: '${widget.ticketItemModel?.qtyOrder}',
                                    weight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: ATText(
                                      text:
                                          '${double.parse(widget.ticketItemModel?.qtyReceived ?? '0').toString().removeDecimalZeroFormat(double.parse(widget.ticketItemModel?.qtyReceived ?? '0'))}',
                                      weight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(children: <Widget>[
                                ATText(
                                  text: 'QTY RCV\'D',
                                  fontSize: 14,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 130,
                                  child: ATMiniTextfield(
                                    textEditingController: controller,
                                    onChanged: (String? value) {
                                      setState(() {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        if (controller.text.isNotEmpty ==
                                            true) {
                                          if (!pickLimitSetting) {
                                            if (double.parse(controller.text) >
                                                double.parse(widget
                                                        .ticketItemModel
                                                        ?.qtyOrder ??
                                                    '0')) {
                                              controller.clear();
                                              widget.ticketItemModel
                                                  ?.setIsChecked(false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        }
                                      });
                                    },
                                    autoFocus: false,
                                    onFieldSubmitted: (String? value) =>
                                        setState(() {
                                      if (value?.isNotEmpty == true) {
                                        context
                                            .read<ReceiveTicketDetailsBloc>()
                                            .setQuantityPicked(
                                                widget.ticketItemModel,
                                                controller);
                                      }
                                    }),
                                    iconPressed: () => setState(() {
                                      if (controller.text.isNotEmpty == true) {
                                        controller.clear();
                                      }
                                    }),
                                  ),
                                )
                              ])
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: ATText(
                                  text: 'NOTE',
                                  weight: FontWeight.w700,
                                  fontSize: 14,
                                  fontColor: AppColors.greyText,
                                ),
                              ),
                            ],
                          ),
                          /*Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: widget.ticketItemModel?.note
                                    ?.isNotEmpty ==
                                    true
                                    ? ATText(
                                    text: '${widget.ticketItemModel?.note}',
                                    weight: FontWeight.w700,
                                    fontSize: 13)
                                    : ATText(
                                    text: 'No additional notes.',
                                    weight: FontWeight.w700,
                                    fontSize: 13),
                              )
                            ],
                          ),*/
                        ],
                      ),
                    )),
                bottomNavigationBar: Padding(
                  padding:
                      const EdgeInsets.only(left: 36, right: 36, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: widget.currentIndex > 0
                            ? () {
                                context
                                    .read<ReceiveTicketDetailsBloc>()
                                    .exitReceiveDetail(
                                        id: widget.ticketItemModel?.id ?? '');
                                Navigator.of(context).pushReplacement(
                                    ReceieveTicketSkuDetailsScreen.route(
                                        ticketItemModel: widget.ticketList?[
                                            widget.currentIndex - 1],
                                        ticketList: widget.ticketList,
                                        currentIndex: widget.currentIndex - 1));
                              }
                            : null,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_left_outlined,
                              size: 28,
                              color: widget.currentIndex > 0
                                  ? AppColors.black
                                  : AppColors.greyHeader,
                            ),
                            ATText(
                                text: I18n.of(context).prev,
                                fontColor: widget.currentIndex > 0
                                    ? AppColors.black
                                    : AppColors.greyHeader)
                          ],
                        ),
                      ),
                      ATText(
                        text:
                            '${widget.currentIndex + 1} ${I18n.of(context).sequence_of} ${widget.ticketList?.length}',
                        fontColor: AppColors.semiDarkText,
                        fontSize: 14,
                      ),
                      GestureDetector(
                        onTap: widget.currentIndex + 1 <
                                widget.ticketList!.length.toInt()
                            ? () {
                                context
                                    .read<ReceiveTicketDetailsBloc>()
                                    .exitReceiveDetail(
                                        id: widget.ticketItemModel?.id ?? '');
                                Navigator.of(context).pushReplacement(
                                    ReceieveTicketSkuDetailsScreen.route(
                                        ticketItemModel: widget.ticketList?[
                                            widget.currentIndex + 1],
                                        ticketList: widget.ticketList,
                                        currentIndex: widget.currentIndex + 1));
                              }
                            : null,
                        child: Row(
                          children: <Widget>[
                            ATText(
                                text: I18n.of(context).next,
                                fontColor: widget.currentIndex + 1 <
                                        widget.ticketList!.length.toInt()
                                    ? AppColors.black
                                    : AppColors.greyHeader),
                            Icon(Icons.keyboard_arrow_right,
                                size: 28,
                                color: widget.currentIndex + 1 <
                                        widget.ticketList!.length.toInt()
                                    ? AppColors.black
                                    : AppColors.greyHeader),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    rotatingTimer.cancel();
  }
}
