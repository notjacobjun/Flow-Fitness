import 'package:flutter/material.dart';
import 'package:interactive_workout_app/models/workout.dart';

class WorkoutItem extends StatelessWidget {
  final String title;
  final String description;
  final Category category;
  final Color color;
  final String image;

  WorkoutItem(
      {this.title, this.category, this.color, this.image, this.description});

// TODO configure this
  void selectWorkout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () => selectWorkout(context),
        child: Row(
          children: [
            // CircleAvatar(
            //   radius: 30,
            //   backgroundColor: Theme.of(context).primaryColor,
            //   child: Text(
            //     title,
            //     style: TextStyle(fontSize: 14),
            //   ),
            // ),
            SafeArea(
              child: Padding(
                // TODO fix the alignment of the image
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "Enter description here",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: (Image.asset(
                              image,
                              height: size.height * 0.25,
                              width: size.width * 0.38,
                              fit: BoxFit.contain,
                            )),
                          )
                        : Text("no image"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
