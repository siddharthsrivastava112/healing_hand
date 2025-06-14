import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorDetailPage.dart';
import 'package:healing_hand/DoctorPages/DoctorProfileEditPage.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/PatientPages/PatientProfileEditPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/modelclass/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:healing_hand/PatientPages/PatientSignupPage.dart' as pp;
import 'package:shared_preferences/shared_preferences.dart';

final detailKey = GlobalKey<FormState>();

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({super.key});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

final TextEditingController ageController = TextEditingController();
final TextEditingController heightController = TextEditingController();
final TextEditingController weightController = TextEditingController();
final TextEditingController gender=TextEditingController();
String selectedGender = 'Select';

class _PatientDetailPageState extends State<PatientDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individual signup'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Lets create your profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.white),),
              const SizedBox(height: 15,),
              WhiteContainer(
                  child: Form(
                    key: detailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        CustomTextFormField(
                          controller: pp.nameController,
                          labelText: 'Name',
                          icon: Icons.person,
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedGender,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            icon: const Icon(Icons.female),
                            floatingLabelAlignment: FloatingLabelAlignment.center,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          items: ['Select', 'Male', 'Female', 'Other']
                              .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value == 'Select') {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: ageController,
                          labelText: 'Age',
                          icon: Icons.calendar_today,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: pp.phoneController,
                          labelText: 'Email',
                          icon: Icons.email,
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: heightController,
                          labelText: 'Height',
                          icon: Icons.height,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: weightController,
                          labelText: 'Weight',
                          icon: Icons.line_weight,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        Consumer<PatientProvider>(
                            builder: (context, PatientModel, child){
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 8,
                                  ),
                                  onPressed: () async {
                                    if (detailKey.currentState!.validate()) {
                                      // PatientModel.createUser(
                                      //     name: pp.nameController.text,
                                      //     gender: selectedGender,
                                      //     age: int.parse(ageController.text),
                                      //     phone: pp.phoneController.text,
                                      //     email: emailController.text,
                                      //     height: int.parse(heightController.text),
                                      //     weight: int.parse(weightController.text)
                                      // );
                                      signin();
                                     // SaveRecord(context);
                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientLandingPage()));
                                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                                      // prefs.setString('FIRST_PAGE', 'patient');
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PatientLandingPage()));
                                    }
                                  },
                                  child: const Text('Save')
                              );
                            }
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  SaveRecord(context) async
  {
    print(pp.nameController.text.toString());
    User user= User(pp.nameController.text.toString(),pp.phoneController.text.trim(),pp.passwordController.text.toString(),pp.phoneController.text.toString(),
        weightController.text.toString(),heightController.text.toString(),ageController.text.toString(),selectedGender.toString());
    try{
      var res=await http.post(Uri.parse(
          "http://siddharth1212-37666.portmap.host:37666/healinghand/userlogin.php"
      ),body:user.toJson());
      if(res.statusCode==200)
      {
        //var resBody1=jsonDecode(res.body);
        String resBody=res.body;
        print(resBody);
        if((resBody)=="false")
        {
          Future.delayed(Duration.zero,()=>showDialog(context: context, builder: ((context) => AlertDialog(
              title:Text("Record Saved "),
              content:ElevatedButton(child:Text("O.K"),onPressed: () {Navigator.pop(context);},)))));
        }
        else{
          AlertDialog(
            content: Text("Record already exist"),
            actions: [ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("O.K"))],

          );
        }
      }
      else{
        AlertDialog(
          content: Text("Record Saved now go to login page"),
          actions: [ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("O.K"))],

        );
      }
    }
    catch(e){
      print(e);
    }
  }

  void signin()async{
    final auth = AuthServices();
    try{
      //await auth.signUpWithEmailPassword(phoneController.text, passwordController.text);
      await auth.patientSignin(pp.phoneController.text, pp.passwordController.text, pp.nameController.text, [],weightController.text,heightController.text,ageController.text,selectedGender.toString());
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientLandingPage()));
    }
    catch (e) {
      print(e.toString());
    }
  }
}
