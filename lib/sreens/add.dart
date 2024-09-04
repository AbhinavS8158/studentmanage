import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_db/db/functions/functions.dart';
import 'package:student_db/db/modal/modal.dart';
import 'dart:io';

class Add extends StatefulWidget {
  
  const Add({super.key, });

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String? _imageFile;
  final _formKey = GlobalKey<FormState>();

  final _picker = ImagePicker();
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _batchcontroller = TextEditingController();
  final _domaincontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add student")),
      body: SafeArea(
        child: SingleChildScrollView(
        child:   Column(
  children: [
    GestureDetector(
      onTap: () {
        _getImage(ImageSource.gallery);
        
      },
      child: _imageFile == null
          ? const CircleAvatar(
              radius: 80,
              backgroundColor: Color.fromARGB(255, 243, 210, 239),
              child: Icon(Icons.add_a_photo_outlined),
            )
          : CircleAvatar(
              radius: 80,
              backgroundColor: const Color.fromARGB(255, 243, 210, 239),
              backgroundImage: FileImage(File(_imageFile!)), // Use FileImage to display selected image
            ),
    ),
    Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _namecontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Name';
                }
                RegExp regExp=RegExp(r'^[a-zA-Z]+$');
                if(!regExp.hasMatch(value)){
                  return 'please enter only letters';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _agecontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter Age';
                          }
                          if (value.length >= 3) {
                            return 'Age must be 3 digits';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Age",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _batchcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter Batch';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Batch",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _domaincontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Domain';
                          }
                           RegExp regExp=RegExp(r'^[a-zA-Z]+$');
                          if(!regExp.hasMatch(value)){
                            return 'please enter only letters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Domain",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          onAddStudent();
        }
      },
      child: const Text("Save"),
    ),
    if (_imageFile == null) // Show text only if no image is selected
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Please select an image.',
          style: TextStyle(color: Colors.red),
        ),
      )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudent() async {
    final _name = _namecontroller.text.trim();
    final _age = _agecontroller.text.trim();
    final _batch = _batchcontroller.text.trim();
    final _domain = _domaincontroller.text.trim();
    if (_name.isEmpty || _age.isEmpty || _batch.isEmpty || _domain.isEmpty || _imageFile == null) {
      return;
    }
    print('$_name $_age $_domain $_batch');
    final _student = Studentmodal(name: _name, age: _age, batch: _batch, domain: _domain, image: _imageFile!);
    addStudent(_student);
    Navigator.pop(context);
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        final imagepath = File(pickedImage.path);
        _imageFile = imagepath.path;
      } else {
        print("no image");
      }
    });
  }
}
