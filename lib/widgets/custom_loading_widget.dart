import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatefulWidget {
  final String loadingText;

  const CustomLoadingWidget({
    Key? key,
    this.loadingText = "Loading ...",
  }) : super(key: key);

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Background fill only (no lighter squares)
  Widget _buildBackgroundGrid(BuildContext context) {
    final Color base = const Color(0xFFDEFF48); // main neon yellow-green
    return Container(color: base);
  }

  Widget _buildAnimatedLoader(BuildContext context) {
    final Color base = const Color(0xFFDEFF48);
    final Color progressBg = const Color(0xFFE9E100);
    final Color progressFg = Colors.black;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Animate the black bar width for shimmer effect
        final double maxBarWidth = 46.0;
        final double minBarWidth = 20.0;
        final double barWidth = minBarWidth +
            (maxBarWidth - minBarWidth) *
                (0.5 - 0.5 *
                    ((1 +
                        -1 *
                            ((_controller.value > 0.5
                                    ? 1 - _controller.value
                                    : _controller.value) *
                                2))));

        // Animate yellow dots for a subtle up/down movement
        final double dotOffset = 4 * (0.5 - (0.5 - _controller.value).abs());

        return Container(
          width: 170,
          height: 50,
          decoration: BoxDecoration(
            color: progressBg,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: base.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, -dotOffset),
                child: Container(
                  width: 18,
                  height: 10,
                  decoration: BoxDecoration(
                    color: base,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                ),
              ),
              Transform.translate(
                offset: Offset(0, dotOffset),
                child: Container(
                  width: 18,
                  height: 10,
                  decoration: BoxDecoration(
                    color: base,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                ),
              ),
              // Animated black bar (progress)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: barWidth,
                height: 10,
                decoration: BoxDecoration(
                  color: progressFg,
                  borderRadius: BorderRadius.circular(6),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color base = const Color(0xFFDEFF48);
    final Color circleBg = const Color(0xFFB8DA53);

    return Stack(
      children: [
        _buildBackgroundGrid(context),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Center circular loader
            Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: circleBg.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: base.withOpacity(0.25),
                      blurRadius: 60,
                      spreadRadius: 20,
                    )
                  ],
                ),
                child: Center(
                  child: _buildAnimatedLoader(context),
                ),
              ),
            ),
            const Spacer(),
            // Loading text
            Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: Text(
                widget.loadingText,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}