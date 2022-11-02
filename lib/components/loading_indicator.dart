import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Center loadingIndicator(context) {
  return const Center(
    child: SpinKitWave(
      size: 40.0,
      color: Color(0xffffb109),
    ),
  );
}
