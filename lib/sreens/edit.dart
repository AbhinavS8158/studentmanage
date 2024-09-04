import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_db/db/functions/functions.dart';
import 'package:student_db/db/modal/modal.dart';

class Edit extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  
  const Edit({Key? key ,this.data});

  @override
  State<Edit> createState() => _editState();
}

// ignore: camel_case_types
class _editState extends State<Edit> {
  String? _imageFile;
  final _formKey = GlobalKey<FormState>();
  
  

  final _picker = ImagePicker();
  var  _namecontroller =TextEditingController();
  
  var _agecontroller = TextEditingController();
  var _batchcontroller = TextEditingController();
  var _domaincontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final student =widget.data;
     _namecontroller = TextEditingController( text: student.name);
     _agecontroller = TextEditingController(text: student.age);
     _batchcontroller = TextEditingController(text: student.batch);
     _domaincontroller = TextEditingController(text:  student.domain);
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text("E D I T",style: TextStyle(color: Colors.white60),)),
        
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _getImage(ImageSource.gallery);
                },
                child: 

                _imageFile != null ?
                CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(File(_imageFile.toString())),
                ):
                CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(File(widget.data.image)),
                )
               
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
                          return null;
                        },
                        decoration: InputDecoration(
                          // label: Text(widget.data.domain),
                          
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
    
      final newStudent = Studentmodal(
        name: _namecontroller.text.trim(),
        age: _agecontroller.text.trim(),
        batch: _batchcontroller.text.trim(),
        domain: _domaincontroller.text.trim(),
        image: _imageFile ?? widget.data.image, 
              );
      
    
      editStudent(widget.data, newStudent);
      
      Navigator.pop(context); 
    }
  },
  child: const Text("Save"),
)

            ],
          ),
        ),
      ),
    );
  }
  
void editStudent(Studentmodal oldStudent, Studentmodal newStudent) {
  
  oldStudent.name = newStudent.name;
  oldStudent.age = newStudent.age;
  oldStudent.batch = newStudent.batch;
  oldStudent.domain = newStudent.domain;
  oldStudent.image = newStudent.image;

 
  updateStudent(oldStudent);
}


  Future<void> onAddStudent() async {
    final name = _namecontroller.text.trim();
    final age = _agecontroller.text.trim();
    final batch = _batchcontroller.text.trim();
    final domain = _domaincontroller.text.trim();
    if (name.isEmpty || age.isEmpty || batch.isEmpty || domain.isEmpty || _imageFile == null) {
      return;
    }
    print('$name $age $domain $batch');
    final student = Studentmodal(name: name, age: age, batch: batch, domain: domain, image: _imageFile!);
    addStudent(student);
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
