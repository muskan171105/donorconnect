import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReferralDashboard extends StatelessWidget {
  final String userId;

  ReferralDashboard({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final referralCount = userData['referralCount'] ?? 0;
        final points = userData['points'] ?? 0;

        return Column(
          children: [
            Text('Referral Count: $referralCount'),
            Text('Points: $points'),
          ],
        );
      },
    );
  }
}
