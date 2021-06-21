import 'package:flutter/material.dart';
import 'package:interactive_workout_app/models/destination.dart';

class DestinationView extends StatefulWidget {
  final Destination destination;

  DestinationView(this.destination);

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return widget.destination.screen;
  }
}
