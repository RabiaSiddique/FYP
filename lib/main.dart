// import 'package:carbon_quiz_app/Data/quiz_questions.dart';
import 'package:carbon_quiz_app/Data/quiz_questions.dart';
import 'package:carbon_quiz_app/Views/login_screen.dart';
import 'package:carbon_quiz_app/Views/navbar_cat_selection.dart';
import 'package:carbon_quiz_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  //Will help detect system so if app on android it'll be on android, if ios then ios system etc.
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const carbon_quiz_app());
}

class carbon_quiz_app extends StatelessWidget {
  const carbon_quiz_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //for keep user login untill user logout
      home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active){
          if (snapshot.hasData) {
        return const NavbarCatSelection();
          } else {
        return const LoginScreen();
        }
      } 
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ) 
        );
      } 

      )
      );
 //Material APP
  }
}












// // Upload questions to Firebase using base application. Credit to Nabin paudyal for their help in this method.

// class UploadDataInFirebase extends StatelessWidget {
//   const UploadDataInFirebase({super.key});
  
//    @override
//   //Create button to quickly upload data to firebase
// Widget build(BuildContext context) {
//   return MaterialApp(
//     home: Scaffold (
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {uploadQuestionsToFirebase();},
//           child: const Text("Upload Data"),
//           ),
//       ),
//     ),
//   );
// }
// }





