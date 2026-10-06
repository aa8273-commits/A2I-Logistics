import 'package:flutter/material.dart';

class OsHeroCardWidget extends StatefulWidget {
  final VoidCallback onGetStarted;

  const OsHeroCardWidget({super.key, required this.onGetStarted});

  @override
  State<OsHeroCardWidget> createState() => _OsHeroCardWidgetState();
}

class _OsHeroCardWidgetState extends State<OsHeroCardWidget>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;

  int currentPage = 0;

  final List<OnboardingData> pages = [
    OnboardingData(
      icon: Icons.local_shipping_rounded,
      smallTitle: 'SMART SHIPPING',
      title: 'Move Smarter.\nDeliver Faster.',
      description:
          'Manage your shipments easily with powerful logistics tools designed to make every delivery simple.',
    ),
    OnboardingData(
      icon: Icons.location_on_rounded,
      smallTitle: 'REAL-TIME TRACKING',
      title: 'Your Cargo.\nAlways in Sight.',
      description:
          'Track your shipments and know exactly where your cargo is at every step of the journey.',
    ),
    OnboardingData(
      icon: Icons.hub_rounded,
      smallTitle: 'CONNECTED LOGISTICS',
      title: 'One Platform.\nEverything Connected.',
      description:
          'Connect customers, drivers and logistics operations through one powerful platform.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onGetStarted();
    }
  }

  void skip() {
    _pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });

    _animationController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080E1E),
      body: SafeArea(
        child: Column(
          children: [
            // ==========================================================
            // TOP BAR
            // ==========================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: Row(
                children: [
                  // LOGO
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFF131D33),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: const Color(0xFF00B4D8),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.local_shipping_rounded,
                          color: Color(0xFF00B4D8),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'A2I',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // SKIP
                  if (currentPage < pages.length - 1)
                    GestureDetector(
                      onTap: skip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ==========================================================
            // PAGES
            // ==========================================================
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final animation = Curves.easeOutCubic.transform(
                        _animationController.value,
                      );

                      return Opacity(
                        opacity: animation,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - animation)),
                          child: child,
                        ),
                      );
                    },
                    child: _buildPage(pages[index]),
                  );
                },
              ),
            ),

            // ==========================================================
            // BOTTOM
            // ==========================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 25),
              child: Column(
                children: [
                  // ----------------------------------------------------
                  // INDICATORS
                  // ----------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(pages.length, (index) {
                      final isSelected = currentPage == index;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isSelected ? 28 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00B4D8)
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 22),

                  // ----------------------------------------------------
                  // BUTTON
                  // ----------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B4D8),
                        foregroundColor: Colors.black,
                        elevation: 8,
                        shadowColor: const Color(0xFF00B4D8).withOpacity(0.35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentPage == pages.length - 1
                                ? 'Get Started'
                                : 'Continue',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_rounded, size: 21),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // PAGE NUMBER
                  Text(
                    '${currentPage + 1} / ${pages.length}',
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // PAGE DESIGN
  // ==========================================================================

  Widget _buildPage(OnboardingData data) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // ==========================================================
            // BIG VISUAL
            // ==========================================================
            Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00B4D8).withOpacity(0.20),
                    const Color(0xFF00B4D8).withOpacity(0.04),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // OUTER RING
                  Container(
                    width: 215,
                    height: 215,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF00B4D8).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                  ),

                  // MIDDLE RING
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF00B4D8).withOpacity(0.10),
                        width: 1,
                      ),
                    ),
                  ),

                  // MAIN CARD
                  Container(
                    width: 135,
                    height: 135,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131D33),
                      borderRadius: BorderRadius.circular(38),
                      border: Border.all(
                        color: const Color(0xFF00B4D8).withOpacity(0.6),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00B4D8).withOpacity(0.20),
                          blurRadius: 35,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      data.icon,
                      size: 65,
                      color: const Color(0xFF00D4FF),
                    ),
                  ),

                  // SMALL DOTS
                  Positioned(top: 35, right: 42, child: _dot()),

                  Positioned(bottom: 40, left: 35, child: _dot()),

                  Positioned(top: 75, left: 24, child: _dot()),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ==========================================================
            // SMALL TITLE
            // ==========================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 20, height: 2, color: const Color(0xFF00B4D8)),
                const SizedBox(width: 8),
                Text(
                  data.smallTitle,
                  style: const TextStyle(
                    color: Color(0xFF00B4D8),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 8),
                Container(width: 20, height: 2, color: const Color(0xFF00B4D8)),
              ],
            ),

            const SizedBox(height: 12),

            // ==========================================================
            // TITLE
            // ==========================================================
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                height: 1.12,
              ),
            ),

            const SizedBox(height: 12),

            // ==========================================================
            // DESCRIPTION
            // ==========================================================
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF00B4D8),
        boxShadow: [BoxShadow(color: Color(0x6600B4D8), blurRadius: 10)],
      ),
    );
  }
}

// ============================================================================
// DATA
// ============================================================================

class OnboardingData {
  final IconData icon;
  final String smallTitle;
  final String title;
  final String description;

  OnboardingData({
    required this.icon,
    required this.smallTitle,
    required this.title,
    required this.description,
  });
}
