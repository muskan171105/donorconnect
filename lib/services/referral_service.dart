import 'dart:math';

class ReferralService {
  // Generate random alphanumeric referral code
  String generateReferralCode(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // Save referral code in Firebase Firestore
  Future<void> saveReferralCode(String userId, String referralCode) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    await usersCollection.doc(userId).set({
      'referralCode': referralCode,
    }, SetOptions(merge: true));
  }
}
