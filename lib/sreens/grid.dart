import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_db/db/functions/functions.dart';
import 'package:student_db/db/modal/modal.dart';
import 'package:student_db/sreens/edit.dart';
import 'package:student_db/sreens/profile.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext context, List<Studentmodal> student, Widget? child) {
               if (student.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        } else {

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: student.length,
          itemBuilder: (BuildContext context, int index) {
            final data = student[index];

            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(student: data)),
                  );
                },
                child: Card(
                  color: Colors.blueGrey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(File(data.image)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Name: "),
                          Text(data.name),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Age: "),
                          Text(data.age),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Edit(data: data);
                                }),
                              );
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Deletion"),
                                    content: const Text(
                                        "Are you sure you want to delete this item?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Call deletedata function if user confirms deletion
                                          deletedata(data.id!);
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          )
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
        }
      },
    );
  }
}
