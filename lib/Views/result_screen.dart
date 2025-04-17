import 'package:carbon_quiz_app/Views/navbar_cat_selection.dart';
import 'package:carbon_quiz_app/Widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; 

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestion;
  const ResultScreen({super.key, required this.score, required this.totalQuestion});

// Future <void> _updateUserScore() async {
//   var user = FirebaseAuth.instance.currentUser;
//   if (user == null) return;

//   try{
//     var userRef = FirebaseFirestore.instance.collection("userData").doc(user.uid);
//     await FirebaseFirestore.instance.runTransaction( (transaction) async {
//         var snapshot = await transaction.get(userRef);
//         if (!snapshot.exists) return;
//         int existingScore = snapshot['score'] ?? 0;
//         transaction.update(userRef, {'score': existingScore + score});
//       });
//   } catch (e) {
//     debugPrint('error update in score $e');
//   }
// }

//final update of score:
Future <void> _updateUserScore() async {
  User? user = FirebaseAuth.instance.currentUser;
  Map <String, dynamic>? userData;

  if (user == null) return;
  try{
    DocumentReference userRef = FirebaseFirestore.instance.collection("userData").doc(user.uid);
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("userData").doc(user!.uid).get();
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userRef);

      documentSnapshot.get('score');
    
      if (!snapshot.exists) { 
        throw Exception('User does not exist');
      } 
      int existingScore = snapshot['score'] ?? 0;
      transaction.update(userRef, {'score': existingScore + score});
    });

  } catch (e) {
    print(e.toString());
      }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        title: const Text('Score'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(  
        child: Padding(  
          padding: const EdgeInsets.all(15),
          child: Column( 
            children: [
              Stack(
                children: [ 
                  // Lottie.network("https://lottie.host/b13c3fe9-7119-46b1-a007-24d9d712ccc6/6dMF0rgRBd.lottie", height: 200, width: 300, fit: BoxFit.cover, ),
                  // Lottie.network("https://lottie.host/b13c3fe9-7119-46b1-a007-24d9d712ccc6/6dMF0rgRBd.lottie", height: 200, width: 300, fit: BoxFit.cover, )
                  Image.network("https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExazVmeHBxMDI5MHI1empwd2FxdGh2OXNiczV4empiOGg5ZnFwN29yZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/dt54M1Cz0XkWtGJ13m/giphy.gif")
                
                ]

              ),
              const SizedBox(height: 50),
              Text (
                'Question Complete!',
                 style: TextStyle(fontSize: 22)
                ),

                const SizedBox(height:20),
                Text (
                  'Your streak increased by $score', 
                  style: const TextStyle(fontSize: 22),
                ),

                const SizedBox(height: 30),
                Row(  
                  children: [  
                    Expanded(  
                      child: MyButton(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context) => const NavbarCatSelection(initialIndex: 1,),),
                            (route) => false
                            );
                        },
                        buttontext: 'Back to Leaderboard!'),
                    )
                  ]
                )
            ]
          )
        )
      )
    );

  }
}