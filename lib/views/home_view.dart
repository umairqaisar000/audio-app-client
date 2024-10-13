import 'package:audio_app/providers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userNotifierProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 1.0 * 3.141592653589793,
                child: child,
              );
            },
            child: SvgPicture.asset(
              './assets/images/app-icon.svg',
              color: const Color(0xFF03DAC6),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          const SizedBox(height: 16), // Space between the SVG and text
          if (user != null) ...[
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8), // Space between the name and ID
            Text(
              '#${user.id}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
