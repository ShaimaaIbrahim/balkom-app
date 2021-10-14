import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:ojos_app/core/res/global_color.dart';

class ShadowText extends StatelessWidget {
  ShadowText(this.data,
      {this.style, this.textAlign, this.maxLines, this.overflow});

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style:
                  style?.copyWith(color: globalColor.basic1.withOpacity(0.5)),
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: overflow,
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}

class ShadowText2 extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;

  const ShadowText2(
    this.data, {
    Key? key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  });

  Widget build(BuildContext context) {
    AlignmentDirectional _align;
    switch (textAlign) {
      case TextAlign.justify:
      case TextAlign.center:
        _align = AlignmentDirectional.center;
        break;
      case TextAlign.end:
      case TextAlign.right:
        _align = AlignmentDirectional.centerEnd;
        break;
      case TextAlign.start:
      case TextAlign.left:
        _align = AlignmentDirectional.centerStart;
        break;
      default:
        _align = AlignmentDirectional.center;
    }
    return new ClipRect(
      child: new Stack(
        alignment: _align,
        children: [
          Text(data,
              style:
                  style?.copyWith(color: globalColor.basic1.withOpacity(0.5)),
              textAlign: textAlign,
              textDirection: textDirection,
              softWrap: softWrap,
              overflow: overflow,
              textScaleFactor: (textScaleFactor ?? 0.0) + 0.03,
              maxLines: maxLines),
          new Text(
            data,
            style: style,
            textAlign: textAlign,
            textDirection: textDirection,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}
