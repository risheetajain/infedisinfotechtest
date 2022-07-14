import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constant/color.dart';

class Widgets {
  static Widget buildButton(
      {required String text,
      required Function? onTap,
      required BuildContext context}) {
    Size size = MediaQuery.of(context).size;

    return InnerShadow(
      blur: 4,
      offset: const Offset(4, -4),
      color: Colors.white.withOpacity(0.25),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: InnerShadow(
            blur: 4,
            offset: const Offset(-4, 4),
            color: Colors.white.withOpacity(0.1),
            child: InkWell(
              onTap: onTap == null
                  ? null
                  : () {
                      onTap();
                    },
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                // width: double.infinity,
                height: size.height * 0.06,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: purpleLinearGradient,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(text.toUpperCase(),
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          )),
    );
  }
}

class InnerShadow extends SingleChildRenderObjectWidget {
  InnerShadow({
    required Widget child,
    String key = "",
    this.blur = 4,
    this.color = Colors.black38,
    this.offset = const Offset(10, 10),
  }) : super(key: Key(key), child: child);

  final double blur;
  final Color color;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final _RenderInnerShadow renderObject = _RenderInnerShadow();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderInnerShadow renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  late double blur;
  late Color color;
  late double dx;
  late double dy;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final Rect rectOuter = offset & size;
    final Rect rectInner = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width - dx,
      size.height - dy,
    );
    final Canvas canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(child!, offset);
    final Paint shadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur, sigmaY: blur)
      ..colorFilter = ColorFilter.mode(color, BlendMode.srcOut);

    canvas
      ..saveLayer(rectOuter, shadowPaint)
      ..saveLayer(rectInner, Paint())
      ..translate(dx, dy);
    context.paintChild(child!, offset);
    context.canvas
      ..restore()
      ..restore()
      ..restore();
  }
}
