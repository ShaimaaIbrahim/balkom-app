import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoProfile extends StatefulWidget {
  final String? imageUrl;
  final double imageHeight;
  final double imageWidth;
  final bool isCached;
  final double imageBorderRadius;

  const PhotoProfile(
      {required this.imageUrl,
      required this.imageHeight,
      required this.imageWidth,
      required this.imageBorderRadius,
      this.isCached = false});

  @override
  _PhotoProfileState createState() => _PhotoProfileState();
}

class _PhotoProfileState extends State<PhotoProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${widget.imageUrl}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.imageBorderRadius),
        child: Container(
            width: widget.imageWidth,
            height: widget.imageHeight,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl ?? '',
              width: widget.imageWidth,
              height: widget.imageHeight,
              fit: BoxFit.cover,
              placeholder: (context, str) {
                return Container(
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  child: Image.asset(
                    'assets/images/dark_background2.png',
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                    fit: BoxFit.fill,
                  ),
                );
              },
              errorWidget: (context, url, error) => Container(
                width: widget.imageWidth,
                height: widget.imageHeight,
                child: Image.asset(
                  'assets/images/dark_background2.png',
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  fit: BoxFit.fill,
                ),
              ),
            )),
      ),
    );
  }
}
