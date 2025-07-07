import 'package:flutter/material.dart';
import '../../widgets/landing/hero_section.dart';
import '../../widgets/landing/features_section.dart';
import '../../widgets/landing/placeholder_sections.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../utils/colors.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 80,
            floating: true,
            pinned: true,
            backgroundColor: Colors.white.withOpacity(0.95),
            elevation: 0,
            flexibleSpace: const CustomAppBar(),
          ),

          // Main Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Hero Section with AI Robot
              const HeroSection(),

              // Why Choose Rashoti - Features
              const FeaturesSection(),

              // Curriculum Coverage
              const CurriculumSection(),

              // Testimonials
              const TestimonialsSection(),

              // Pricing Plans
              const PricingSection(),

              // Contact Form
              const ContactSection(),

              // Footer
              _buildFooter(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: AppColors.textPrimary,
      child: const Text(
        'Copyright 2025 Rashoti Technologies. All right Reserved. | Securing Africa\'s Future Through Innovation',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}