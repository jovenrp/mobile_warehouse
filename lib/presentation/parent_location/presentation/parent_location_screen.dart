import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textfield.dart';
import 'package:mobile_warehouse/presentation/location_mapper/presentation/location_mapper_screen.dart';
import 'package:mobile_warehouse/presentation/parent_location/bloc/parent_location_bloc.dart';
import 'package:mobile_warehouse/presentation/parent_location/bloc/parent_location_state.dart';

import 'package:mobile_warehouse/generated/i18n.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/container_model.dart';
import 'package:mobile_warehouse/presentation/parent_location/data/models/parent_location_model.dart';

class ParentLocationScreen extends StatefulWidget {
  const ParentLocationScreen({Key? key, this.parentId, this.navigation, this.parentName, this.container, this.childrenContainer, this.currentIndex})
      : super(key: key);

  static const String routeName = '/parentLocation';
  static const String screenName = 'parentLocationScreen';

  final String? parentId;
  final String? navigation;
  final String? parentName;
  final int? currentIndex;
  final ContainerModel? container;
  final List<ContainerModel>? childrenContainer;

  static ModalRoute<ParentLocationScreen> route(
          {String? parentId,
          String? navigation,
          String? parentName,
          ContainerModel? container,
          List<ContainerModel>? childrenContainer,
          int? currentIndex}) =>
      MaterialPageRoute<ParentLocationScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ParentLocationScreen(
          parentId: parentId,
          navigation: navigation,
          parentName: parentName,
          container: container,
          childrenContainer: childrenContainer,
          currentIndex: currentIndex,
        ),
      );

  @override
  _ParentLocationScreen createState() => _ParentLocationScreen();
}

class _ParentLocationScreen extends State<ParentLocationScreen> {
  String? parentName;
  String? rootName;
  bool isNavigated = false;
  bool isDialogueError = false;
  ContainerModel? parentModel;

