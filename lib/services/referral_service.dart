import 'package:cloud_firestore/cloud_firestore.dart';

class ReferralService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to check if the referral code is valid
  Future<bool> validateReferralCode(String referralCode) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore
          .collection('referralCodes')
          .doc(referralCode)
          .get();

      if (docSnapshot.exists) {
        // Check if referral code is active or valid
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        return data['isActive'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      print('Error validating referral code: $e');
      return false;
    }
  }

  // Function to apply referral code during user registration
  Future<void> applyReferralCode(String referralCode, String userId) async {
    try {
      // Check if the referral code is valid
      bool isValid = await validateReferralCode(referralCode);

      if (isValid) {
        // If valid, apply the referral code for the user
        await _firestore.collection('users').doc(userId).update({
          'referralCode': referralCode,
          'referralApplied': true,
        });

        // Optionally update the referral code usage count
        await _firestore.collection('referralCodes').doc(referralCode).update({
          'usageCount': FieldValue.increment(1),
        });

        // Reward the referrer (optional)
        await rewardReferrer(referralCode);
      }
    } catch (e) {
      print('Error applying referral code: $e');
    }
  }

  // Function to reward the referrer
  Future<void> rewardReferrer(String referralCode) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore
          .collection('referralCodes')
          .doc(referralCode)
          .get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        String referrerId = data['referrerId'];

        // Reward logic: Update points, credits, or any other rewards
        await _firestore.collection('users').doc(referrerId).update({
          'rewardPoints': FieldValue.increment(10), // Example: Add 10 reward points
        });
      }
    } catch (e) {
      print('Error rewarding referrer: $e');
    }
  }

  // Function to create a new referral code (for new users to refer others)
  Future<void> createReferralCode(String userId) async {
    try {
      String referralCode = generateReferralCode(userId); // You can create a logic for referral code generation

      await _firestore.collection('referralCodes').doc(referralCode).set({
        'referrerId': userId,
        'isActive': true,
        'usageCount': 0,
      });
    } catch (e) {
      print('Error creating referral code: $e');
    }
  }

  // Function to generate a referral code (based on userId)
  String generateReferralCode(String userId) {
    return userId.substring(0, 6).toUpperCase(); // Example: Use the first 6 characters of the userId
  }
}
