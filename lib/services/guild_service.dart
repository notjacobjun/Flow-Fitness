import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class GuildService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getRecommendedGuilds() {
    return _firebaseFirestore
        .collection("guilds")
        .where('numberOfMembers', isLessThan: 40)
        .get();
  }

  Future<DocumentSnapshot<Object>> getGuild(String id) async {
    final guild = _firebaseFirestore.collection("guilds").doc(id);
    final doc = await guild.get();
    return doc;
  }

  Future<QuerySnapshot> getMembers(String guildId) async {
    final members = _firebaseFirestore
        .collection("guilds")
        .doc(guildId)
        .collection("members")
        .get();
    return members;
  }

  int getMemberCount(String id) {
    try {
      var count;
      _firebaseFirestore.collection("guilds").doc(id).get().then((value) async {
        count = await value.data()["numberOfMembers"];
      });
      // delete after done debugging
      print(count);
      print(id);
      return count;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> getGuildName(String id) async {
    // without using http package
    try {
      final fireStoreInstance = FirebaseFirestore.instance;
      var name;
      // note that we have to await here or else we will get null values
      fireStoreInstance.collection("guild").doc(id).get().then((value) {
        name = value.data()["name"];
      });
      print(name);
      // should return a String value now because we are awaiting
      return name;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> fetchGuildName() {
    // using http package
    // return http.get(Uri.parse('https://firestore.googleapis.com/v1/'));
  }
}
