import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
import 'package:provider/provider.dart';
httpServices13 http=new httpServices13();
List<prodModal> l1=[];
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

String key="";
class _SearchPageState extends State<SearchPage> {
  List<Doctor> filteredObjects = [];
  bool searchByName = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder:(context,doctorprovider,child)
      {
    return ShowPostList(context, filteredDoctor);
   } );}
        //}
        //else{
        //return CircularProgressIndicator();
        //}
            //  return CircularProgressIndicator();
  
  Widget ShowPostList(BuildContext context,List<prodModal> posts)
  {key="";
  if(posts!=null) l1=posts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox(),
        leadingWidth: 0,
        title: TextFormField(
          autofocus: true,
          enabled: true,
          enableSuggestions: true,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){Navigator.pop(context);},
            ),
            suffixIcon: PopupMenuButton<bool>(
              itemBuilder: (context){
                return [
                  PopupMenuItem(child: Text('Search by Name', style: TextStyle(color: !searchByName? Colors.grey: Colors.black),), value: true,),
                  PopupMenuItem(child: Text('Search by Category', style: TextStyle(color: searchByName? Colors.grey: Colors.black),), value: false,),
                ];
              },
              onSelected: (value){
                setState(() {
                  searchByName = value;
                  ;
                });
              },
              icon: Icon(Icons.tune),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: 'Search..',
            contentPadding: EdgeInsets.all(5),
            border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(26)
            ),
          ),
          onChanged: (query) {
            DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
            doctorProvider.filterDoctorList(query);
          },
        )
      ),
      body:Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: 5,),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  print(posts[index].name);
                  return DoctorTile(name: posts[index].name.toString(),
                                    age:posts[index].age,email: posts[index].email,category: posts[index].category,gender:posts[index].category,
                                    phone: posts[index].phone);
                },
              ),
            ),
          ],
        ),
      ));
  }
}
