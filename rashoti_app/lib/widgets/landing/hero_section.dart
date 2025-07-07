import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppGradients.heroGradient,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 20,
          vertical: isDesktop ? 100 : 60,
        ),
        child: isDesktop
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left side - Text content
        Expanded(
          flex: 3,
          child: _buildTextContent(context, isDesktop: true),
        ),

        const SizedBox(width: 60),

        // Right side - AI Robot illustration
        Expanded(
          flex: 2,
          child: _buildRobotIllustration(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTextContent(context, isDesktop: false),
        const SizedBox(height: 40),
        _buildRobotIllustration(),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main Heading
        RichText(
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: isDesktop ? 56 : 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
            children: [
              const TextSpan(text: 'Smarter Learning,\n'),
              const TextSpan(text: 'Powered by '),
              TextSpan(
                text: 'AI',
                style: TextStyle(
                  color: AppColors.primary,
                  backgroundColor: AppColors.textPrimary.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Description
        Text(
          AppConstants.appDescription,
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 40),

        // User Type Buttons
        isDesktop
            ? _buildDesktopButtons(context)
            : _buildMobileButtons(context),
      ],
    );
  }

  Widget _buildDesktopButtons(BuildContext context) {
    return Row(
      children: [
        _buildUserTypeButton(
          'Student',
          AppColors.primary,
              () => context.go('${AppConstants.registerRoute}?type=student'),
        ),
        const SizedBox(width: 16),
        _buildUserTypeButton(
          'Teacher',
          AppColors.accent,
              () => context.go('${AppConstants.registerRoute}?type=teacher'),
        ),
        const SizedBox(width: 16),
        _buildUserTypeButton(
          'Parent',
          AppColors.secondary,
              () => context.go('${AppConstants.registerRoute}?type=parent'),
        ),
      ],
    );
  }

  Widget _buildMobileButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: _buildUserTypeButton(
            'Student',
            AppColors.primary,
                () => context.go('${AppConstants.registerRoute}?type=student'),
            fullWidth: true,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: _buildUserTypeButton(
            'Teacher',
            AppColors.accent,
                () => context.go('${AppConstants.registerRoute}?type=teacher'),
            fullWidth: true,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: _buildUserTypeButton(
            'Parent',
            AppColors.secondary,
                () => context.go('${AppConstants.registerRoute}?type=parent'),
            fullWidth: true,
          ),
        ),
      ],
    );
  }

  Widget _buildUserTypeButton(
      String title,
      Color color,
      VoidCallback onPressed, {
        bool fullWidth = false,
      }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: fullWidth ? 24 : 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRobotIllustration() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow effect
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.secondary.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // AI Robot (placeholder - you can replace with your actual robot image)
          Container(
            width: 250,
            height: 300,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.secondary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Robot Head
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.android,
                    color: Colors.white,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 16),

                // Robot Body
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.auto_stories,
                    color: Colors.white,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 16),

                // Reading Text
                const Text(
                  '📖 Learning...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Floating elements
          Positioned(
            top: 50,
            right: 50,
            child: _buildFloatingIcon(Icons.lightbulb, AppColors.warning),
          ),
          Positioned(
            bottom: 50,
            left: 50,
            child: _buildFloatingIcon(Icons.psychology, AppColors.primary),
          ),
          Positioned(
            top: 100,
            left: 30,
            child: _buildFloatingIcon(Icons.school, AppColors.accent),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }
}
