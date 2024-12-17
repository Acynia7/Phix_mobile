import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'utils.dart';

class QrCameraWidget extends StatelessWidget {
  const QrCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const QrCamera(
      qrCodeCallback: handleQrCode,
    );
  }
}