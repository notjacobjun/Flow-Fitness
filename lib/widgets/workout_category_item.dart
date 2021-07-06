import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:interactive_workout_app/models/workout.dart';
import 'package:interactive_workout_app/providers/workout_category.dart';
import 'package:interactive_workout_app/screens/workout_screen.dart';
import 'package:interactive_workout_app/state_management_helpers/workout_screen_arguments.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WorkoutCategoryItem extends StatefulWidget {
  // TODO consider changing this to be an id instead and change description
  final String title;
  String description;

  WorkoutCategoryItem({
    @required this.title,
    @required this.description,
  });

  @override
  _WorkoutCategoryItemState createState() => _WorkoutCategoryItemState();
}

// TODO make the pictures more responsive (for tablets)
class _WorkoutCategoryItemState extends State<WorkoutCategoryItem> {
  // TODO add custom difficulty
  void adjustWorkoutTimes(
      Difficulty difficulty, InnerWorkoutCategoryItem currentWorkoutCategory) {
    if (difficulty == Difficulty.Easy) {
      currentWorkoutCategory.workouts.forEach((workout) {
        workout.workoutDuration -= 10;
      });
      // no logic needed for medium because the default is medium
    } else if (difficulty == Difficulty.Hard) {
      currentWorkoutCategory.workouts.forEach((workout) {
        workout.workoutDuration += 10;
      });
    } else if (difficulty == Difficulty.Impossible) {
      currentWorkoutCategory.workouts.forEach((workout) {
        workout.workoutDuration += 20;
      });
    }
  }

  Future<void> showAdaptiveDialog(BuildContext context,
      InnerWorkoutCategoryItem currentWorkoutCategory) async {
    var isiOS = (Theme.of(context).platform == TargetPlatform.iOS);
    if (isiOS) {
      return showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text("Difficulty"),
          content: Text("Choose the difficulty of the workout"),
          actions: [
            CupertinoDialogAction(
              child: Text("Easy"),
              onPressed: () {
                adjustWorkoutTimes(Difficulty.Easy, currentWorkoutCategory);
                Navigator.of(ctx).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("Medium"),
              onPressed: () {
                adjustWorkoutTimes(Difficulty.Medium, currentWorkoutCategory);
                Navigator.of(ctx).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("Hard"),
              onPressed: () {
                adjustWorkoutTimes(Difficulty.Hard, currentWorkoutCategory);
                Navigator.of(ctx).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("Impossible"),
              onPressed: () {
                adjustWorkoutTimes(
                    Difficulty.Impossible, currentWorkoutCategory);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Center(child: Text("Difficulty")),
          content: Text("Choose the difficulty of the workout"),
          actions: [
            Column(
              // TODO find out how to align these actions
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text("Easy"),
                  onPressed: () {
                    adjustWorkoutTimes(Difficulty.Easy, currentWorkoutCategory);
                    Navigator.of(ctx).pop();
                  },
                ),
                TextButton(
                  child: Text("Medium"),
                  onPressed: () {
                    adjustWorkoutTimes(
                        Difficulty.Medium, currentWorkoutCategory);
                    Navigator.of(ctx).pop();
                  },
                ),
                TextButton(
                  child: Text("Hard"),
                  onPressed: () {
                    adjustWorkoutTimes(Difficulty.Hard, currentWorkoutCategory);
                    Navigator.of(ctx).pop();
                  },
                ),
                TextButton(
                  child: Text("Impossible"),
                  onPressed: () {
                    adjustWorkoutTimes(
                        Difficulty.Impossible, currentWorkoutCategory);
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Future<void> selectWorkout(BuildContext context,
      InnerWorkoutCategoryItem currentWorkoutCategory) async {
    await showAdaptiveDialog(context, currentWorkoutCategory);
    Navigator.of(context).pushNamed(WorkoutScreen.routeName,
        arguments: WorkoutScreenArguments(
            currentWorkoutCategoryTitle: widget.title,
            upcomingWorkoutIndex: 0,
            totalWorkoutTime: 0,
            currentWorkoutCategory: currentWorkoutCategory,
            totalCaloriesBurned: 0));
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = Provider.of<WorkoutCategory>(context, listen: false)
        .findCategory(widget.title);
    if (currentCategory.description == null) {
      // TODO find another design rather than this
      widget.description = "Enter description";
    }
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFffafbd),
            const Color(0xFFffc3a0),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => selectWorkout(context, currentCategory),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(5),
            ),
            Text(widget.title,
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).accentColor)),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).accentColor,
              ),
            ),
            currentCategory.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GlassmorphicContainer(
                      borderRadius: 30,
                      height: size.height * 0.22,
                      width: size.width * 0.40,
                      blur: 200,
                      alignment: Alignment.center,
                      border: 0.65,
                      linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFffffff).withOpacity(0.1),
                            Color(0xFFFFFFFF).withOpacity(0.05),
                          ],
                          stops: [
                            0.1,
                            1,
                          ]),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.5),
                          Color((0xFFFFFFFF)).withOpacity(0.5),
                        ],
                      ),
                      child: Image.asset(
                        currentCategory.image,
                        height: size.height * 0.25,
                        width: size.width * 0.38,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : Text("no image"),
          ],
        ),
      ),
    );
  }
}
