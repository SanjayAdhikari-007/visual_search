import 'package:flutter/material.dart';

class FlickeringOpacity extends StatefulWidget {
  /// The widget whose opacity will be animated.
  final Widget child;

  /// The duration for one complete cycle of the animation (high to low and back to high).
  final Duration duration;

  /// The starting opacity value (usually 1.0 for fully visible).
  final double beginOpacity;

  /// The ending opacity value (e.g., 0.2 for partially transparent, 0.0 for fully transparent).
  final double endOpacity;

  const FlickeringOpacity({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2), // Default duration
    this.beginOpacity = 1.0, // Default start opacity
    this.endOpacity = 0.2, // Default end opacity
  })  : assert(beginOpacity >= 0.0 && beginOpacity <= 1.0),
        assert(endOpacity >= 0.0 && endOpacity <= 1.0);

  @override
  State<FlickeringOpacity> createState() => _FlickeringOpacityState();
}

class _FlickeringOpacityState extends State<FlickeringOpacity>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation in reverse

    _animation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant FlickeringOpacity oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If duration, beginOpacity, or endOpacity changes, update the controller/animation
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat(reverse: true);
    }
    if (widget.beginOpacity != oldWidget.beginOpacity ||
        widget.endOpacity != oldWidget.endOpacity) {
      _animation = Tween<double>(
        begin: widget.beginOpacity,
        end: widget.endOpacity,
      ).animate(_controller);
      // Ensure the animation updates if the tween values change while running
      _controller.forward(from: _controller.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: child, // Use the child passed to AnimatedBuilder
        );
      },
      child:
          widget.child, // Pass the FlickeringOpacity's child to AnimatedBuilder
    );
  }
}
