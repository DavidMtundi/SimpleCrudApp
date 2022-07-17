import 'package:crudapp/Database/PersonProvider.dart';
import 'package:crudapp/Entities/PersonModel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedValue;
  final _dropdownFormKey = GlobalKey<FormState>();
  List<Person> allpersons = [];

  // Future AddPerson() async {
  //   await PersonProvider().insert(Person("Stephen", "10000", 1));
  //   await PersonProvider().insert(Person("Philip", "5000", 2));

  //   await PersonProvider().insert(Person("Major", "20000", 3));
  // }

  // Future loadAllPersons() async {
  //   allpersons = await PersonProvider().getAllPersons();
  // }
  List<Person> allPersonsDemo = [
    Person("Philip", "20,000", 1),
    Person("Paul", "19,000", 2),
    Person("Simeon", "2300", 3)
  ];
  List<DropdownMenuItem<String>> get dropdownItems {
    return allPersonsDemo
        .map((perso) => DropdownMenuItem(
            child: Text(perso.name), value: perso.id.toString()))
        .toList();
  }

  //first get the value from the database
  String rating = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Crud App"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Please Select A Person",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _dropdownFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField(
                        hint: const Text("Please Select Person"),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: false,
                          fillColor: Colors.blueAccent,
                        ),
                        validator: (value) =>
                            (value == null) ? "Select a Person First" : null,
                        // dropdownColor: Colors.blueAccent,
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            rating = allPersonsDemo
                                .where((element) =>
                                    (element.id.toString() == selectedValue))
                                .first
                                .rate;
                          });
                        },
                        items: dropdownItems),
                    ElevatedButton(
                        onPressed: () {
                          if (_dropdownFormKey.currentState!.validate()) {
                            //valid flow
                            setState(() {
                              rating = allPersonsDemo
                                  .where((element) =>
                                      (element.id.toString() == selectedValue))
                                  .first
                                  .rate;
                            });
                          }
                        },
                        child: const Text("Submit")),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "The Rating Is:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      rating,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
