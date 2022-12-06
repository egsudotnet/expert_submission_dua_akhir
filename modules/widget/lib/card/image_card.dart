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
      CachedNetworkImage cachedNetworkImage;
      if (height == null && width != null) {
        cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl200$pathImage',
          width: width,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else if (height != null && width == null) {
        cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl200$pathImage',
          height: height,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else if (height != null && width != null) {
        cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl200$pathImage',
          width: width,
          height: height,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else {
        cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$baseImageUrl200$pathImage',
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
      return cachedNetworkImage;
    } else {
      return const SizedBox();
    }
  }
}
