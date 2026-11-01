
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProductImageSlider extends StatefulWidget {
  final List<String> images;
  final double height;

  const ProductImageSlider({
    super.key,
    required this.images,
    this.height = 300,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;

  @override
  void didUpdateWidget(covariant ProductImageSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.images != oldWidget.images) {
      _currentIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return  SizedBox(
        height: widget.height,
        child: Center(
          child: Icon(Icons.image_not_supported_outlined, size: 48),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
       height: widget.height,
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.images[index],
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == _currentIndex
                    ? const Color(0xFF40BFFF)
                    : const Color(0xFF9098B1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
