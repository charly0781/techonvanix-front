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
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          placeholderPath,
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      },
    )
        : Image.asset(
      placeholderPath,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
