import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageView extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final double borderRadius;
  final BoxFit fit;
  final Color? bgColor;
  final String? placeholderAsset;
  final bool isCircular;

  const ImageView({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
    this.bgColor,
    this.placeholderAsset,
    this.isCircular = false,
  });

  bool get _isNetwork => imageUrl != null && imageUrl!.startsWith('http');
  bool get _isAsset =>
      imageUrl != null && !imageUrl!.startsWith('http') && !imageUrl!.startsWith('/');
  bool get _isFile => imageUrl != null && imageUrl!.startsWith('/');
  bool get _isSvg => imageUrl != null && imageUrl!.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final placeholder = placeholderAsset != null
        ? Image.asset(placeholderAsset!, fit: fit)
        : const Icon(Icons.image, color: Colors.grey, size: 40);

    final imageWidget = _buildImageWidget();

    final borderShape = isCircular
        ? const CircleBorder()
        : RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

    return Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        shape: borderShape,
        color: bgColor ?? Colors.transparent,
      ),
      clipBehavior: Clip.antiAlias,
      child: imageWidget ?? placeholder,
    );
  }

  Widget? _buildImageWidget() {
    try {
      if (imageUrl == null || imageUrl!.isEmpty) return null;

      // SVG IMAGE SUPPORT
      if (_isSvg) {
        if (_isNetwork) {
          return SvgPicture.network(
            imageUrl!,
            fit: fit,
            height: height,
            width: width,
            placeholderBuilder: (context) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        } else if (_isAsset) {
          return SvgPicture.asset(
            imageUrl!,
            fit: fit,
            height: height,
            width: width,
          );
        } else if (_isFile) {
          return SvgPicture.file(
            File(imageUrl!),
            fit: fit,
            height: height,
            width: width,
          );
        }
      }

      // NORMAL IMAGE SUPPORT
      if (_isNetwork) {
        return Image.network(
          imageUrl!,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.broken_image, color: Colors.grey),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          },
        );
      } else if (_isAsset) {
        return Image.asset(imageUrl!, fit: fit, height: height, width: width);
      } else if (_isFile) {
        return Image.file(File(imageUrl!), fit: fit, height: height, width: width);
      }
    } catch (e) {
      debugPrint('ImageView error: $e');
    }
    return null;
  }
}
