import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../config/globalenv.dart';
import '../model/picsum_model.dart';
import '../view/detail_screen.dart';
import 'shimmer_box.dart';

class ImageCard extends StatelessWidget {
  final PicsumModel image;

  const ImageCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "${SERVER_URL}id/${image.id}/600/400";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetailScreen(image: image),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(12),
          child: Column(
            children: [
              Hero(
                tag: image.id,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  memCacheWidth: 600,
                  memCacheHeight: 400,
                  placeholder: (_, __) =>
                      const ShimmerBox(),
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.error),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(8),
                child: Text(
                  image.author,
                  style: const TextStyle(
                      fontWeight:
                          FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
