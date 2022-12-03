import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String pathImage;
  final double? height;
  final double? width;
  const ImageCard({Key? key, required this.pathImage, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pathImage.isNotEmpty) {
      CachedNetworkImage _cachedNetworkImage;
      if (height == null && width != null) {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl$pathImage',
          width: width,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else if (height != null && width == null) {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl$pathImage',
          height: height,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else if (height != null && width != null) {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl$pathImage',
          width: width,
          height: height,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl$pathImage',
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
      return _cachedNetworkImage;
    } else {
      return const SizedBox();
    }
  }
}
