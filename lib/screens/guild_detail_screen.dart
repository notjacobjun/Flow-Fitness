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
              height: size.height * 0.49,
              width: size.width,
              child: Column(
                children: [
                  Text(
                    "here",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: guildService.getMemberCount(guildId),
                      itemBuilder: (context, index) => ListTile(
                          // TODO add leading here to build member layout for each member
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
