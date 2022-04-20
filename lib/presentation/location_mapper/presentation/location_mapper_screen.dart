import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/utils/picker_alpha.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_bloc.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/container_model.dart';
import 'package:mobile_warehouse/presentation/parent_location/presentation/parent_location_screen.dart';
import 'package:mobile_warehouse/presentation/qr/presentation/qr_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LocationMapperScreen extends StatefulWidget {
  const LocationMapperScreen({Key? key, this.container}) : super(key: key);

  static const String routeName = '/locationMapper';
  static const String screenName = 'locationMapperScreen';

  final ContainerModel? container;

  static ModalRoute<LocationMapperScreen> route({ContainerModel? container}) =>
      MaterialPageRoute<LocationMapperScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => LocationMapperScreen(
          container: container,
        ),
      );

  @override
  _LocationMapperScreen createState() => _LocationMapperScreen();
}

class _LocationMapperScreen extends State<LocationMapperScreen> {
  final RefreshController refreshController = RefreshController();

  bool canRefresh = true;
  final TextEditingController parentLocationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<LocationMapperBloc>()
        .getContainerSkus(id: widget.container?.id);
    parentLocationController.text = widget.container?.code ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationMapperBloc, LocationMapperState>(
        listener: (BuildContext context, LocationMapperState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
      }
    }, builder: (BuildContext context, LocationMapperState state) {
      return SafeArea(
          child: Scaffold(
              appBar: ATAppBar(
                title: widget.container?.code?.capitalizeFirstofEach(),
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: AppColors.white,
                  size: 24.0,
                ),
                onTap: () => Navigator.of(context).push(
                    ParentLocationScreen.route(
                        navigation: 'pop',
                        parentId: widget.container?.parentId)),
              ),
              body: Container(
                  color: AppColors.beachSea,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /*Container(
                          color: AppColors.beachSea,
                          height: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  width: 100,
                                  child: WheelPickerByLetters(
                                    title: 'Aisle',
                                    index: 50,
                                  )),
                              SizedBox(
                                  width: 100,
                                  child: WheelPicker(
                                    title: 'Section',
                                    index: 20,
                                  )),
                              SizedBox(
                                  width: 100,
                                  child: WheelPickerByLetters(
                                    title: 'Shelf',
                                    index: 100,
                                  )),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: AppColors.beachSea,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                    border: Border.all(
                                        color: AppColors.white, width: 2)),
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: AppColors.white,
                                ),
                              )
                            ],
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ATSearchfield(
                              hintText: 'Assign serial number',
                              isScanner: true,
                              onPressed: () =>
                                  Navigator.of(context).push(QRScreen.route()),
                              onChanged: (String value) {}),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ATSearchfield(
                              hintText: 'Add Item / SKU',
                              isScanner: true,
                              onFieldSubmitted: (String? value) => setState(() {
                                    if (value?.isNotEmpty == true) {
                                      context.read<LocationMapperBloc>().addSku(
                                          id: widget.container?.id,
                                          skuId: value);
                                    }
                                  }),
                              onPressed: () =>
                                  Navigator.of(context).push(QRScreen.route()),
                              onChanged: (String value) {}),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: !state.isLoading
                              ? state.skus?.isNotEmpty == true
                                  ? Container(
                                      color: AppColors.white,
                                      child: ListView.builder(
                                          itemCount: (state.skus?.length ?? 0),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Slidable(
                                                key: ValueKey<int>(index),
                                                endActionPane: ActionPane(
                                                    motion:
                                                        const ScrollMotion(),
                                                    children: <Widget>[
                                                      SlidableAction(
                                                        onPressed: (BuildContext
                                                            navContext) {
                                                          context
                                                              .read<
                                                                  LocationMapperBloc>()
                                                              .removeSku(
                                                                  id: widget
                                                                      .container
                                                                      ?.id,
                                                                  skuId: state
                                                                      .skus?[
                                                                          index]
                                                                      .sku);
                                                        },
                                                        backgroundColor:
                                                            AppColors
                                                                .mnpEditRed,
                                                        foregroundColor:
                                                            AppColors.white,
                                                        icon: Icons
                                                            .delete_forever_outlined,
                                                      ),
                                                    ]),
                                                child: Container(
                                                  color: (index % 2) == 0
                                                      ? AppColors.white
                                                      : AppColors.lightBlue,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          bottom: 15,
                                                          top: 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 2,
                                                        child: ATText(
                                                            text: state
                                                                .skus?[index]
                                                                .sku,
                                                            fontSize: 16,
                                                            fontColor: AppColors
                                                                .black),
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: ATText(
                                                            text: state
                                                                .skus?[index]
                                                                .name,
                                                            fontSize: 16,
                                                            fontColor: AppColors
                                                                .black),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          }),
                                    )
                                  : Container(
                                      color: AppColors.white,
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: ATText(
                                            text: I18n.of(context)
                                                .oops_item_returned_0_results),
                                      ),
                                    )
                              : Container(
                                  color: AppColors.white,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 50),
                                      Container(
                                        child: ATLoadingIndicator(
                                          strokeWidth: 3.0,
                                          width: 30,
                                          height: 30,
                                          color: AppColors.beachSea,
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: ATText(
                                                text: I18n.of(context)
                                                    .please_wait_while_data_is_loaded),
                                          ))
                                    ],
                                  )),
                        )
                      ]))));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class WheelPicker extends StatelessWidget {
  const WheelPicker({Key? key, this.title, required this.index})
      : super(key: key);

  final String? title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            child: ATText(
          text: title,
          fontColor: AppColors.white,
          fontSize: 24,
          weight: FontWeight.bold,
        )),
        RotatedBox(
          quarterTurns: 3,
          child: Icon(
            Icons.play_arrow,
            size: 30,
            color: AppColors.white,
          ),
        ),
        Container(
          width: 100,
          height: 25,
          child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              perspective: 0.005,
              diameterRatio: .2,
              clipBehavior: Clip.none,
              physics: FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                  childCount: index,
                  builder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      child: PickerAlpha(index: index.toString()),
                    );
                  })),
        ),
        RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.play_arrow,
            size: 30,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class WheelPickerByLetters extends StatelessWidget {
  WheelPickerByLetters({Key? key, this.title, required this.index})
      : super(key: key);

  final String? title;
  final int index;
  final List<String> alphabet = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            child: ATText(
          text: title,
          fontColor: AppColors.white,
          fontSize: 24,
          weight: FontWeight.bold,
        )),
        RotatedBox(
          quarterTurns: 3,
          child: Icon(
            Icons.play_arrow,
            size: 30,
            color: AppColors.white,
          ),
        ),
        Container(
          width: 100,
          height: 25,
          child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              perspective: 0.005,
              diameterRatio: .2,
              clipBehavior: Clip.none,
              physics: FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                  childCount: alphabet.length,
                  builder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(0),
                      child:
                          PickerAlpha(index: alphabet[index], isAlphabet: true),
                    );
                  })),
        ),
        RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.play_arrow,
            size: 30,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
