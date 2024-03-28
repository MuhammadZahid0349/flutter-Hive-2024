import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive-DataBase 2024"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: Hive.openBox('lab_1_Data'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        title: Text(
                          snapshot.data!.get('Name').toString(),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              snapshot.data!.put("Name", "Faizan");
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 30.sp,
                            )),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                          'Loading...'); // Or any other loading indicator
                    }
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('lab_1_Data');
          box.put('Name', "Zahid");
          box.put('details', {
            'pro': 'student',
            'stdName': 'Zahid Hashim',
          });
          print(box.get("Name"));
          print(box.get("details"));
          print(box.get("details")["pro"]);
        },
        child: Icon(
          Icons.add,
          size: 28.sp,
        ),
      ),
    );
  }
}
