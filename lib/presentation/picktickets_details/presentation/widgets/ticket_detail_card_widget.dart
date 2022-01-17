import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';

class TicketDetailCardWidget extends StatefulWidget {
  const TicketDetailCardWidget({Key? key, this.pickTicketDetailsModel})
      : super(key: key);

  final PickTicketDetailsModel? pickTicketDetailsModel;

  @override
  _TicketDetailCardWidget createState() => _TicketDetailCardWidget();
}

class _TicketDetailCardWidget extends State<TicketDetailCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            AppColors.semiDark,
            AppColors.beachSea,
          ],
        ),
        border: Border.all(
          color: AppColors.beachSea,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ATText(
                    text: widget.pickTicketDetailsModel?.itemId,
                    fontSize: 14,
                    fontColor: AppColors.white,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(width: 10),
                  ATText(
                    text: widget.pickTicketDetailsModel?.sku,
                    fontSize: 14,
                    fontColor: AppColors.white,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(width: 10),
                  ATText(
                    text: widget.pickTicketDetailsModel?.qtyPick,
                    fontSize: 14,
                    fontColor: AppColors.white,
                    weight: FontWeight.w700,
                  ),
                  ATText(
                    text: widget.pickTicketDetailsModel?.uom?.toLowerCase(),
                    fontSize: 14,
                    fontColor: AppColors.white,
                  ),
                ],
              ),
              Icon(
                // Based on passwordVisible state choose the icon
                Icons.double_arrow_outlined,
                color: AppColors.white,
              ),
            ],
          ),
          Divider(color: AppColors.atDark),
          ATText(
              text: widget.pickTicketDetailsModel?.description,
              fontSize: 14,
              fontColor: AppColors.white),
        ],
      ),
    );
  }
}
