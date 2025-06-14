import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/PatientPages/PatientDetailPage.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/apiconnection/userhttp.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formKey = GlobalKey<FormState>();
String remember="";
class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _PatientSignupPageState extends State<PatientSignupPage> {
  bool isObscured = true;
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //backgroundColor: Colors.grey.shade200,
        //foregroundColor: Colors.black,
        title: const Text('Individual signup'),
        centerTitle: true,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(15), top: Radius.circular(15))
        // ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Hey Champ!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.white),),
              const SizedBox(height: 30,),
              WhiteContainer(
                //padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                //height: 480,
                // decoration: BoxDecoration(
                //     color: Colors.deepPurple.shade100,
                //     borderRadius: BorderRadius.circular(20),
                //     border: Border.all(
                //       color: Colors.black,
                //     ),
                //     boxShadow: const [
                //       BoxShadow(
                //           color: Colors.deepPurple,
                //           blurRadius: 5
                //       )
                //     ]
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isLogin? 'Log-in':'Sign-up',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!isLogin) TextFormField(
                            controller: nameController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              icon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: phoneController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              } //else if (value.toString().length != 10) {
                              //return 'Number must be 10 digit';
                              //}
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: passwordController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              icon: const Icon(Icons.key),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                              suffixIcon: IconButton(
                                tooltip: isObscured ? 'Show password' : 'Hide password',
                                icon: isObscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                onPressed: (){
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                },
                              ),
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Required';
                              }
                              return null;
                            },
                            obscureText: isObscured,
                          ),
                        ],
                      ),
                    ),
                    if(isLogin) const SizedBox(height: 10,),
                    if(isLogin) TextButton(
                      onPressed: (){
                        forgotPass();
                      },
                      child: Text('Forgot Password?'),
                    ),
                    const SizedBox(height: 15,),
                    Column(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 8,
                            ),
                            onPressed: () async{
                              if(formKey.currentState!.validate()){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Successful\n'
                                                '${!isLogin? nameController.text:''}'
                                                '${phoneController.text}\n'
                                                '${passwordController.text}'
                                        )
                                    )
                                );
                                remember=phoneController.text.toString();
                                if(isLogin){
                                  login();
                                  int j = 0;
                                }
                                else
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PatientDetailPage()));
                              }
                            },
                            child: !isLogin? const Text('Sign-Up') : const Text('Login')
                        ),
                        const SizedBox(height: 10,),
                        TextButton(
                            onPressed: ()async {
                              setState(() {
                                isLogin = !isLogin;
                              });

                            },
                            child: !isLogin? const Text('Already have account? Login') : const Text('New to Helping Hand? SignUp')
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  void forgotPass() {
    showDialog(context: context, builder: (context){
      TextEditingController emialController = TextEditingController();
      return AlertDialog(
        title: Text('Enter your registered email:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('An email will be sent to your email id...'),
            TextField(controller: emialController,)
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: (){
                //send otp to emial
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Check your Mail box...'))
                );
                Navigator.pop(context);
              },
              child: Text('Send')
          )
        ],
      );
    });
  }

  void login()async{
    //get instance
    final authService = AuthServices();

    //try login
    try{
      //await authService.signInWithEmailPassword(phoneController.text, passwordController.text);
      await authService.patientLogin(phoneController.text, passwordController.text);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientLandingPage()));
                              Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const PatientLandingPage()));
          
    }

    //catch error
    catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                            title: const Text(
                                                "Invalid email or password entered"),
                                            content: ElevatedButton(
                                              child: const Text("O.K"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                        )));
      
    }
  }

}