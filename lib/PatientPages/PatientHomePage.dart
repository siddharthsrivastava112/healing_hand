import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/AppointmentRequestPage.dart';
import 'package:healing_hand/PatientPages/CategoryViewPage.dart';
import 'package:healing_hand/PatientPages/DoctorViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/PatientPages/nearby_places_screen.dart';

import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
String key="";
String? lang1,long1; 
class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  bool gotLocation = false;
   @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    doctorProvider.DoctorList();
      }); // ✅ Call only once
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      
      builder: (context, doctorProvider,child){ 
        if(!doctorProvider.isLoding)
        {
          return CircularProgressIndicator();
        }
        else
        {
        return ShowPostList(context, doctor);}
  });}
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
      
    

Widget ShowPostList(BuildContext context,List<prodModal> posts)
{
  return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          AppBar(
            leadingWidth: 300,
            toolbarHeight: 150,
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleImage(image: PatientUser.profile.image),
                Text('Welcome back,'),
                Text(PatientUser.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
              ],
            ),
            actionsIconTheme: IconThemeData(
              size: 30,
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    //add here google map functionality
                  },
                  icon: Icon(Icons.location_pin)
              ),
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentRequestPage()));
                  },
                  icon: Icon(Icons.notifications)
              ),
            ],
          ),
          Expanded(
            //color: Colors.black,
            child: Consumer<DoctorProvider>(
              builder: (context, DoctorModel, child) =>
              SingleChildScrollView(
                child: Column(
                  children: [
                    WhiteContainer(
                      child: InkWell(
                          onTap: (){
                            print('Search pressed');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black54,),
                              Expanded(child: Text('Search..', style: TextStyle(color: Colors.black54,),)),
                              Icon(Icons.tune, color: Colors.black54,)
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Available Doctors', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                      ],
                    ),
                    
                    Container(
                      height: 120.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: posts.length,
                        itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleImage(
                                  image: AssetImage('assets/images/doctor.png'),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorViewPage(name: posts[index].name,
                                    email: posts[index].email,category: posts[index].category,gender:posts[index].gender,age:posts[index].age,
                                    phone: posts[index].phone,)));
                                  },
                                ),
                                SizedBox(width: 85, child: Center(child: Text(posts[index].name.toString(), style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,)))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                      ],
                    ),
                    Container(
                      height: 120.0, // Adjust the height of the scrollable list
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                        return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleImage(
                                    image: AssetImage('assets/images/physician.jpg'),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryViewPage(key1: DoctorCategories[index])));
                                    },
                                  ),
                                  SizedBox(width: 85, child: Center(child: Text(DoctorCategories[index],overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),)))
                              ],
                            ),
                          );
                        },
                        itemCount: DoctorCategories.length,
                      ),
                    ),
                    WhiteContainer(
                        child: Column(
                          children: [
                            Text('Emergency?', style: TextStyle(fontSize: 25, color: Colors.red, fontWeight: FontWeight.w700),),
                            Text('Find nearest Doctors,Hospitals and Ambulance',textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                            SizedBox(height: 10,),
                            Image.asset('assets/images/emergency.jpg'),
                            SizedBox(height: 10,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.red.shade100,
                                foregroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50)
                              ),
                                onPressed: ()async{
                                 await _determinePosition();
                                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>NearByPlacesScreen()));
        
                            print('Go to Google Map');
                                },
                                child: Text('Find now', style: TextStyle(color: Colors.red),)
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
lang1=position.latitude.toString();
long1=position.longitude.toString();
    return position;
  }

}