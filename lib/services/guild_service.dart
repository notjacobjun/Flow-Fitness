import 'package:cloud_firestore/cloud_firestore.dart';

class GuildService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getRecommendedGuilds() {
    return _firebaseFirestore
        .collection("guilds")
        .where('numberOfMembers', isLessThan: 40)
        .get();
  }
}
