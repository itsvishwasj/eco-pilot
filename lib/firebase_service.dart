// This file now contains real code to talk to Firebase.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // Step 1: Sign the user in anonymously as soon as the app starts.
  // This gives us a unique `userId` to save data against.
  Future<User?> signInAnonymously() async {
    try {
      // If the user is already signed in, just return them.
      if (_auth.currentUser != null) {
        debugPrint('User already signed in: ${_auth.currentUser!.uid}');
        return _auth.currentUser;
      }
      
      // Otherwise, sign them in for the first time.
      final userCredential = await _auth.signInAnonymously();
      debugPrint('New user signed in: ${userCredential.user!.uid}');
      return userCredential.user;
    } catch (e) {
      debugPrint('Error signing in anonymously: $e');
      return null;
    }
  }

  // Step 2: Add a new emission entry to Firestore.
  // We save it under a collection called 'emissions'.
  Future<void> addEmissionEntry({
    required String type, // "travel", "food", or "energy"
    required double co2,  // The amount of CO2
  }) async {
    if (currentUser == null) {
      debugPrint('Error: Cannot add entry, user is not signed in.');
      return;
    }

    try {
      // This creates a new document in the 'emissions' collection
      await _firestore.collection('emissions').add({
        'userId': currentUser!.uid, // So we know who this entry belongs to
        'type': type,
        'co2': co2,
        'timestamp': FieldValue.serverTimestamp(), // Automatically adds the date
      });
      debugPrint('Successfully added $type entry.');
    } catch (e) {
      debugPrint('Error adding emission entry: $e');
    }
  }
}

