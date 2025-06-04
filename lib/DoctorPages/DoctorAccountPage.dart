import 'dart:io';
import 'dart:typed_data';
import 'package:healing_hand/DoctorPages/DoctorDetailPage.dart' as pp;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healing_hand/DoctorPages/DoctorProfileEditPage.dart';
import 'package:healing_hand/DoctorPages/DoctorProfileEditPage.dart' as t;
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart' as doctorsignup;
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/Providers/RevieProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../customWidgets/styles.dart';

Image dpContent = Image.asset('assets/images/doctor.png', fit: BoxFit.fill,);

class DoctorAccountPage extends StatefulWidget {
  final Doctor doc;
  DoctorAccountPage({super.key, required this.doc});

  @override
  State<DoctorAccountPage> createState() => _DoctorAccountPageState(doc: doc);
}
httpServices13 http=new httpServices13();
class _DoctorAccountPageState extends State<DoctorAccountPage> {
  final Doctor doc;
  _DoctorAccountPageState({required this.doc});
  bool showAllReviews = false;
void initState()
{
  super.initState();
  Provider.of<DoctorProvider>(context,listen:false).DoctorList();
  Provider.of<Revieprovider>(context,listen:false).getreviews(doctorsignup.phoneController.text); 
}
  @override
  Widget build(BuildContext context) {

    
    return Consumer<DoctorProvider>
    (builder:(context,doctorprovider,child){ 
                return ShowPostList(context, doctor);
        });
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
     
  }
  Widget ShowPostList(BuildContext context,List<prodModal> posts)
  {int i=0;
  
    bool noReview = (reviews == null);
   for(i=0;i<posts.length;i++)
   {
    
    if(posts[i].email==doctorsignup.phoneController.text.toString())
    {return Scaffold(
      appBar: AppBar(
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
                  WhiteContainer(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: (){
                               // t.rating=posts[i].rating.toString();
                                t.emailController.text=posts[i].email.toString();
                                //pass the current values to the edit page
                                t.nameController.text=posts[i].name.toString();
                                t.addressController.text=posts[i].address.toString();
                                t.ageController.text=posts[i].age.toString();
                                t.editedGender=posts[i].gender.toString();
                                t.phoneController.text=posts[i].phone.toString();
                                t.selectedCategory=posts[i].category.toString();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorProfileEditPage()));
                              },
                              icon: Icon(Icons.edit)
                            ),
                          ),
                          Text(posts[i].name.toString(), style: nameSytle,),
                          Text(posts[i].category.toString(), style: profileStyle),
                          Text(posts[i].age.toString()+' years', style: profileStyle,),
                          Text(posts[i].gender.toString(), style: profileStyle),
                          Text(posts[i].email.toString(), style: profileStyle),
                          
                          //Text('${posts[i].rating} / 5', style: profileStyle),
                        ],
                      )
                  ),
                  const SizedBox(height: 20,),
                  WhiteContainer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Customer reviews', style: nameSytle,),
                            if (widget.doc.reviews!.length > 2)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showAllReviews = !showAllReviews;
                                  });
                                },
                                child: Text(showAllReviews ? 'Hide' : 'See all'),
                              ),
                          ],
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                noReview? Padding(padding: EdgeInsets.all(10), child: Text('No recent Reviews')):
                                Column(
                                  children: [
                                    // Display two recent reviews
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: showAllReviews ? reviews!.length : reviews!.length>=2 ? 2 : reviews!.length,
                                      itemBuilder: (context, index) {
                                       

                                        return ListTile(
                                          title: Text(reviews[index].email.toString()),
                                          subtitle: Text(reviews[index].review.toString()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )

                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  WhiteContainer(
                    child: Container(
                      height: 30,
                      child: InkWell(
                          onTap: (){
                            changePassword();
                            print('Change password');
                          },
                          child: Center(child: Text('Change Password', style: nameSytle,))
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  WhiteContainer(
                    child: Container(
                      height: 30,
                      child: InkWell(
                          onTap: (){
                            print('Logout pressed');
                          },
                          child: Center(child: Text('Log-out', style: nameSytle,))
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 67,
                    child: Center(
                        child: Text(
                            'Your Profile',
                            style: titleStyle
                        )
                    ),
                  ),
                  CircleImage(
                      image: DoctorUser.profile.image,
                    onTap: (){
                        showImage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    }
    else print("hi");
   }
return CircularProgressIndicator();
  }

  void showImage() {
    showDialog(context: context, builder: (context){
      return StatefulBuilder(
          builder: (context, dpState) {

            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your Profile Image'),
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
                ],
              ),
              content: dpContent,
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: ()async{
                          Uint8List? _imageBytes;
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                          dpState(() { //refresh the alert box
                            if (pickedFile != null){
                              _imageBytes = File(pickedFile.path).readAsBytesSync();
                              dpContent = Image.memory(_imageBytes!);
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                        child: Text('Change Image')
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')
                        ),
                        ElevatedButton(
                          onPressed: (){
                            setState(() {
                              DoctorUser.profile = dpContent;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          }
      );
    });
  }

  void changePassword(){
    showDialog(context: context, builder: (context){
      TextEditingController curPassController = TextEditingController();
      TextEditingController newPassController1 = TextEditingController();
      TextEditingController newPassController2 = TextEditingController();
      return AlertDialog(
        surfaceTintColor: Colors.deepPurple,
        title: Text('Enter current and new passwrd'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: curPassController,
              decoration: InputDecoration(hintText: 'Current Password'),
            ),
            TextField(
              controller: newPassController1,
              decoration: InputDecoration(hintText: 'New Password'),
            ),
            TextField(
              controller: newPassController2,
              decoration: InputDecoration(hintText: 'Re-enter new Password'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel')
          ),
          ElevatedButton(
              onPressed: () {
                //check whether password is correct and both new one are
                //then send request to change password
                print('Change password in database.......');
                Navigator.pop(context);
              },
              child: Text('Change', style: TextStyle(color: Colors.red),)
          ),
        ],
      );
    });
  }

}
