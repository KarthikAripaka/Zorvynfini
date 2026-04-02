// ─── lib/features/onboarding/onboarding_screen.dart ───
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    hide ScaleEffect;
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/extensions.dart';
import '../../core/providers/settings_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  int _currentPage = 0;
  bool _isOnboardingComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: [
              _buildWelcomePage(),
              _buildFeaturesPage(),
              _buildIncomePage(),
            ],
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Animate(
            effects: const [
              FadeEffect(delay: Duration(milliseconds: 200)),
              ScaleEffect()
            ],
            child: Icon(
              Icons.trending_up,
              size: 120,
              color: Theme.of(context).colorScheme.primary,
            ),
          ).animate().slideY(begin: 0.2),
          const Gap(32),
          Text(
            'Finia',
            style: AppTextStyles.displayLarge.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
              .animate()
              .slideY(begin: 0.3, delay: const Duration(milliseconds: 200)),
          const Gap(16),
          const Text(
            'Your Personal Finance Companion',
            style: AppTextStyles.headlineMedium,
            textAlign: TextAlign.center,
          )
              .animate()
              .slideY(begin: 0.3, delay: const Duration(milliseconds: 400)),
          const Gap(48),
          const Text(
            'Track spending, set goals, gain insights.\nEverything offline, beautifully designed.',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesPage() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Everything you need',
            style: AppTextStyles.headlineLarge,
          ),
          const Gap(48),
          _buildFeatureItem(Icons.analytics, 'Smart Insights'),
          const Gap(24),
          _buildFeatureItem(Icons.flag, 'Goals & Challenges'),
          const Gap(24),
          _buildFeatureItem(Icons.receipt_long, 'Transaction Tracking'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon,
              color: Theme.of(context).colorScheme.primary, size: 24),
        ),
        const Gap(16),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.headlineSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildIncomePage() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Gap(64),
          Animate(
            effects: const [FadeEffect()],
            child: const Text(
              'Let\'s get started',
              style: AppTextStyles.headlineLarge,
            ),
          ),
          const Gap(16),
          const Text(
            'Enter your name and starting balance',
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Gap(32),
          // Name input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
            ),
            child: TextField(
              controller: _nameController,
              style: AppTextStyles.bodyLarge,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your name',
                hintStyle: AppTextStyles.bodyLarge.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const Gap(20),
          // Balance input
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity10,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '\u20B9',
                  style: AppTextStyles.displayMedium.copyWith(fontSize: 48),
                ),
                const Gap(8),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: _incomeController,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.amountLarge,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle: AppTextStyles.amountLarge.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 32,
      left: 32,
      right: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: Text(
                'Back',
                style: AppTextStyles.bodyMedium.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            )
          else
            const SizedBox(width: 72),
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(
              dotColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 12,
            ),
          ),
          ElevatedButton(
            onPressed: _isOnboardingComplete ? null : () => _handleNext(),
            child: Text(
              _currentPage == 2 ? 'Get Started' : 'Next',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleNext() async {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() => _isOnboardingComplete = true);

      final income = double.tryParse(_incomeController.text) ?? 50000.0;
      final name =
          _nameController.text.trim().isEmpty ? 'User' : _nameController.text.trim();

      // Save onboarding state with name and balance
      await ref.read(settingsProvider.notifier).completeOnboarding(
            monthlyIncome: income,
            balance: income,
            userName: name,
          );

      // Navigate to dashboard
      if (mounted && context.mounted) {
        context.go('/');
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _incomeController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
