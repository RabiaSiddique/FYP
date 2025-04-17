import 'package:carbon_quiz_app/Service/auth_service.dart';
import 'package:carbon_quiz_app/Views/login_screen.dart';
import 'package:carbon_quiz_app/Widgets/my_button.dart';
import 'package:carbon_quiz_app/Widgets/snackbar.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}


class _SignupScreenState extends State <SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPassWordHidden = true;
  final AuthService _authService = AuthService();

  //signup fn. to handle user registration:
  void _signUp() async {
    setState( () {
      isLoading = true;
    });

    //call method
    final result = await _authService.signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text
    );

    if (result == "success") {
      setState( () {
        isLoading = false;
      });

      //Navigate to the next screen with message
      showSnackBar(context, "SignUp Successful :) Please go to Login Page!");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>const LoginScreen() )
        );
    } else {
      setState( () {
        isLoading = false;
      });
      showSnackBar(context, "SignUp Failed $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:Column(
            children: [
              Image.asset("assets/house.JPG"),

              const SizedBox(height: 20),
              //input field for name,
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(), 
                ),
                ),

              const SizedBox(height: 20),
              //input field for username,
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "UserName",
                  border: OutlineInputBorder(), 
                ),
                ),
                 
                 const SizedBox(height: 20),
                 //input field for password,
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "PassWord",
                  border: const OutlineInputBorder(), 
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        isPassWordHidden = !isPassWordHidden;
                      });
                    }, 
                    icon: Icon(isPassWordHidden ?Icons.visibility_off : Icons.visibility),
                  )
                ),
                obscureText: isPassWordHidden ,
                ),

              const SizedBox(height: 20),
              //SignUp Button
              isLoading ? const Center(
                child: CircularProgressIndicator(),
                )
              : SizedBox(
                width: double.infinity,
                child: MyButton(onTap: _signUp, buttontext: "SignUp")             
                ),

              const SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text( "Already have an account? ",
                  style: TextStyle(fontSize: 18)
                  ),
                  GestureDetector(
                    onTap: (){
                        Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context)=> const LoginScreen(),),
                        );
                    },
                    child: const Text (
                      "Login Here",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: -1,
                      )
                    )
                  )
                ]
              )


              ]
            )
        ))
    );
  }
}






































