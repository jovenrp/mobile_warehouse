import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/string_extensions.dart';
import 'package:mobile_warehouse/core/presentation/widgets/at_appbar.dart';
import 'package:mobile_warehouse/presentation/item_lookup/bloc/item_lookup_bloc.dart';
import 'package:mobile_warehouse/presentation/item_lookup/bloc/item_lookup_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:mobile_warehouse/generated/i18n.dart';

class QRItemLookUpScreen extends StatefulWidget {
  QRItemLookUpScreen({Key? key}) : super(key: key);

  static const String routeName = '/qrItemLookUp';
  static const String screenName = 'qrItemLookUpScreen';

  static ModalRoute<QRItemLookUpScreen> route() =>
      MaterialPageRoute<QRItemLookUpScreen>(
          settings: const RouteSettings(name: routeName),
          builder: (_) => QRItemLookUpScreen());

  @override
  _QRItemLookUpScreen createState() => _QRItemLookUpScreen();
}

class _QRItemLookUpScreen extends State<QRItemLookUpScreen> {
  Barcode? result;
  bool isScanned = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ATAppBar(
              title: I18n.of(context).barcode_scanner.capitalizeFirstofEach(),
              icon: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.white,
                size: 24.0,
              ),
              onTap: () => Navigator.of(context).pop(),
              actions: <Widget>[
                Ink(
                    child: InkWell(
                        onTap: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder<void>(
                          future: controller?.getFlashStatus(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Object?> snapshot) {
                            return snapshot.data == true
                                ? Icon(
                                    Icons.flash_on,
                                    size: 30,
                                    color: AppColors.white,
                                  )
                                : Icon(
                                    Icons.flash_off,
                                    size: 30,
                                    color: AppColors.white,
                                  );
                          },
                        ))),
                SizedBox(width: 18),
                Ink(
                    child: InkWell(
                        onTap: () async {
                          await controller?.flipCamera();
                          setState(() {});
                        },
                        child: FutureBuilder<void>(
                          future: controller?.getCameraInfo(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Object?> snapshot) {
                            if (snapshot.data != null) {
                              return Icon(
                                Icons.flip_camera_ios_outlined,
                                size: 30,
                                color: AppColors.white,
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ))),
                SizedBox(width: 18),
              ],
            ),
            body: BlocConsumer<ItemLookupBloc, ItemLookupState>(
              listener: (BuildContext context, ItemLookupState state) {},
              builder: (BuildContext context, ItemLookupState state) {
                return Column(
                  children: <Widget>[
                    Expanded(flex: 4, child: _buildQrView(context)),
                  ],
                );
              },
            )));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (QRViewController ctrl, bool p) =>
          _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((Barcode scanData) {
      if (result == null) {
        result = scanData;
        context
            .read<ItemLookupBloc>()
            .lookupItemAlias(item: result?.code)
            .then((_) {
          isScanned = true;
          Future<void>.delayed(Duration.zero, () {
            Navigator.of(context).popUntil(ModalRoute.withName('/itemLookup'));
          });
        });
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
