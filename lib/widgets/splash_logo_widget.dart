import 'package:flutter/material.dart';

class SplashLogoWidget extends StatefulWidget {
  const SplashLogoWidget({super.key});

  @override
  State<SplashLogoWidget> createState() => _SplashLogoWidgetState();
}

class _SplashLogoWidgetState extends State<SplashLogoWidget>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _truckController;
  late final AnimationController _pulseController;
  late final AnimationController _routeController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _truckAnimation;
  late final Animation<double> _textOpacity;
  late final Animation<double> _subtitleOpacity;
  late final Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Main entrance animation
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // Truck movement
    _truckController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // Glow pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    // Moving route lines
    _routeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    // Logo scale
    _logoScale = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.00, 0.40, curve: Curves.easeOutBack),
    );

    // Logo opacity
    _logoOpacity = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.00, 0.25, curve: Curves.easeOut),
    );

    // Truck movement
    _truckAnimation = CurvedAnimation(
      parent: _truckController,
      curve: Curves.easeInOutCubic,
    );

    // Main title
    _textOpacity = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
    );

    // Subtitle
    _subtitleOpacity = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.55, 0.82, curve: Curves.easeOut),
    );

    // Progress
    _progressAnimation = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.65, 1.00, curve: Curves.easeInOut),
    );

    _mainController.forward();
    _truckController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _truckController.dispose();
    _pulseController.dispose();
    _routeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF050B16);
    const cardBg = Color(0xFF101B30);
    const cyan = Color(0xFF00D4FF);
    const cyanDark = Color(0xFF008FB3);

    return Scaffold(
      backgroundColor: background,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _mainController,
          _truckController,
          _pulseController,
          _routeController,
        ]),
        builder: (context, child) {
          final pulse = 0.75 + (_pulseController.value * 0.25);

          return Stack(
            children: [
              // ============================================================
              // BACKGROUND
              // ============================================================
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.15,
                    colors: [
                      Color(0xFF0B1E35),
                      Color(0xFF07101F),
                      Color(0xFF050B16),
                    ],
                    stops: [0.0, 0.55, 1.0],
                  ),
                ),
              ),

              // ============================================================
              // BACKGROUND GRID
              // ============================================================
              Positioned.fill(
                child: CustomPaint(
                  painter: _GridPainter(animationValue: _routeController.value),
                ),
              ),

              // ============================================================
              // LOGISTICS ROUTES
              // ============================================================
              Positioned.fill(
                child: CustomPaint(
                  painter: _RoutePainter(
                    animationValue: _routeController.value,
                  ),
                ),
              ),

              // ============================================================
              // TOP BRAND MARK
              // ============================================================
              Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: _logoOpacity.value,
                  child: Transform.scale(
                    scale: 0.85 + (_logoScale.value * 0.15),
                    child: const Center(child: _BrandMark()),
                  ),
                ),
              ),

              // ============================================================
              // MAIN LOGO
              // ============================================================
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -45),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Glow behind logo
                      Transform.scale(
                        scale: 0.75 + (_logoScale.value * 0.25),
                        child: Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: cyan.withOpacity(0.12 * pulse),
                                blurRadius: 80,
                                spreadRadius: 25,
                              ),
                              BoxShadow(
                                color: cyan.withOpacity(0.08),
                                blurRadius: 35,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Transform.translate(
                        offset: const Offset(0, -190),
                        child: Opacity(
                          opacity: _logoOpacity.value,
                          child: Transform.scale(
                            scale: 0.65 + (_logoScale.value * 0.35),
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(38),
                                border: Border.all(
                                  color: cyan.withOpacity(0.8),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: cyan.withOpacity(0.22 * pulse),
                                    blurRadius: 35,
                                    spreadRadius: 4,
                                  ),
                                  const BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 25,
                                    offset: Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Inner ring
                                  Container(
                                    width: 112,
                                    height: 112,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: cyan.withOpacity(0.12),
                                        width: 1,
                                      ),
                                    ),
                                  ),

                                  // Truck
                                  Transform.translate(
                                    offset: Offset(
                                      (_truckAnimation.value * 24) - 12,
                                      0,
                                    ),
                                    child: Icon(
                                      Icons.local_shipping_rounded,
                                      size: 62,
                                      color: cyan.withOpacity(0.95),
                                    ),
                                  ),

                                  // Small route dots
                                  Positioned(
                                    bottom: 24,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        3,
                                        (index) => Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 3,
                                          ),
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: cyan.withOpacity(
                                              index == 1 ? 0.9 : 0.3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ======================================================
                      // A2I LOGISTICS TEXT
                      // ======================================================
                      Opacity(
                        opacity: _textOpacity.value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - _textOpacity.value)),
                          child: Column(
                            children: [
                              const Text(
                                'A2I',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 8,
                                  height: 1,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 25,
                                    height: 1,
                                    color: cyan.withOpacity(0.7),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'LOGISTICS',
                                    style: TextStyle(
                                      color: cyan,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 25,
                                    height: 1,
                                    color: cyan.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // ======================================================
                      // SUBTITLE
                      // ======================================================
                      Opacity(
                        opacity: _subtitleOpacity.value,
                        child: Transform.translate(
                          offset: Offset(0, 12 * (1 - _subtitleOpacity.value)),
                          child: const Text(
                            'SMART LOGISTICS • CONNECTED WORLD',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ============================================================
              // BOTTOM LOADING
              // ============================================================
              Positioned(
                left: 45,
                right: 45,
                bottom: 65,
                child: Opacity(
                  opacity: _subtitleOpacity.value,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'INITIALIZING SYSTEM',
                            style: TextStyle(
                              color: Colors.white30,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            '${(_progressAnimation.value * 100).toInt()}%',
                            style: const TextStyle(
                              color: cyan,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 9),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 3,
                          color: Colors.white.withOpacity(0.06),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _progressAnimation.value,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [cyanDark, cyan],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: cyan.withOpacity(0.7),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ============================================================
              // VERSION
              // ============================================================
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: _subtitleOpacity.value * 0.7,
                  child: const Center(
                    child: Text(
                      'A2I • LOGISTICS PLATFORM',
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 8,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ============================================================================
// BRAND MARK
// ============================================================================

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF00D4FF),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'A2I',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// GRID PAINTER
// ============================================================================

class _GridPainter extends CustomPainter {
  final double animationValue;

  _GridPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.018)
      ..strokeWidth = 1;

    const spacing = 45.0;

    final offset = (animationValue * spacing);

    for (double x = -spacing + offset; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = -spacing + offset; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// ============================================================================
// LOGISTICS ROUTE PAINTER
// ============================================================================

class _RoutePainter extends CustomPainter {
  final double animationValue;

  _RoutePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFF00D4FF).withOpacity(0.10);

    // Left route
    final leftPath = Path();

    leftPath.moveTo(-30, size.height * 0.28);

    leftPath.cubicTo(
      size.width * 0.12,
      size.height * 0.20,
      size.width * 0.18,
      size.height * 0.38,
      size.width * 0.32,
      size.height * 0.32,
    );

    leftPath.cubicTo(
      size.width * 0.40,
      size.height * 0.29,
      size.width * 0.43,
      size.height * 0.42,
      size.width * 0.50,
      size.height * 0.40,
    );

    canvas.drawPath(leftPath, paint);

    // Right route
    final rightPath = Path();

    rightPath.moveTo(size.width + 30, size.height * 0.70);

    rightPath.cubicTo(
      size.width * 0.88,
      size.height * 0.62,
      size.width * 0.80,
      size.height * 0.78,
      size.width * 0.68,
      size.height * 0.70,
    );

    rightPath.cubicTo(
      size.width * 0.60,
      size.height * 0.64,
      size.width * 0.56,
      size.height * 0.75,
      size.width * 0.48,
      size.height * 0.72,
    );

    canvas.drawPath(rightPath, paint);

    // Moving route points
    final pointPaint = Paint()
      ..color = const Color(0xFF00D4FF).withOpacity(0.55);

    final pointX =
        (size.width * animationValue * 1.4) % (size.width + 100) - 50;

    canvas.drawCircle(Offset(pointX, size.height * 0.32), 2.5, pointPaint);

    final pointX2 =
        (size.width * (1 - animationValue) * 1.3) % (size.width + 100) - 50;

    canvas.drawCircle(Offset(pointX2, size.height * 0.70), 2, pointPaint);

    // Small location nodes
    _drawNode(canvas, Offset(size.width * 0.13, size.height * 0.22));

    _drawNode(canvas, Offset(size.width * 0.86, size.height * 0.76));

    _drawNode(canvas, Offset(size.width * 0.78, size.height * 0.18));
  }

  void _drawNode(Canvas canvas, Offset position) {
    final outer = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF00D4FF).withOpacity(0.25);

    final inner = Paint()..color = const Color(0xFF00D4FF).withOpacity(0.65);

    canvas.drawCircle(position, 6, outer);
    canvas.drawCircle(position, 2, inner);
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
