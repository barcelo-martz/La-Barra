import 'dart:async';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _controller = PageController();
  int _current = 0;
  Timer? _timer;

  final List<String> images = const [
    'assets/images/carrusel1.jpeg',
    'assets/images/carrusel2.jpeg',
    'assets/images/carrusel3.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    // Avanza automáticamente cada 3 segundos
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_current + 1) % images.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

 // ... el initState y dispose quedan igual

@override
Widget build(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: 260,   // ← más grande, como en tu diseño
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => Image.asset(
              images[i],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          images.length,
          (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _current == i ? 14 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _current == i ? const Color(0xFFE53935) : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    ],
  );
}
}