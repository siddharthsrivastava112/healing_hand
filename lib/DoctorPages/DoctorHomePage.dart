import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorDetailPage.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/DoctorPages/NotificationPage.dart';
import 'package:healing_hand/Providers/AppoinmentProvider.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainerForDoctor.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
import 'package:provider/provider.dart';
class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});
  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  bool gotLocation = false;

  @override
  void initState() {
    super.initState();
    // Fetch appointments when the widget is initialized
    Provider.of<Appoinmentprovider>(context, listen: false).showAppoinment();
  }
  Widget build(BuildContext context) {
    return Consumer<Appoinmentprovider>(  
    builder:(context,doctorProvider,child){
                return ShowPostList(context, appointments);});
        }
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
      
    Widget ShowPostList(BuildContext context,List<prodModal2> posts)
    {print(posts.length);
                           
      return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            leadingWidth: 300,
            toolbarHeight: 150,
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleImage(image: DoctorUser.profile.image),
                Text('Welcome back,'),
                Text(DoctorUser.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
              ],
            ),
            actionsIconTheme: IconThemeData(
              size: 30,
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));
                  },
                  icon: Icon(Icons.notifications)
              ),
            ],
          ),
          Text('Scheduled Appointments', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
          Expanded(
        //color: Colors.black,
            child: 
                     SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index){
                           
                            // Create a DateFormat with the appropriate pattern
                           
                           if(   posts[index].status.toString() == 'accepted' && posts[index].email==phoneController.text.toString())
                              return Column(
                                children: [
                                  DocAppointmentContainer(posts[index].pmail.toString(),posts[index].date,posts[index].enddate,posts[index]),
                                  SizedBox(height: 10,)
                                ],
                              );
                            else
                             return Container();
                          },
                          
                        ),
                      ],
                    ),
                  ),
            //),
          )
    ]),
    );

    }
}
