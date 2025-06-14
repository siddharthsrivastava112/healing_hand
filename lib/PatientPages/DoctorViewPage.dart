import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/AppoinmentProvider.dart';

import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/Providers/RevieProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
import 'package:healing_hand/modelclass/review.dart';
import 'package:provider/provider.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart' as p;

import '../customWidgets/styles.dart';
String? name1;
  String? phone1;
  String? email1;
  String? category1;
  String? address1;
  String? gender1;
  String? age1; 
  String? rating1;
  String? review1;
List<prodModal1> ff=[];
class DoctorViewPage extends StatefulWidget {
  DoctorViewPage({
    name,email,category,age,gender,phone,address,rating
  })
  {
name1=name;
 phone1=phone;
   email1=email;
   category1=category;
   address1=address;
 gender1=gender;
   age1=age; 
   rating1=rating;
  
  }
  
  @override
  _DoctorViewPageState createState()
  {
    return _DoctorViewPageState();
  }
  // DoctorViewPage({super.key, this.name,this.email,this.category,this.password,this.gender,this.age,});

  // @override
  // State<DoctorViewPage> createState() => _DoctorViewPageState(doc: doc);
}
httpServices13 http=new httpServices13();
class _DoctorViewPageState extends State<DoctorViewPage> {
  //final Doctor doc;
  //_DoctorViewPageState();
  bool showAllReviews = false;
  TextEditingController reviewController = TextEditingController();
  double userRating = 0.0;
void initState() {
  super.initState();
  Provider.of<Revieprovider>(context, listen: false).getreviews(email1.toString());
}
  @override
  Widget build(BuildContext context) {
    // bool noReview = (doc.reviews == null);
    print("sid12");
    print(email1);
    return
    Consumer<Revieprovider>(
      builder: ((context, reviewProvider, child) {

              return ShowPostList(context, reviews);

        }));
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
     
  }

  Widget ShowPostList(BuildContext context, List<prodModal1> posts) {
    if (rating1 == null) rating1 = "3";
    
    print(rating1);
    print(double.parse(rating1.toString()));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  const SizedBox(height: 100,),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            //height: 250,
                            child: Column(
                              children: [

                                SizedBox(height: 30,),
                                Text(name1.toString(), style: nameSytle,),
                                Text(category1.toString(), style: profileStyle),
                                Text('${age1.toString()} years',
                                  style: profileStyle,),
                                Text(gender1.toString(), style: profileStyle),
                                Text(email1.toString(), style: profileStyle),
                                RatingBar.builder(
                                  initialRating: double.parse(
                                      rating1.toString()),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25,
                                  itemBuilder: (context, _) =>
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                  ignoreGestures: true,
                                  onRatingUpdate: (newRating) {
                                    setState(() {
                                      rating1 = newRating.toString();
                                    });
                                  },
                                ),
                                Text('${double.parse(rating1.toString())} / 5',
                                    style: profileStyle),
                                //Text('${PatientUser.height}cm / ${PatientUser.weight}Kg', style: profileStyle)
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    //height: 200,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Customer reviews', style: nameSytle,),
                            if (posts.length > 2)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showAllReviews = !showAllReviews;
                                  });
                                },
                                child: Text(
                                    showAllReviews ? 'Hide' : 'See all'),
                              ),
                          ],
                        ),
                        
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            //height: 150,
                            child: Column(
                              children: [
                                posts.length == 0 ? Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('No recent Reviews')) :
                                Column(
                                  children: [
                                    // Display two recent reviews
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: posts.length,
                                      itemBuilder: (context, index) {
                                        String review = posts[index].review
                                            .toString();
                                        
                                        print(review);
                                        // List<String> parts = review.split(': ');

                                        return ListTile(
                                          title: Text(
                                              posts[index].email.toString()),
                                          subtitle: Text(
                                              posts[index].review.toString()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showReviewDialog();
                                  },
                                  child: Text('Add Your Review'),
                                ),
                              ],
                            )

                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 67,
                    child: Center(
                        child: Text(
                            name1.toString(),
                            style: titleStyle
                        )
                    ),
                  ),
                  CircleImage(image: AssetImage('assets/images/doctor.png')),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(3),
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )
          ),
          onPressed: () {
            TextEditingController purposeController = TextEditingController();
            TextEditingController modeController = TextEditingController();
            showDialog(context: context, builder: (context) =>
                AlertDialog(
                  title: Text('Enter purpose and Mode(Online/Offline)'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: purposeController,
                        decoration: InputDecoration(
                            hintText: 'Purpose'
                        ),
                      ),
                      TextField(
                        controller: modeController,
                        decoration: InputDecoration(
                            hintText: 'Mode'
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')
                    ),
                    TextButton(
                        onPressed: () {
                          DateTime date=DateTime.now();
                          String r=date.toString();
                         Appoinmentprovider appoinmentprovider=Provider.of<Appoinmentprovider>(context,listen:false);
                          // request sent with date of 14/09/2024 it will be changed when doctor accepts request
                           appoinmentprovider.addAppoinment(email1.toString(), p.phoneController.toString(),
                              r,DateTime.now().toString(),"wait",purposeController.text.toString());
                  print("hi sid");
                          Navigator.pop(context);
                        },
                        child: Text('Send Request')
                    ),
                  ],
                )
            );
          },
          child: Text('Get an Appointment'),
        ),
      ),
    );
  }

  String? review;

  void showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Review, Rating'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Give rating:'),
                  RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRating) {
                        userRating = newRating;
                      // the value of the rating given by user is stored in userRating value, use it
                    },
                  ),
                ],
              ),
              TextField(
                onChanged: (value) {
                  review = value;
                },
                controller: reviewController,
                decoration: InputDecoration(hintText: 'Enter your review'),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
               Revieprovider reviewProvider = Provider.of<Revieprovider>(context, listen: false);
               reviewProvider.addreview("anonymous user",email1.toString(), review.toString());
                Navigator.pop(context);
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }
}