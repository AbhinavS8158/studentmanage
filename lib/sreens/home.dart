import 'package:flutter/material.dart';
import 'package:student_db/db/functions/functions.dart';
import 'package:student_db/sreens/add.dart';
import 'package:student_db/sreens/grid.dart';
import 'package:student_db/sreens/list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

 
  
  @override
  void initState() {
   
    getAllStudents();
   
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'H O M E',
            style: TextStyle(color: Colors.white60),
          ),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                     searchStudent(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () async {},
                      icon: const Icon(Icons.search),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.list,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.grid_view,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: ListWidget(),
                    ),
                    Center(
                      child: GridWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const Add()));
          },
          backgroundColor: Colors.deepPurple,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
  
}

