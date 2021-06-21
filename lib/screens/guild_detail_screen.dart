import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/services/guild_service.dart';
import 'package:interactive_workout_app/state_management_helpers/guild_detail_screen_arguments.dart';

class GuildDetailScreen extends StatelessWidget {
  static const routeName = "guild-detail";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context).settings.arguments as GuildDetailScreenArguments;
    final GuildService guildService = GuildService();
    final String guildId = args.guildId;
    final Future<DocumentSnapshot> guild = guildService.getGuild(guildId);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: guild,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("something");
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
            child: CachedNetworkImage(
              height: size.height * 0.35,
              width: size.width,
              imageUrl:
                  "https://github.githubassets.com/images/modules/open_graph/github-mark.png",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
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
                      // convert the Future<QuerySnapshot> into a List<membersnapshot>
                      final List<DocumentSnapshot> members = snapshot.data.docs;
                      // TODO change to listView builder b/c we could have a large number of members
                      return ListView(
                          // this is used to prevent unbounded vertical space for this ListView within a Column
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: members
                              .map((doc) => GestureDetector(
                                    onTap: () {
                                      print("tapped");
                                      // go to the guild detail page
                                    },
                                    child: Card(
                                      elevation: 10,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      child: ListTile(
                                        title: Text(
                                          doc['name'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          children: [
                                            Text(
                                              doc['profilePicture'],
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "Calories burned: " +
                                                  doc['caloriesBurned']
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic,
                                                  color: Theme.of(context)
                                                      .indicatorColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList());
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
