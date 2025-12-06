import 'dart:async';
import 'package:flutter/material.dart';

class AutoTextCarousel extends StatefulWidget {
  final List<String> items;
  final String titulo;
  final IconData icono;
  final Color color;

  const AutoTextCarousel({
    super.key,
    required this.items,
    required this.titulo,
    required this.icono,
    required this.color,
  });

  @override
  State<AutoTextCarousel> createState() => _AutoTextCarouselState();
}

class _AutoTextCarouselState extends State<AutoTextCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_controller.hasClients) {
        final nextPage = (_currentPage + 1) % widget.items.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPage = nextPage);
      }
    });
  }

  void _goToPage(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = index);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(widget.icono, color: widget.color),
              const SizedBox(width: 8),
              Text(
                widget.titulo,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: widget.items.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: widget.color),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.items[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final prev = (_currentPage - 1 + widget.items.length) % widget.items.length;
                    _goToPage(prev);
                  },
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final next = (_currentPage + 1) % widget.items.length;
                    _goToPage(next);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}