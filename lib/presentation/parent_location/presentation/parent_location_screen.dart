import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/presentation/location_mapper/presentation/location_mapper_screen.dart';
import 'package:mobile_warehouse/presentation/parent_location/bloc/parent_location_bloc.dart';
import 'package:mobile_warehouse/presentation/parent_location/bloc/parent_location_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/container_model.dart';

class ParentLocationScreen extends StatefulWidget {
  const ParentLocationScreen({Key? key, this.parentId, this.navigation, this.parentName, this.container}) : super(key: key);

  static const String routeName = '/parentLocation';
  static const String screenName = 'parentLocationScreen';

  final String? parentId;
  final String? navigation;
  final String? parentName;
  final ContainerModel? container;

  static ModalRoute<ParentLocationScreen> route({String? parentId, String? navigation, String? parentName, ContainerModel? container}) =>
      MaterialPageRoute<ParentLocationScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ParentLocationScreen(
          parentId: parentId,
          navigation: navigation,
          parentName: parentName,
          container: container,
        ),
      );

  @override
  _ParentLocationScreen createState() => _ParentLocationScreen();
}

class _ParentLocationScreen extends State<ParentLocationScreen> {
  String? parentName;
  bool isNavigated = false;

  @override
  void initState() {
    super.initState();
    if (widget.parentId == null || widget.parentId == 'root') {
      context.read<ParentLocationBloc>().getContainerChild('root', 'children', widget.container);
      parentName = 'Root';
    } else {
      if (widget.navigation == 'pop') {
        context.read<ParentLocationBloc>().getContainerChild(widget.parentId, 'parent', widget.container);
      } else {
        context.read<ParentLocationBloc>().getContainerChild(widget.parentId, 'children', widget.container);
      }
      parentName = widget.parentName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParentLocationBloc, ParentLocationState>(
        listener: (BuildContext context, ParentLocationState state) {
          if(state.parentLocationModel?.message == 'NoData' && !isNavigated) {
            isNavigated = true;
            Navigator.of(context).pushReplacement(LocationMapperScreen.route(container: widget.container));
          }
        },
        builder: (BuildContext context, ParentLocationState state) {
          return SafeArea(
              child: Scaffold(
                  appBar: ATAppBar(
                    title: I18n.of(context).location_mapper.capitalizeFirstofEach(),
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      color: AppColors.white,
                      size: 24.0,
                    ),
                    onTap: () => Navigator.of(context).popUntil(ModalRoute.withName('/dashboard')),
                  ),
                  body: !state.isLoading
                      ? state.containerModel?.isNotEmpty == true ? Container(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: (state.containerModel?.length ?? 0) + 1,
                                      itemBuilder: (BuildContext context, int index) {
                                        if (index == 0) {
                                          return Container(
                                            color: AppColors.gray6,
                                            child: Row(
                                              children: <Widget>[
                                                state.containerModel?[index].isRoot?.toLowerCase() == 'n' ? Ink(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(ParentLocationScreen.route(
                                                        parentId: (int.parse(state.containerModel?[index].parentId ?? '')).toString(),
                                                        navigation: 'pop',
                                                        parentName: state.containerModel?[index].code,
                                                        container: state.containerModel?[index]
                                                      ));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 16, right: 20),
                                                      child: Icon(
                                                        Icons.keyboard_backspace,
                                                        size: 30,
                                                        color: AppColors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ) : SizedBox(width: 20),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                                                  child: ATText(
                                                    text: widget.navigation == 'push' || parentName == 'Root'
                                                        ? parentName
                                                        : state.containerModel?[index].code,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                        index -= 1;
                                        return Container(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Ink(
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Ink(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).pushReplacement(LocationMapperScreen.route(container: state.containerModel?[index]));
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                                                            child: ATText(
                                                              text: state.containerModel?[index].code,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(ParentLocationScreen.route(
                                                            parentId: state.containerModel?[index].id,
                                                            navigation: 'push',
                                                            parentName: state.containerModel?[index].code,
                                                            container: state.containerModel?[index]
                                                        ));
                                                      },
                                                      child: Container(
                                                        width: 60,
                                                        height: 30,
                                                        color: AppColors.black,
                                                        child: Icon(
                                                          Icons.arrow_forward_outlined,
                                                          size: 20,
                                                          color: AppColors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }))
                            ],
                          ),
                        ) : SizedBox()
                      : Column(
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
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ATText(text: I18n.of(context).please_wait_while_data_is_loaded),
                                ))
                          ],
                        )));
        });
  }
}
