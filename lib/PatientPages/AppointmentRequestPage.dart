import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/Providers/AppoinmentProvider.dart';

import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
import 'package:provider/provider.dart';
httpServices13 http=new httpServices13();
class AppointmentRequestPage extends StatefulWidget {
  const AppointmentRequestPage({super.key});

  @override
  State<AppointmentRequestPage> createState() => _AppointmentRequestPageState();
}

class _AppointmentRequestPageState extends State<AppointmentRequestPage> {
  void initState() {
    super.initState();
    // Fetch appointments when the widget is initialized
    Provider.of<Appoinmentprovider>(context, listen: false).showAppoinment();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Appoinmentprovider>(

      builder:(context,appoimentprovider,child){
    return ShowPostList(context, appointments);
      });
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
  }
  Widget ShowPostList(BuildContext context,List<prodModal2> posts)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index){
                if((posts[index].status.toString() == "wait" || posts[index].status.toString() == "denied")
                && (posts[index].pmail.toString()==remember))
                  return Column(
                    children: [
                      WhiteContainer(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleImage(image: AssetImage('assets/images/doctor.png')),
                                title: Text(posts[index].purpose.toString()),
                                subtitle: Text(posts[index].email.toString()),
                              ),
                              Divider(),
                              posts[index].status == "wait" ? Text('Status: Waiting') : Text('Status: Denied', style: TextStyle(color: Colors.red),),
                            ],
                          )
                      ),
                      SizedBox(height: 7,)
                    ],
                  );
                else
                  return Container();
              },
              itemCount: posts.length
          ),
        ),
      ),
    );
  }
}
