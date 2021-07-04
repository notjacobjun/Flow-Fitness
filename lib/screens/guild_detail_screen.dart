import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/services/guild_service.dart';
import 'package:interactive_workout_app/state_management_helpers/guild_detail_screen_arguments.dart';
import 'package:interactive_workout_app/widgets/custom_dialog_box.dart';

class GuildDetailScreen extends StatefulWidget {
  static const routeName = "guild-detail";

  @override
  _GuildDetailScreenState createState() => _GuildDetailScreenState();
}

class _GuildDetailScreenState extends State<GuildDetailScreen> {
  final GuildService guildService = GuildService();
  final User currentUser = FirebaseAuth.instance.currentUser;

  void showProfilePage(
      {BuildContext context,
      String title,
      String description,
      String image,
      int caloriesBurned}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return CustomDialogBox(
            title: title,
            descriptions: description,
            text: "Add to Friend list",
            img: Image.network(image),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context).settings.arguments as GuildDetailScreenArguments;
    final String guildId = args.guildId;
    final Future<DocumentSnapshot> guild = guildService.getGuild(guildId);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: guild,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data['name']);
            } else if (!snapshot.hasData) {
              return Text("The guild name hasn't been configured yet");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      body: Column(
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: FutureBuilder<DocumentSnapshot>(
              future: guild,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CachedNetworkImage(
                    height: size.height * 0.35,
                    width: size.width,
                    imageUrl: snapshot.data['image'],
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  );
                } else if (!snapshot.hasData) {
                  return Text("The guild name hasn't been configured yet");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: Theme.of(context).primaryColor,
              // TODO see if there is a need to change this later on
              height: size.height * 0.5385,
              width: size.width,
              child: FutureBuilder<QuerySnapshot>(
                  // Pass `Future<QuerySnapshot>` to future
                  future: guildService.getMembers(guildId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // convert the Future<QuerySnapshot> into a List<DocumentSnapshot>
                      List<DocumentSnapshot> members = snapshot.data.docs;
                      // TODO change to listView builder b/c we could have a large number of members
                      return Column(
                        children: [
                          ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: members
                                  .map((doc) => GestureDetector(
                                        onTap: () {
                                          showProfilePage(
                                              context: context,
                                              title: doc["name"],
                                              description: doc["description"],
                                              image: doc["profilePicture"],
                                              caloriesBurned:
                                                  doc["caloriesBurned"]);
                                        },
                                        child: Card(
                                          elevation: 10,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: CachedNetworkImage(
                                                        imageUrl: doc[
                                                            'profilePicture'],
                                                        fit: BoxFit.fill,
                                                        placeholder: (context,
                                                                url) =>
                                                            new CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            new Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  doc['name'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Theme.of(context)
                                                          .indicatorColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Level: " +
                                                      doc['level'].toString(),
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Theme.of(context)
                                                          .indicatorColor,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.1,
                                                ),
                                                Text(
                                                  "Calories burned: " +
                                                      doc['caloriesBurned']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Theme.of(context)
                                                          .indicatorColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()),
                          RoundedButton(
                              message: "Join Guild",
                              color: Colors.black,
                              function: () async {
                                try {
                                  await guildService.addMember(
                                      context, currentUser, guildId);
                                } catch (e) {
                                  print(e);
                                }
                                setState(() {});
                              }),
                        ],
                      );
                    }
                    // only return here if there is an error
                    return Text("There is an error");
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
