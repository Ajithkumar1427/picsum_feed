import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/globalenv.dart';
import '../model/picsum_model.dart';

class DetailScreen extends StatelessWidget {
  final PicsumModel image;

  const DetailScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final imageUrl = "${SERVER_URL}id/${image.id}/800/600";

    return Scaffold(
      appBar: AppBar(title: Center(child: Text(image.author))),
      body: Center(
        child: Hero(
          tag: image.id,
          transitionOnUserGestures: true,
          child: InteractiveViewer(
            child: CachedNetworkImage(imageUrl: imageUrl),
          ),
        ),
      ),
    );
  }
}
