import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: isDesktop ? 100 : 60,
      ),
      color: AppColors.lightBackground,
      child: Column(
        children: [
          // Section Header
          Text(
            'Why Choose Rashoti?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 48 : 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 60),

          // Features Grid
          isDesktop
              ? _buildDesktopGrid()
              : _buildMobileGrid(),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildFeatureCard(
            'Adaptive AI Engine',
            'Learning paths that evolve with each student\'s progress.',
            Icons.psychology_outlined,
            AppColors.primary,
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _buildFeatureCard(
            'Real-Time Performance Tracking',
            'Dashboards for students, teachers, and parents.',
            Icons.analytics_outlined,
            AppColors.secondary,
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _buildFeatureCard(
            'Gamified Learning Modules',
            'Boost motivation through badges, XP, and leaderboards.',
            Icons.videogame_asset_outlined,
            AppColors.accent,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileGrid() {
    return Column(
      children: [
        _buildFeatureCard(
          'Adaptive AI Engine',
          'Learning paths that evolve with each student\'s progress.',
          Icons.psychology_outlined,
          AppColors.primary,
        ),
        const SizedBox(height: 24),
        _buildFeatureCard(
          'Real-Time Performance Tracking',
          'Dashboards for students, teachers, and parents.',
          Icons.analytics_outlined,
          AppColors.secondary,
        ),
        const SizedBox(height: 24),
        _buildFeatureCard(
          'Gamified Learning Modules',
          'Boost motivation through badges, XP, and leaderboards.',
          Icons.videogame_asset_outlined,
          AppColors.accent,
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
      String title,
      String description,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),

          const SizedBox(height: 24),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}