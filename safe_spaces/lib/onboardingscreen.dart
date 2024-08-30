import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _buildPage(
            context,
            'Welcome to the Crime Reporting and Community Safety App',
          ),
          _buildPage(
            context,
            'Feature 1: Anonymously Report Crimes',
          ),
          _buildPage(
            context,
            'Feature 2: Real-Time Updates and Notifications',
          ),
          _buildPage(
            context,
            'Feature 3: Community Safety Insights (Heatmaps, etc.)',
          ),
          _buildLastPage(context),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLastPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Get Started',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the authentication screen
              Navigator.pushReplacementNamed(context, '/auth');
            },
            child: Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
