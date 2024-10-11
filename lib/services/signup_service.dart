import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpService {
  // Track referral during sign-up
  Future<void> signUpWithReferral(String userId, String? referralCode) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    if (referralCode != null && referralCode.isNotEmpty) {
      // Find who the referral code belongs to
      QuerySnapshot referralQuery = await usersCollection.where('referralCode', isEqualTo: referralCode).get();

      if (referralQuery.docs.isNotEmpty) {
        String referrerId = referralQuery.docs.first.id;

        // Save referral data
        await usersCollection.doc(userId).set({
          'referredBy': referrerId,
        }, SetOptions(merge: true));

        // Optionally reward the referrer
        await rewardReferrer(referrerId);
      }
    }
  }

  // Reward the referrer (e.g., increment points)
  Future<void> rewardReferrer(String referrerId) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot referrerDoc = await usersCollection.doc(referrerId).get();
    
    if (referrerDoc.exists) {
      int currentPoints = referrerDoc['points'] ?? 0;
      await usersCollection.doc(referrerId).set({
        'points': currentPoints + 10, // Add reward points
      }, SetOptions(merge: true));
    }
  }
}
