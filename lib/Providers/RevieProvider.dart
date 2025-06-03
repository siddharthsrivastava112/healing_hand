import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
import 'package:healing_hand/modelclass/review.dart';
List<prodModal1> reviews=[];

class Revieprovider extends ChangeNotifier
{
  void addreview(String pmail,String umail,String review)
  {
  FirebaseFirestore.instance.collection('Reviews').add({
  'pmail':  pmail,
  'umail':umail,
  'review':review
  });
  print("review added successfully");  
  }
  void getreviews(String doctor_mail)
  {
    FirebaseFirestore.instance.collection('Reviews').where('umail',isEqualTo: doctor_mail).snapshots().listen((snapshot){
   reviews.clear();   
      for(var doc in snapshot.docs)
      {
        prodModal1 review=prodModal1(
          email:doc['pmail'],umail:doc['umail'],review:doc['review']
        );
        reviews.add(review);
      }
      notifyListeners();
    });
  }
}