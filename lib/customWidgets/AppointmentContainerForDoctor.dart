import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/PatientViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';

import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
import 'package:healing_hand/modelclass/userer.dart';
import 'package:provider/provider.dart';

TextStyle nameSytle = const TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600
);
String? num1,date1,time1;
DateTime? sdate,edate;
prodModal2? appoi;
class DocAppointmentContainer extends StatelessWidget {
  //final Appointment appointment;
  DocAppointmentContainer(String num, String? date, String? time,prodModal2 p1 )
  {
    appoi=p1;
    num1=num;
    date1=date;
    time1=time;
    sdate=DateTime.parse(date1.toString());
    edate=DateTime.parse(time1.toString());
  }

  @override
  Widget build(BuildContext context) {
    void initState() {
      // Fetch appointments when the widget is initialized
      
    }
    return Consumer<PatientProvider>(        //return CircularProgressIndicator();
            builder:(context, patientProvider, child) {
      Provider.of<PatientProvider>(context, listen: false).ListPatients(num1!);
            return ShowPostList(context, newwPatients);
  });}
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
  
  Widget ShowPostList(BuildContext context,List<prodModal3> posts)
  {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appoi!.purpose.toString(), style: nameSytle,),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.access_time_filled),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((sdate!.day).toString()+'-'+(sdate!.month.toString()+'-'+sdate!.year.toString())),
                      Text('${sdate!.hour.toString()+':'+sdate!.minute.toString()}-${edate!.hour.toString()+':'+sdate!.minute.toString()}')
                    ],
                  ),
                ),
             //   Text(appointment.type),
              ],
            ),
            SizedBox(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                leading: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 32.0,
                      //backgroundImage: Image.asset('assets/images/demo_user.jpg'),
                    ),
                  ),
                ),
                title: Text(posts[0].user_name.toString()),
                subtitle: Text('Age: '+posts[0].age.toString()+' / Gender: '+posts[0].gender.toString()),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientViewPage(posts[0].user_name,
                   
   posts[0].user_email,
   posts[0].pass,
   posts[0].phone,
   posts[0].weight,
   posts[0].height,
   posts[0].age,
   posts[0].gender
                  )));
                },
              ),
            )
          ],
        )
    );
  }
}
