import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/social/presentation/screens/guild_detail_screen.dart';
import 'package:interactive_workout_app/services/guild_service.dart';
import 'package:interactive_workout_app/state_management_helpers/guild_detail_screen_arguments.dart';
import 'package:interactive_workout_app/widgets/rounded_app_bar.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';

class NoGuildScreen extends StatefulWidget {
  static const routeName = "/no-guild";

  @override
  _NoGuildScreenState createState() => _NoGuildScreenState();
}

class _NoGuildScreenState extends State<NoGuildScreen> {
  final _currentIndex = 3;
  void navigateToGuild(String id, BuildContext context) {
    Navigator.of(context).pushNamed(GuildDetailScreen.routeName,
        arguments: GuildDetailScreenArguments(id));
  }

  Future<QuerySnapshot> getRecommendedGuilds() {
    final GuildService guildService = GuildService();
    return guildService.getRecommendedGuilds();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: RoundedAppBar(
          text: Text("Join a guild"),
        ),
        bottomNavigationBar: RoundedBottomNavigationBar(
          index: _currentIndex,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Text(
                  "It looks like you aren't in a guild. Try joining one now!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width * 0.06),
                child: FutureBuilder<QuerySnapshot>(
                    // Pass `Future<QuerySnapshot>` to future
                    future: getRecommendedGuilds(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // convert the Future<QuerySnapshot> into a List<DocumentSnapshot>
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        return ListView(
                            // this is used to prevent unbounded vertical space for this ListView within a Column
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: documents
                                .map((doc) => GestureDetector(
                                      onTap: () {
                                        navigateToGuild(doc.id, context);
                                        // go to the guild detail page
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.purple,
                                              Colors.blue
                                            ],
                                          ),
                                        ),
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
                                                doc['description'],
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Theme.of(context)
                                                        .indicatorColor,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "Number of members: " +
                                                    doc['numberOfMembers']
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
              )
              // TODO consider wrapping this in a glassmorphic container
              // TODO enter a list of recommended guilds here
            ],
          ),
        ));
  }
}
