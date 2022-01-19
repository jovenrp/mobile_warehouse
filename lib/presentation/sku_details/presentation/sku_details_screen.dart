import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/presentation/picktickets_details/data/models/pick_tickets_details_model.dart';
import 'package:mobile_warehouse/presentation/sku_details/bloc/sku_details_bloc.dart';
import 'package:mobile_warehouse/presentation/sku_details/bloc/sku_details_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

class SkuDetailsScreen extends StatefulWidget {
  const SkuDetailsScreen({Key? key, this.ticketItemModel}) : super(key: key);

  final PickTicketDetailsModel? ticketItemModel;

  static const String routeName = '/pickTicketDetails';
  static const String screenName = 'pickTicketDetailsScreen';

  static ModalRoute<SkuDetailsScreen> route(
          {PickTicketDetailsModel? ticketItemModel}) =>
      MaterialPageRoute<SkuDetailsScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => SkuDetailsScreen(ticketItemModel: ticketItemModel),
      );

  @override
  _SkuDetailsScreen createState() => _SkuDetailsScreen();
}

class _SkuDetailsScreen extends State<SkuDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ticketItemModel?.sku);
    print(widget.ticketItemModel?.location);
    return BlocConsumer<SkuDetailsBloc, SkuDetailsState>(
        listener: (BuildContext context, SkuDetailsState state) {},
        builder: (BuildContext context, SkuDetailsState state) {
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
                body: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    children: <Widget>[],
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
