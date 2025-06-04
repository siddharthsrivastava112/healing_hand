import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/main.dart';
import 'package:healing_hand/modelclass/userer.dart';

class Patient{
  Image profile;
  String name;
  String gender;
  int age;
  String phone;
  String email;
  int height;
  int weight;

  Patient({
    required this.profile,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.height,
    required this.weight,
  });
}

List<Patient> patients = [];
List<prodModal3> newwPatients = []; 
Patient PatientUser = Patient(
    profile: Image.asset('assets/images/demo_user.jpg'),
    name: 'Sample user',
    age: 0,
    gender: 'sample',
    phone: 'sampel',
    email: 'sample',
    height: 0, weight: 0
);

class PatientProvider extends ChangeNotifier{

  void addPatient({
    required Image profile,
    required String name,
    required String gender,
    required int age,
    required String phone,
    required String email,
    required int height,
    required int weight,
  }){
    patients.add(
      Patient(
        profile: profile,
        name: name,
        age: age,
        gender: gender,
        phone: phone,
        email: email,
        height: height,
        weight: weight
      )
    );
    notifyListeners();
  }

  void createUser({
    required String name,
    required String gender,
    required int age,
    required String phone,
    required String email,
    required int height,
    required int weight,
  }){
    PatientUser.name = name;
    PatientUser.phone = phone;
    PatientUser.height = height;
    PatientUser.weight = weight;
    PatientUser.gender = gender;
    PatientUser.age = age;
    PatientUser.email = email;
    print('User details changed');
    notifyListeners();
  }
  void ListPatients(String email)
  {
    FirebaseFirestore.instance.collection('Patient').where('email',isEqualTo: 'abhishek@gmail.com').snapshots().listen((snapshot){
     newwPatients.clear();
      for(var doc in snapshot.docs)
      {
        prodModal3 patient = prodModal3(
          user_name: doc['name'],
          phone: '9838546052',
          user_email: doc['email'],
          gender: doc['gender'],
          age: doc['age'],
          height: doc['height'],
          weight: doc['weight'],
        );
        newwPatients.add(patient);
      }
      
      notifyListeners();
    });
  }
  void updatePatient(String emailController ,String password,String nameController,String heightController, String weightController,String editedGender,String ageController)                                      
  {print(emailController);
  print("siddharth12");
    FirebaseFirestore.instance.collection('Patient').where('email',isEqualTo: emailController).get().then((value){
      for(var doc in value.docs)
      {
      FirebaseFirestore.instance.collection('Patient').doc(doc.id).update(
      {
        'name': nameController,
        'height': heightController,
        'weight': weightController,
        'gender': editedGender,
        'age': ageController,
        'email': emailController,
        'password': password,
      }
    );
    }});
    
  }
}

Patient samplePatient = Patient(
    profile: Image.asset('assets/images/demo_user.jpg'),
    name: 'Nihal Yadav',
    age: 21,
    gender: 'Male',
    phone: '8264525736',
    email: 'jhdgf@gmail.com',
    height: 175, weight: 55
);
