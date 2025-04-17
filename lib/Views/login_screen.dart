import 'package:carbon_quiz_app/Service/auth_service.dart';
import 'package:carbon_quiz_app/Views/navbar_cat_selection.dart';
import 'package:carbon_quiz_app/Views/signup_screen.dart';
import 'package:carbon_quiz_app/Widgets/my_button.dart';
import 'package:carbon_quiz_app/Widgets/snackbar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State <LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPassWordHidden = true;
  final AuthService _authService = AuthService();

  //login fn. to handle user registration:
  void _login() async {
    setState( () {
      isLoading = true;
    });

    //call method
    final result = await _authService.loginUser(
      email: emailController.text,
      password: passwordController.text,

    );
    if (result == "success") {
      setState( () {
        isLoading = false;
      });

      //Navigate to the next screen with message
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>const NavbarCatSelection() )
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
              Image.asset("assets/wave.png"),

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
              //Login Button
              SizedBox(
                width: double.infinity,
                child: MyButton(onTap: _login, buttontext: "Login")             
                ),

              const SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text( "Don't have an account? ",
                  style: TextStyle(fontSize: 18)
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context)=> const SignupScreen(),),
                        );
                    },
                    child: const Text (
                      "Make an Account Here",
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



















