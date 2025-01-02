import 'package:flutter/material.dart';

class DynamicImageLoader extends StatelessWidget {
  final String? imageUrl;
  final String placeholderPath;
  final double width;
  final double height;

  const DynamicImageLoader({
    Key? key,
    required this.placeholderPath,
    this.imageUrl,
    this.width = 160.0,
    this.height = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
      imageUrl!,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          placeholderPath,
          width: width,
          height: height,
        );
      },
    )
        : Image.asset(
      placeholderPath,
      width: width,
      height: height,
    );
  }
}
