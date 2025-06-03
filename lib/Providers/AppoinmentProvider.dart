import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
List<prodModal2> appointments=[];
class Appoinmentprovider with ChangeNotifier{
void addAppoinment(String email,String phoneno,String date,String time,String status,String purpose)
{
  
  FirebaseFirestore.instance.collection('Appointments').add({
    'umail':email,
    'pmail':remember,
   'startdate':date,
   'enddate':time,
   'status':status,
   'purpose':purpose
});
}
void showAppoinment()
{
  FirebaseFirestore.instance.collection('Appointments').snapshots().listen((snapshot) {
  appointments.clear();
  for(var doc in snapshot.docs)
  {
    prodModal2 apoinment=prodModal2(
      pmail:doc['pmail'],
      email:doc['umail'],
      date:doc['startdate'],
      enddate:doc['enddate'],
      status:doc['status'],
      purpose:doc['purpose']
    );
    appointments.add(apoinment);
  }
    notifyListeners();
  });
}

}