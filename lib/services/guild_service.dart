import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuildService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getRecommendedGuilds() {
    return _firebaseFirestore
        .collection("guilds")
        .where('numberOfMembers', isLessThan: 40)
        .get();
  }

  Future<QuerySnapshot> getMembers(String guildId) async {
    final members = _firebaseFirestore
        .collection("guilds")
        .doc(guildId)
        .collection("members")
        .get();
    return members;
  }

  Future<DocumentSnapshot> getGuild(String id) {
    final guild = _firebaseFirestore.collection("guilds").doc(id);
    final doc = guild.get();
    return doc;
  }

  Future<void> addMember(
      BuildContext context, User user, String guildId) async {
    final userInformation = await _firebaseFirestore
        .collection("users")
        // note: user.email gives the lowercase version of the email, this might interrupt the filter
        .where("email", isEqualTo: user.email)
        .get();
    var userName;
    var userLevel;
    var userDescription;
    var userCaloriesBurned;
    var userProfilePicture;
    userInformation.docs.forEach((element) {
      userName = element.data()['name'];
      if (userName == null) {
        userName = "No name provided";
      }
      userLevel = element.data()['level'];
      if (userLevel == null) {
        userLevel = 0;
      }
      userDescription = element.data()['description'];
      if (userDescription == null) {
        userDescription = "No description provided";
      }
      userCaloriesBurned = element.data()['caloriesBurned'];
      if (userCaloriesBurned == null) {
        userCaloriesBurned = 0;
        print("not able to fetch user calorie info");
      }
      userProfilePicture = element.data()['profilePicture'];
      if (userProfilePicture == null) {
        userProfilePicture = "No profile picture provided";
      }
    });
    final currentUser =
        await _firebaseFirestore.collection("users").doc(user.uid).get();
    if (currentUser.data()['guild'] == guildId) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You are already in this guild")));
    } else {
      _firebaseFirestore
          .collection("guilds")
          .doc(guildId)
          .collection("members")
          .add({
        "name": userName,
        "level": userLevel,
        "description": userDescription,
        "caloriesBurned": userCaloriesBurned,
        "profilePicture": userProfilePicture,
      });
      // update the user's guild
      _firebaseFirestore.collection("users").doc(user.uid).update({
        "guild": guildId,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("You're in!")));
    }
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
}
