import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the view model from the Provider
    final viewModel = Provider.of<DashboardViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco-Pilot Dashboard'),
        actions: [
          // Simple refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // In a real app, you'd call viewModel.fetchData() here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. The "Future-Pace Projection" Card
              _buildProjectionCard(viewModel),
              const SizedBox(height: 24),

              // 2. The "Effortless Data Capture" Section
              _buildDataEntrySection(context, viewModel),
              const SizedBox(height: 24),

              // 3. The "Eco-Micro-Grants" Card
              _buildEcoCreditsCard(context, viewModel),
              const SizedBox(height: 24),

              // 4. The "Micro-Challenges" Section
              _buildChallengesSection(context, viewModel),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET BUILDER METHODS ---

  Widget _buildProjectionCard(DashboardViewModel viewModel) {
    return Card(
      elevation: 4,
      color: Colors.green[800],
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Your 30-Day Projected CO2',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '${viewModel.projectedCo2.toStringAsFixed(1)} kg',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "This is your 'Future-Pace'. Log actions to lower it in real-time.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataEntrySection(BuildContext context, DashboardViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Log Your Actions',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        // Using a simple Row for the 3 main buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogButton(
              context: context,
              icon: Icons.directions_car,
              label: 'Travel',
              color: Colors.blue,
              onPressed: () {
                // Dummy action: log a 5kg CO2 trip
                viewModel.logTravel(5.0);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged dummy travel (5.0 kg CO2)'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
            _buildLogButton(
              context: context,
              icon: Icons.restaurant,
              label: 'Food',
              color: Colors.orange,
              onPressed: () {
                // Dummy action: log a 2kg CO2 meal
                viewModel.logFood(2.0);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged dummy food (2.0 kg CO2)'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            ),
            _buildLogButton(
              context: context,
              icon: Icons.power,
              label: 'Energy',
              color: Colors.purple,
              onPressed: () {
                // Dummy action: log 1kg CO2 energy use
                viewModel.logEnergy(1.0);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged dummy energy (1.0 kg CO2)'),
                    backgroundColor: Colors.purple,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton.icon(
          icon: Icon(icon, size: 20),
          label: Text(label, style: const TextStyle(fontSize: 12)),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEcoCreditsCard(BuildContext context, DashboardViewModel viewModel) {
    return Card(
      elevation: 4,
      color: Colors.amber[700],
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Eco-Credits',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Text(
                  '${viewModel.ecoCredits}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.redeemReward('Dummy Reward');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Redeemed "₹50 Voucher" (Dummy)'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('Redeem'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesSection(BuildContext context, DashboardViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your Micro-Challenges',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                // --- THIS IS THE FIX ---
                // We are now mapping over a List<String>
                // So we just display the string in a simple ListTile
                ...viewModel.challenges.map((challenge) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.amber[800],
                    ),
                    title: Text(
                      challenge, // We just use the string directly
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      // In the future, this could open a detail page
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

