import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart' show kBorderRadius, kFontSemiBold;
import 'package:zoncan/core/common/common.dart' show GroupBox;

class ZSlider extends StatefulWidget {
  final List<ZSlide> slides;
  const ZSlider({super.key, required this.slides});

  @override
  _ZSliderState createState() => _ZSliderState();
}

class _ZSliderState extends State<ZSlider> {
  @override
  Widget build(BuildContext context) {
    return GroupBox(
      color: Colors.transparent,
      child: CarouselSlider.builder(
        itemCount: widget.slides.length,
        options: CarouselOptions(
          disableCenter: true,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: widget.slides.length > 1,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6),
          autoPlayCurve: Curves.ease,
          scrollDirection: Axis.horizontal,
        ),
        itemBuilder: (context, i, ii) {
          return Container(child: widget.slides[i]);
        },
      ),
    );
  }
}

class ZSlide extends StatefulWidget {
  final ImageProvider<Object> image;
  final String? title;
  final String? description;
  const ZSlide({super.key, this.title, this.description, required this.image});

  @override
  _ZSlideState createState() => _ZSlideState();
}

bool _isFullTextContent = false;
IconData _isFullContentIcon = Icons.keyboard_arrow_up;

class _ZSlideState extends State<ZSlide> {
  final Color _randomColor = Color(
    (Random().nextDouble() * 0xFFFFFF).toInt(),
  ).withOpacity(0.5).withAlpha(150);

  void _updateSlide() {
    setState(() {
      if (_isFullTextContent) {
        _isFullContentIcon = Icons.keyboard_arrow_up;
        _isFullTextContent = false;
      } else {
        _isFullContentIcon = Icons.keyboard_arrow_down;
        _isFullTextContent = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.image,
          fit: BoxFit.fitWidth,
          alignment: Alignment.center,
        ),
      ),
      child:
          widget.title != null && widget.description != null
              ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: _isFullTextContent ? 2 : 6,
                    child: Container(),
                  ),
                  Expanded(
                    flex: _isFullTextContent ? 6 : 2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Theme.of(context).shadowColor.withOpacity(0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 25.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kBorderRadius),
                              ),
                              child: Container(
                                width: 10.0,
                                color: _randomColor,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title!,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge?.copyWith(
                                        inherit: true,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                        fontWeight: kFontSemiBold,
                                      ),
                                    ),
                                    const SizedBox(width: 180),
                                    TextButton(
                                      child: Icon(
                                        _isFullContentIcon,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                      ),
                                      onPressed: () {
                                        _updateSlide();
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 10.0,
                                  ),
                                  child: RichText(
                                    maxLines: _isFullTextContent ? 100 : 4,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      text: widget.description,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        inherit: true,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : Container(),
    );
  }
}
