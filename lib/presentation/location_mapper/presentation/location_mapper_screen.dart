import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/utils/picker_alpha.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_bloc.dart';
import 'package:mobile_warehouse/presentation/location_mapper/bloc/location_mapper_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/qr_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LocationMapperScreen extends StatefulWidget {
  const LocationMapperScreen({Key? key}) : super(key: key);

  static const String routeName = '/locationMapper';
  static const String screenName = 'locationMapperScreen';

  static ModalRoute<LocationMapperScreen> route() => MaterialPageRoute<LocationMapperScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const LocationMapperScreen(),
      );

  @override
  _LocationMapperScreen createState() => _LocationMapperScreen();
}

class _LocationMapperScreen extends State<LocationMapperScreen> {
  final RefreshController refreshController = RefreshController();

  bool canRefresh = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationMapperBloc, LocationMapperState>(listener: (BuildContext context, LocationMapperState state) {
      if (!state.isLoading) {
        refreshController.refreshCompleted();
      }
    }, builder: (BuildContext context, LocationMapperState state) {
      return SafeArea(
          child: Scaffold(
              appBar: ATAppBar(
                title: I18n.of(context).location_mapper.capitalizeFirstofEach(),
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: AppColors.white,
                  size: 24.0,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              body: Container(
                  color: AppColors.beachSea,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: ATSearchfield(
                          hintText: '${I18n.of(context).search} by location serial no.',
                          isScanner: true,
                          onPressed: () => Navigator.of(context).push(QRScreen.route()),
                          onChanged: (String value) {}),
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: AppColors.beachSea,
                      height: 100,
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
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: ATSearchfield(
                          hintText: '${I18n.of(context).search} by SKU',
                          isScanner: true,
                          onPressed: () => Navigator.of(context).push(QRScreen.route()),
                          onChanged: (String value) {}),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        color: AppColors.white,
                      ),
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
  const WheelPicker({Key? key, this.title, required this.index}) : super(key: key);

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
        Container(
          width: 100,
          height: 50,
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
                      alignment: Alignment.bottomCenter,
                      child: PickerAlpha(index: index.toString()),
                    );
                  })),
        )
      ],
    );
  }
}

class WheelPickerByLetters extends StatelessWidget {
  WheelPickerByLetters({Key? key, this.title, required this.index}) : super(key: key);

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
        Container(
          width: 100,
          height: 50,
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
                      alignment: Alignment.bottomCenter,
                      child: PickerAlpha(index: alphabet[index], isAlphabet: true),
                    );
                  })),
        )
      ],
    );
  }
}
