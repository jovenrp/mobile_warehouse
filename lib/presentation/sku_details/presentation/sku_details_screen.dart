import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_mini_textfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/bloc/pick_ticket_details_state.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';
import 'package:mobile_warehouse/presentation/sku_details/bloc/sku_details_bloc.dart';
import 'package:mobile_warehouse/presentation/sku_details/bloc/sku_details_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

class SkuDetailsScreen extends StatefulWidget {
  const SkuDetailsScreen(
      {Key? key,
      this.ticketItemModel,
      this.ticketList,
      required this.currentIndex})
      : super(key: key);

  final PickTicketDetailsModel? ticketItemModel;
  final List<PickTicketDetailsModel>? ticketList;
  final int currentIndex;

  static const String routeName = '/pickTicketDetails';
  static const String screenName = 'pickTicketDetailsScreen';

  static ModalRoute<SkuDetailsScreen> route(
          {PickTicketDetailsModel? ticketItemModel,
          List<PickTicketDetailsModel>? ticketList,
          required int currentIndex}) =>
      MaterialPageRoute<SkuDetailsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => SkuDetailsScreen(
            ticketItemModel: ticketItemModel,
            ticketList: ticketList,
            currentIndex: currentIndex),
      );

  @override
  _SkuDetailsScreen createState() => _SkuDetailsScreen();
}

class _SkuDetailsScreen extends State<SkuDetailsScreen> {
  TextEditingController controller = TextEditingController();

  bool pickLimitSetting = false;

  @override
  void initState() {
    super.initState();
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
    return BlocConsumer<PickTicketDetailsBloc, PickTicketDetailsState>(
        listener: (BuildContext context, PickTicketDetailsState state) {
      if (!state.isLoading) {
        pickLimitSetting = state.pickLimitSetting ?? false;
      }
    }, builder: (BuildContext context, PickTicketDetailsState state) {
      print(widget.ticketItemModel?.status);
      return SafeArea(
        child: Scaffold(
            appBar: ATAppBar(
              title: I18n.of(context).sku_id(widget.ticketItemModel?.sku),
              icon: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
                child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ATText(
                          text: widget.ticketItemModel?.location,
                          weight: FontWeight.w700,
                          fontSize: 24),
                      Visibility(
                          visible: widget.ticketItemModel?.status
                                      ?.toLowerCase() !=
                                  'open' &&
                              widget.ticketItemModel?.status?.toLowerCase() !=
                                  '',
                          child: Icon(
                            Icons.check_circle,
                            color:
                                widget.ticketItemModel?.status?.toLowerCase() ==
                                        'processed'
                                    ? AppColors.successGreen
                                    : AppColors.warningOrange,
                            size: 25,
                          ))
                    ],
                  ),
                  SizedBox(height: 6),
                  ATText(
                      text: widget.ticketItemModel?.description,
                      fontSize: 12,
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
                          text: I18n.of(context).loc_code.toUpperCase(),
                          weight: FontWeight.w700,
                          fontSize: 12,
                          fontColor: AppColors.greyText,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: ATText(
                          text: I18n.of(context).sku.toUpperCase(),
                          weight: FontWeight.w700,
                          fontSize: 12,
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
                            text: widget.ticketItemModel?.locCode,
                            weight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      Expanded(
                        flex: 4,
                        child: ATText(
                            text: widget.ticketItemModel?.sku,
                            weight: FontWeight.w700,
                            fontSize: 12),
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
                          text: I18n.of(context).unit_of_measure.toUpperCase(),
                          weight: FontWeight.w700,
                          fontSize: 12,
                          fontColor: AppColors.greyText,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ATText(
                          text: I18n.of(context).quantity.toUpperCase(),
                          weight: FontWeight.w700,
                          fontSize: 12,
                          fontColor: AppColors.greyText,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ATText(
                            text: I18n.of(context).picked.toUpperCase(),
                            weight: FontWeight.w700,
                            fontSize: 12,
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
                                '${widget.ticketItemModel?.uom} ${widget.ticketItemModel?.unitQty}',
                            weight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      Expanded(
                        flex: 2,
                        child: ATText(
                            text: '${widget.ticketItemModel?.qtyPick}',
                            weight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ATText(
                              text: '${double.parse(widget.ticketItemModel?.pickedItem ?? '0').toStringAsFixed(0)}',
                              weight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
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
                            width: 100,
                            child: ATMiniTextfield(
                              textEditingController: controller,
                              onChanged: (String? value) {
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if (controller.text.isNotEmpty == true) {
                                    if (!pickLimitSetting) {
                                      if (double.parse(controller.text) >
                                          double.parse(
                                              widget.ticketItemModel?.qtyPick ??
                                                  '0')) {
                                        controller.clear();
                                        widget.ticketItemModel?.setIsChecked(false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  } else {
                                    widget.ticketItemModel?.setIsChecked(false);
                                    widget.ticketItemModel
                                        ?.setPickedItem(controller.text);
                                  }
                                });
                              },
                              autoFocus: false,
                              onFieldSubmitted: (String? value) => setState(() {
                                if (value?.isNotEmpty ==
                                    true) {
                                  context.read<PickTicketDetailsBloc>().setQuantityPicked(widget.ticketItemModel, controller);
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
                          fontSize: 12,
                          fontColor: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: widget.ticketItemModel?.note?.isNotEmpty == true ? ATText(
                            text:
                            '${widget.ticketItemModel?.note}',
                            weight: FontWeight.w700,
                            fontSize: 12) : ATText(
                            text:
                            'No additional notes.',
                            weight: FontWeight.w700,
                            fontSize: 12),
                      )
                    ],
                  ),

                ],
              ),
            )),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 36, right: 36, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.currentIndex > 0
                        ? () {
                            Navigator.of(context).pushReplacement(
                                SkuDetailsScreen.route(
                                    ticketItemModel: widget
                                        .ticketList?[widget.currentIndex - 1],
                                    ticketList: widget.ticketList,
                                    currentIndex: widget.currentIndex - 1));
                          }
                        : null,
                    child: widget.currentIndex > 0
                        ? Row(
                            children: <Widget>[
                              Icon(
                                Icons.keyboard_arrow_left_outlined,
                                size: 28,
                              ),
                              ATText(text: I18n.of(context).prev)
                            ],
                          )
                        : SizedBox(),
                  ),
                  ATText(
                    text:
                        '${widget.currentIndex + 1} ${I18n.of(context).sequence_of} ${widget.ticketList?.length}',
                    fontColor: AppColors.semiDarkText,
                    fontSize: 12,
                  ),
                  GestureDetector(
                    onTap: widget.currentIndex + 1 <
                            widget.ticketList!.length.toInt()
                        ? () {
                            Navigator.of(context).pushReplacement(
                                SkuDetailsScreen.route(
                                    ticketItemModel: widget
                                        .ticketList?[widget.currentIndex + 1],
                                    ticketList: widget.ticketList,
                                    currentIndex: widget.currentIndex + 1));
                          }
                        : null,
                    child: widget.currentIndex + 1 <
                            widget.ticketList!.length.toInt()
                        ? Row(
                            children: <Widget>[
                              ATText(text: I18n.of(context).next),
                              Icon(Icons.keyboard_arrow_right, size: 28),
                            ],
                          )
                        : SizedBox(),
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
  }
}