  List<ContainerModel>? parentContainer = <ContainerModel>[];
  List<ContainerModel>? childrenContainer = <ContainerModel>[];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.parentId == null || widget.parentId == 'root') {
      context.read<ParentLocationBloc>().getContainerChild('root', 'children', widget.container);
      parentName = 'Root';
    } else {
      changeScreen();
    }
  }

  void changeScreen() async {
    if (widget.navigation == 'pop') {
      ParentLocationModel model = await context.read<ParentLocationBloc>().getContainerChild(widget.parentId, 'parent', widget.container);
      if (model.container?.first.parentId?.isNotEmpty == true) {
        ParentLocationModel parentLocationModel =
            await context.read<ParentLocationBloc>().getContainerChild(model.container?.first.parentId, 'children', widget.container);
        parentModel = parentLocationModel.container?.first;
      }
    } else {
      await context
          .read<ParentLocationBloc>()
          .getContainerChild(widget.parentId, 'children', widget.container)
          .then((ParentLocationModel parentLocation) {
        if (parentLocation.message == 'NoData' && !isNavigated) {
          isNavigated = true;
          Navigator.of(context).pushReplacement(
              LocationMapperScreen.route(container: widget.container, containerList: widget.childrenContainer, currentIndex: widget.currentIndex));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParentLocationBloc, ParentLocationState>(listener: (BuildContext context, ParentLocationState state) {
      if (widget.navigation == 'pop' && state.containerModel?.isNotEmpty == true && state.parentContainerModel?.isNotEmpty == true) {
        if (state.containerModel?.first.isRoot?.toLowerCase() == 'n') {
          parentName = state.parentContainerModel?.first.code;
        } else {
          parentName = 'Root';
        }
      } else {
        parentName = widget.parentName?.isNotEmpty == true ? widget.parentName : widget.parentId == 'Root' ? 'Root' : state.parentLocationModel?.container?.isNotEmpty == true ? state.parentLocationModel?.container?.first.code : 'Root';
      }
    }, builder: (BuildContext context, ParentLocationState state) {
      parentContainer = state.parentContainerModel;
      childrenContainer = state.containerModel;
      rootName = state.parentContainerModel?.isNotEmpty == true ? state.parentContainerModel?.first.code : '';
      return SafeArea(
          child: Scaffold(
        appBar: ATAppBar(
          title: parentName,
          icon: Icon(
            Icons.arrow_back_sharp,
            color: AppColors.white,
            size: 24.0,
          ),
          actions: <Widget>[
            Ink(
              child: InkWell(
                onTap: () => Navigator.of(context).popUntil(ModalRoute.withName('/dashboard')),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.home,
                    color: AppColors.white,
                    size: 25,
                  ),
                ),
              ),
            )
          ],
          onTap: () {
            if (state.containerModel?[0].isRoot?.toLowerCase() == 'y') {
              Navigator.of(context).popUntil(ModalRoute.withName('/dashboard'));
            } else {
              Navigator.of(context).push(ParentLocationScreen.route(
                parentId: (int.parse(state.containerModel?[0].parentId ?? '')).toString(),
                navigation: 'pop',
                parentName: state.containerModel?[0].code,
                container: state.containerModel?[0],
                childrenContainer: state.containerModel,
              ));
            }
          },
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: AppColors.beachSea,
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                child: ATSearchfield(
                    hintText: I18n.of(context).search,
                    textEditingController: searchController,
                    onPressed: () {
                      if (searchController.text.isNotEmpty == true) {
                        setState(() {
                          context.read<ParentLocationBloc>().searchCode(value: searchController.text, parentId: widget.parentId);
                        });
                      }
                    },
                    onChanged: (String value) {
                      EasyDebounce.debounce('deebouncer1', Duration(milliseconds: 700), () {
                        setState(() {
                          context.read<ParentLocationBloc>().searchCode(value: searchController.text, parentId: widget.parentId);
                        });
                      });
                    }),
              ),
              Expanded(
                  child: state.isLoading
                      ? Column(
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
                        )
                      : state.containerModel?.isNotEmpty == true
                          ? ListView.builder(
                              itemCount: (state.containerModel?.length ?? 0) + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return SizedBox();
                                }
                                index -= 1;
                                return Slidable(
                                    key: ValueKey<int>(index),
                                    startActionPane: ActionPane(motion: const ScrollMotion(), children: <Widget>[
                                      SlidableAction(
                                        onPressed: (BuildContext navContext) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                  return addChild(
                                                      state.containerModel?[index],
                                                      isDialogueError,
                                                      setState,
                                                      state.containerModel?[index].name?.isNotEmpty == true
                                                          ? '${state.containerModel?[index].name}'
                                                          : '${state.containerModel?[index].code}');
                                                });
                                              }).then((_) {
                                            isDialogueError = false;
                                          });
                                        },
                                        backgroundColor: AppColors.successGreen,
                                        foregroundColor: AppColors.white,
                                        icon: Icons.add_circle,
                                      ),
                                    ]),
                                    child: Container(
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
                                                        Navigator.of(context).pushReplacement(LocationMapperScreen.route(
                                                            container: state.containerModel?[index],
                                                            containerList: state.containerModel,
                                                            currentIndex: index));
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            ATText(
                                                              text: state.containerModel?[index].name?.isNotEmpty == true
                                                                  ? '${state.containerModel?[index].name}'
                                                                  : '${state.containerModel?[index].code}',
                                                              fontSize: 16,
                                                              weight: FontWeight.bold,
                                                            ),
                                                            Visibility(
                                                              visible: state.containerModel?[index].num?.isNotEmpty == true,
                                                              child: ATText(
                                                                text: state.containerModel?[index].num,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          ],
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
                                                          container: state.containerModel?[index],
                                                          childrenContainer: childrenContainer,
                                                          currentIndex: index));
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.only(left: 40),
                                                      child: Container(
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.next_plan_outlined,
                                                          size: 25,
                                                          color: AppColors.black,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              })
                          : Container(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: ATText(text: I18n.of(context).oops_item_returned_0_results),
                              ),
                            ))
            ],
          ),
        ),
        bottomNavigationBar: state.containerModel?.isNotEmpty == true
            ? (parentName == 'Root' || state.containerModel?[0].isRoot?.toLowerCase() == 'y')
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ATTextButton(
                        buttonText: 'Create a child for $parentName',
                        isLoading: state.isLoading,
                        onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder: (BuildContext context, StateSetter states) {
                                    return widget.navigation == 'push'
                                        ? addChild(widget.container, isDialogueError, states, parentName)
                                        : addChild(parentContainer?.first, isDialogueError, states, parentName);
                                  });
                                }).then((_) {
                              isDialogueError = false;
                            })))
            : SizedBox(),
      ));
    });
  }

  Widget addChild(ContainerModel? containerModel, bool isError, StateSetter setState, String? parentName) {
    TextEditingController name = TextEditingController();
    TextEditingController code = TextEditingController();
    TextEditingController serial = TextEditingController();
    return Dialog(
      child: SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_box_rounded,
                      size: 40,
                      color: AppColors.successGreen,
                    ),
                    SizedBox(width: 10),
                    Flexible(child: ATText(text: 'Adding child for $parentName'))
                    //: 'Fill up the field to create a new child for '))
                  ],
                ),
                SizedBox(height: 20),
                Visibility(
                    visible: isError,
                    child: ATText(
                      text: 'Please enter a value in either name or code',
                      fontSize: 12,
                      fontColor: AppColors.atWarningRed,
                    )),
                SizedBox(height: 10),
                ATTextfield(
                  hintText: 'Enter Name',
                  textEditingController: name,
                ),
                SizedBox(height: 10),
                ATTextfield(
                  hintText: 'Enter Code',
                  textEditingController: code,
                ),
                SizedBox(height: 10),
                ATTextfield(
                  hintText: 'Enter Serial No.',
                  textEditingController: serial,
                ),
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  child: ATTextButton(
                    isLoading: false,
                    buttonText: 'Add child',
                    onTap: () {
                      setState(() {
                        if (name.text.isNotEmpty || code.text.isNotEmpty) {
                          isDialogueError = false;
                          context.read<ParentLocationBloc>().createContainer(
                              parentId: containerModel?.id, name: name.text, num: serial.text, code: code.text, containerModel: widget.container);
                          Navigator.of(context, rootNavigator: true).pop();
                        } else {
                          isDialogueError = true;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
