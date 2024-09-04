import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_db/db/functions/functions.dart';
import 'package:student_db/db/modal/modal.dart';
import 'package:student_db/sreens/edit.dart';
import 'package:student_db/sreens/profile.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<Studentmodal> student, Widget? child) {
                if (student.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        } else {

        return ListView.separated(
          itemBuilder: (context, index) {
            final data = student[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(File(data.image)),
              ),
              title: Text(data.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Edit(data: data)),
                      );
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.green,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Deletion"),
                            content: const Text("Are you sure you want to delete this item?"),
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
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(student: data)),
                );
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: student.length,
        );
        }
      },
    );
  }
}
