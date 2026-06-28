import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? height, width;
  final BoxFit fit;
  final Color? color;

  const AppImage(
      this.path, {
        super.key,
        this.height,
        this.width,
        this.fit = BoxFit.scaleDown,
        this.color,
      });

  @override
  Widget build(BuildContext context) {
    if (path.contains("com.example.avon/cache")) {
      return Image.file(
        File(path),
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      );
    } else if (path.endsWith("svg")) {
      return FutureBuilder(
        future: DefaultAssetBundle.of(context).load("assets/svg/$path"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: height ?? 24,
              width: width ?? 24,
            );
          }
          if (snapshot.hasError) {
            return _errorWidget();
          }
          return SvgPicture.asset(
            "assets/svg/$path",
            height: height,
            width: width,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
                : null,
          );
        },
      );
    } else if (path.startsWith("http")) {
      return CachedNetworkImage(
        imageUrl: path,
        height: height,
        width: width,
        fit: fit,
        color: color,
        placeholder: (context, url) => SizedBox(
          height: height ?? 24,
          width: width ?? 24,
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
        errorWidget: (context, url, error) => _errorWidget(),
      );
    } else if (path.endsWith("png") || path.endsWith("jpg")) {
      return Image.asset(
        "assets/images/$path",
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      );
    }
    return _errorWidget();
  }

  Widget _errorWidget() {
    return Icon(
      Icons.error_outline_rounded,
      color: Colors.red,
      size: width ?? height ?? 24,
    );
  }
}