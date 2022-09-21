import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/models/container_model.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_loading_indicator.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_searchfield.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_text.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_textbutton.dart';
import 'package:mobile_warehouse/presentation/container_move/bloc/container_move_bloc.dart';
import 'package:mobile_warehouse/presentation/container_move/bloc/container_move_state.dart';
import 'package:mobile_warehouse/presentation/qr/presentation/qr_container_move_screen.dart';
import 'package:slider_button/slider_button.dart';

class ContainerMoveScreen extends StatefulWidget {
  const ContainerMoveScreen({Key? key}) : super(key: key);

  static const String routeName = '/containerMove';
  static const String screenName = 'containerMoveScreen';

  static ModalRoute<ContainerMoveScreen> route() => MaterialPageRoute<ContainerMoveScreen>(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ContainerMoveScreen(),
      );

  @override
  _ContainerMoveScreen createState() => _ContainerMoveScreen();
}

class _ContainerMoveScreen extends State<ContainerMoveScreen> {
  final TextEditingController containerNumController = TextEditingController();
  final FocusNode containerNumNode = FocusNode();
  final TextEditingController destContainerNumController = TextEditingController();
  final FocusNode destContainerNumNode = FocusNode();

  bool containerNumTrigger = false;
  bool containerToTrigger = false;
  late String? containerNum;
  @override
  void initState() {
    super.initState();
    context.read<ContainerMoveBloc>().init();
    containerNumNode.addListener(() {
      if (containerNumNode.hasFocus == true) {
        containerNumTrigger = true;
      }
      if (containerNumNode.hasFocus == false) {
        if (containerNumTrigger) {
          containerNumTrigger = false;
          if(containerNumController.text.trim().isNotEmpty == true) {
            context
                .read<ContainerMoveBloc>()
                .searchContainer(containerNum: containerNumController.text, isDestination: false).then((List<ContainerModel> containerFrom){
              containerNum = containerFrom.first.id;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContainerMoveBloc, ContainerMoveState>(
        listener: (BuildContext context, ContainerMoveState state) {},
        builder: (BuildContext context, ContainerMoveState state) {
          destContainerNumNode.addListener(() {
            if (destContainerNumNode.hasFocus == true) {
              containerToTrigger = true;
            }

            if (destContainerNumNode.hasFocus == false){
              if (containerToTrigger) {
                containerToTrigger = false;
                if (destContainerNumController.text.trim().isNotEmpty == true) {
                  context.read<ContainerMoveBloc>().searchContainer(containerNum: destContainerNumController.text, isDestination: true).then((List<ContainerModel> container) {
                    if (container.isNotEmpty == true) {
                      context
                          .read<ContainerMoveBloc>()
                          .moveContainer(
                          containerNum: containerNum,
                          destinationContainer: container.first.id);
                    } else {

                    }
                  });
                }
              }
            }

          });
          return SafeArea(
              child: Scaffold(
                  appBar: ATAppBar(
                      title: 'Container Move',
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        color: AppColors.white,
                        size: 24.0,
                      ),
                      actions: <Widget>[
                        state.isLoading || state.isLoadingDestination
                            ? Container(
                                padding: const EdgeInsets.only(top: 20, bottom: 20, right: 18),
                                width: 35,
                                child: ATLoadingIndicator(
                                  strokeWidth: 3.0,
                                  width: 15,
                                  height: 10,
                                ),
                              )
                            : SizedBox()
                      ],
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  body: Container(
                      color: AppColors.white,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Visibility(
                          visible: state.containers?.isEmpty == true && state.isInit == false,
                          child: Container(
                            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 5),
                            width: double.infinity,
                            color: AppColors.beachSea,
                            child: ATText(
                              text: 'Container number does not exist.',
                              style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.atBrightRed, fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          color: AppColors.beachSea,
                          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                          child: ATSearchfield(
                              hintText: 'Search Container',
                              textEditingController: containerNumController,
                              focusNode: containerNumNode,
                              isScanner: true,
                              onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
                                    return QRContainerMoveScreen(scanner: 'serial', isDestination: false);
                                  })),
                              onFieldSubmitted: (String? value) {
                                context
                                    .read<ContainerMoveBloc>()
                                    .searchContainer(containerNum: value, isDestination: false)
                                    .then((List<ContainerModel> container) {
                                  destContainerNumNode.requestFocus();
                                });
                              }),
                        ),
                        Container(
                          color: AppColors.beachSea,
                          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                          child: ATSearchfield(
                            textEditingController: destContainerNumController,
                            focusNode: destContainerNumNode,
                            hintText: 'Move To',
                            isScanner: true,
                            onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
                              return QRContainerMoveScreen(scanner: 'serial', isDestination: true);
                            })).then((_) {
                              if (state.containers?.isNotEmpty == true) {
                                context
                                    .read<ContainerMoveBloc>()
                                    .moveContainer(
                                        containerNum: state.containers?.isNotEmpty == true ? state.containers?.first.id : '',
                                        destinationContainer:
                                            state.containersDestination?.isNotEmpty == true ? state.containersDestination?.first.id : '')
                                    .then((_) {
                                  containerNumNode.requestFocus();
                                });
                              }
                            }),
                            onFieldSubmitted: (String? value) {
                              context
                                  .read<ContainerMoveBloc>()
                                  .searchContainer(containerNum: value, isDestination: true)
                                  .then((List<ContainerModel> container) {
                                context
                                    .read<ContainerMoveBloc>()
                                    .moveContainer(
                                        containerNum: state.containers?.isNotEmpty == true ? state.containers?.first.id : '',
                                        destinationContainer: container.first.id)
                                    .then((_) {
                                  containerNumNode.requestFocus();
                                });
                              });
                            },
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                  visible: state.containers?.isNotEmpty == true,
                                  child: Container(
                                    child: Table(
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        columnWidths: const <int, TableColumnWidth>{
                                          0: FlexColumnWidth(100),
                                          1: FlexColumnWidth(100),
                                        },
                                        children: <TableRow>[
                                          TableRow(decoration: BoxDecoration(color: AppColors.beachSeaTint40), children: <Widget>[
                                            Container(
                                              color: AppColors.beachSeaTint20,
                                              padding: const EdgeInsets.only(left: 18, bottom: 18, top: 18),
                                              child: ATText(text: 'CONTAINER', fontSize: 14, fontColor: AppColors.white, weight: FontWeight.bold),
                                            ),
                                            Container(
                                              color: AppColors.beachSeaTint40,
                                              alignment: Alignment.centerRight,
                                              padding: const EdgeInsets.only(right: 18, bottom: 6, top: 6),
                                              child: ATText(
                                                  text: state.containers?.isNotEmpty == true ? state.containers?.first.code : '',
                                                  fontSize: 14,
                                                  fontColor: AppColors.white,
                                                  weight: FontWeight.bold),
                                            ),
                                          ])
                                        ]),
                                  )),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: state.containersDestination?.isNotEmpty == true,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_circle_down_sharp,
                                    size: 40,
                                    color: AppColors.black,
                                  ),
                                  ATText(
                                    text: state.isLoading
                                        ? 'Please wait, Container is being moved.'
                                        : '${state.hasError == true ? '${state.containerMoveResponse?.message}' : state.isMovingSuccess ? 'Success moving container' : 'Failed in moving container'} to',
                                    fontSize: 18,
                                  )
                                ],
                              ),
                            )),
                        Visibility(
                            visible: state.containersDestination?.isNotEmpty == true,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Table(
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        columnWidths: const <int, TableColumnWidth>{
                                          0: FlexColumnWidth(100),
                                          1: FlexColumnWidth(100),
                                        },
                                        children: <TableRow>[
                                          TableRow(decoration: BoxDecoration(color: AppColors.beachSeaTint40), children: <Widget>[
                                            Container(
                                              color: AppColors.beachSeaTint20,
                                              padding: const EdgeInsets.only(left: 18, bottom: 18, top: 18),
                                              child: ATText(text: 'DESTINATION', fontSize: 14, fontColor: AppColors.white, weight: FontWeight.bold),
                                            ),
                                            Container(
                                              color: AppColors.beachSeaTint40,
                                              alignment: Alignment.centerRight,
                                              padding: const EdgeInsets.only(right: 18, bottom: 6, top: 6),
                                              child: ATText(
                                                  text:
                                                      state.containersDestination?.isNotEmpty == true ? state.containersDestination?.first.code : '',
                                                  fontSize: 14,
                                                  fontColor: AppColors.white,
                                                  weight: FontWeight.bold),
                                            ),
                                          ])
                                        ]),
                                  ),
                                ],
                              ),
                            ))
                      ]))));
        });
  }
}
