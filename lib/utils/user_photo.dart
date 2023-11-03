import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path/path.dart';

Widget userPhoto({required double radius, required String url}) {
  return CircleAvatar(
    radius: radius,
    child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                shape: BoxShape.circle),
          );
        },
        placeholder: (context, url) {
          return const CircularProgressIndicator();
        },
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        }),
  );
}
