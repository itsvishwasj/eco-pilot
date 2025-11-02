// This ViewModel now calls the FirebaseService to log real data.
import 'package:flutter/foundation.dart';
import 'firebase_service.dart'; // We now use this

class DashboardViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  // --- Mock Data (from your PPT plan) ---
  // This data will be used for the UI until we build the "Logic Focus" step
  double _projectedCo2 = 150.0;
  int _ecoCredits = 42;
  final List<String> _challenges = [
    "Log 3 'Travel' actions",
    "Try one 'Meat-Free' day",
  ];

  // --- Getters for the UI ---
  double get projectedCo2 => _projectedCo2;
  int get ecoCredits => _ecoCredits;
  List<String> get challenges => _challenges;

  // We add an `init` method to sign the user in when the app starts.
  DashboardViewModel() {
    _init();
  }

  void _init() async {
    await _firebaseService.signInAnonymously();
    notifyListeners(); // Update UI just in case
  }

  // --- LOGIC METHODS ---
  // These functions now call FirebaseService to save real data.

  void logTravel(double co2) {
    _firebaseService.addEmissionEntry(type: 'travel', co2: co2);
    
    // --- Mock UI update (for now) ---
    // In the "Logic Focus" step, this will come from real calculations.
    _projectedCo2 -= co2; 
    _ecoCredits += 1;
    notifyListeners(); // Tell the UI to rebuild
  }

  void logFood(double co2) {
    _firebaseService.addEmissionEntry(type: 'food', co2: co2);

    // --- Mock UI update (for now) ---
    _projectedCo2 -= co2;
    _ecoCredits += 2; // Food logging gives more credits (dummy logic)
    notifyListeners();
  }

  void logEnergy(double co2) {
    _firebaseService.addEmissionEntry(type: 'energy', co2: co2);
    
    // --- Mock UI update (for now) ---
    _projectedCo2 -= co2;
    _ecoCredits += 1;
    notifyListeners();
  }

  // This function doesn't need to change
  void redeemReward(String reward) {
    // Dummy logic
    if (_ecoCredits >= 10) {
      _ecoCredits -= 10;
      debugPrint('Redeemed $reward!');
    }
    notifyListeners();
  }
}

