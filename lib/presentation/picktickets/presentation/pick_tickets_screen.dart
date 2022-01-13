import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/picktickets/bloc/pick_tickets_bloc.dart';
import 'package:mobile_warehouse/presentation/picktickets/bloc/pick_tickets_state.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickTicketsBloc, PickTicketsState>(
        listener: (BuildContext context, PickTicketsState state) {},
        builder: (BuildContext context, PickTicketsState state) {
          return SafeArea(
              child: SmartRefresher(
                  enablePullDown: canRefresh,
                  onRefresh: _forcedRefresh,
                  controller: refreshController,
                  child: Scaffold(
                      appBar: ATAppBar(
                        title: I18n.of(context)
                            .pick_tickets
                            .capitalizeFirstofEach(),
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        onTap: () {},
                      ),
                      body: Text('asd'))));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _forcedRefresh() {
    canRefresh = true;
    refreshController.refreshCompleted();
    context.read<PickTicketsBloc>().getPickTickets();
  }
}
