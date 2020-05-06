import 'package:battle_me/helpers/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

class PreviewPicture extends StatelessWidget {
  final String image;
  PreviewPicture(this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getViewportWidth(context),
      width: getViewportWidth(context),
      child: Hero(
        tag: 'preview',
        child: ProgressiveImage.assetNetwork(
          placeholder: 'assets/images/wallpaper.jpg', // gifs can be used
          thumbnail: image,
          image: image,
          height: getViewportWidth(context) * 0.9,
          width: getViewportWidth(context) * 0.9,
        ),
      ),
    );
  }
}
