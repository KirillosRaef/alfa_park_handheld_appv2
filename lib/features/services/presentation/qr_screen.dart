import 'dart:io';

import 'package:alfa_park_handheld_appv2/features/services/application/ticket_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScreen extends ConsumerStatefulWidget {
  const QrScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends ConsumerState<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const BackButton(),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (QRViewController controller) {
                  this.controller = controller;
                  controller.scannedDataStream.listen((scanData) {
                    controller.pauseCamera();
                    ref.read(ticketServiceProvider).setCode(scanData.code!);
                    //Navigator.pushNamed(context, AppRoute.ticketInfoScreen.name);
                    Navigator.pop(context);
                  });
                },
              ),
            ),
            const Expanded(
              flex: 1,
              child: Center(
                child: Text('Scan QR Code'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
