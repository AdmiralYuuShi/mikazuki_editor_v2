import 'package:flutter/material.dart';

class ImageAssetWidget extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius borderRadius;

  const ImageAssetWidget({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        path,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
