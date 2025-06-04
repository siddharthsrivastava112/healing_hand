import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientHomePage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
import 'package:provider/provider.dart';
httpServices13 http=new httpServices13();
String? key2;

class CategoryViewPage extends StatefulWidget {
   String? category;
   CategoryViewPage({
    key1
   })
   {
    key2=key1;
   }
_CategoryViewPageState createState()
{
  return _CategoryViewPageState(); 
}
}

class _CategoryViewPageState extends State<CategoryViewPage> {

  @override
  Widget build(BuildContext context) {
    // List<Doctor> filteredList = doctors.where((obj) =>
    //     obj.category.toLowerCase() == widget.category.toLowerCase())
    //     .toList();
    void initState() {
      super.initState();
      // Fetch doctors when the widget is initialized
      Provider.of<DoctorProvider>(context, listen: false).filterDoctorList(category);
    }
    return  Consumer<DoctorProvider>(
      builder: (context, doctorprovider, child) {
            return ShowPostList(context, filteredDoctor);
      });
          

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
     
  }
  Widget ShowPostList(BuildContext context,List<prodModal> posts)
  {
    return Scaffold(
      //backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(key2.toString()),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.separated(
            shrinkWrap: true,
              itemBuilder: (context, index){
                return DoctorTile(name: posts[index].name,
                                    age:posts[index].age,email: posts[index].email,category: posts[index].category,gender:posts[index].category,
                                    phone: posts[index].phone);
              },
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: posts.length
          ),
        ),
      ),
    );
  }
}
