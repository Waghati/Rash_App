import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          _buildLogo(),

          const Spacer(),

          // Navigation Menu
          if (isDesktop) Flexible(child: _buildDesktopMenu(context)),
          if (!isDesktop) _buildMobileMenu(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        // Logo Icon (simplified version of your design)
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary],
            ),
          ),
          child: const Icon(
            Icons.psychology_alt,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Rashoti',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopMenu(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 0,
      runSpacing: 8,
      children: [
        _buildNavButton('Home', () {}),
        _buildNavButton('Features', () {}),
        _buildNavButton('Curriculum', () {}),
        _buildNavButton('Pricing', () {}),
        _buildNavButton('Contact', () {}),

        const SizedBox(width: 20),

        // Register Button
        ElevatedButton(
          onPressed: () => _showUserTypeDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Register',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: AppColors.textPrimary),
      onSelected: (value) {
        if (value == 'register') {
          _showUserTypeDialog(context);
        }
      },
      itemBuilder:
          (context) => [
            const PopupMenuItem(value: 'home', child: Text('Home')),
            const PopupMenuItem(value: 'features', child: Text('Features')),
            const PopupMenuItem(value: 'curriculum', child: Text('Curriculum')),
            const PopupMenuItem(value: 'pricing', child: Text('Pricing')),
            const PopupMenuItem(value: 'contact', child: Text('Contact')),
            const PopupMenuDivider(),
            const PopupMenuItem(value: 'register', child: Text('Register')),
          ],
    );
  }

  Widget _buildNavButton(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  void _showUserTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Choose Your Role',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Select how you\'ll be using Rashoti',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildUserTypeCard(
                    context,
                    'Student',
                    'Access courses, take quizzes, and track your learning progress',
                    Icons.school,
                    AppColors.primary,
                    'student',
                  ),

                  const SizedBox(height: 16),

                  _buildUserTypeCard(
                    context,
                    'Teacher',
                    'Manage classes, create assignments, and monitor student progress',
                    Icons.person_2,
                    AppColors.accent,
                    'teacher',
                  ),

                  const SizedBox(height: 16),

                  _buildUserTypeCard(
                    context,
                    'Parent',
                    'Track your children\'s progress and communicate with teachers',
                    Icons.family_restroom,
                    AppColors.secondary,
                    'parent',
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildUserTypeCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String userType,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.go('${AppConstants.registerRoute}?type=$userType');
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
