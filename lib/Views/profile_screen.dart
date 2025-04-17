import 'package:carbon_quiz_app/Views/login_screen.dart';
import 'package:carbon_quiz_app/Widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  Map <String, dynamic>? userData;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

// Get data
  Future <void> fetchUserData() async {
    if (user == null) return;
    try{
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("userData").doc(user!.uid).get();

      if (documentSnapshot.exists) {
        setState(() {
          userData = documentSnapshot.data() as Map<String, dynamic>?;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //For SignOut
  Future <void> SignOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => const LoginScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Colors.white,
      body: isLoading? Center(  
        child: CircularProgressIndicator(), 
      )
      :userData == null ? const Center(  
        child: Text("No User Data Found :("),
      )
      : Padding(  
        padding: const EdgeInsets.symmetric(),
        child: Column(  
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
          // GestureDetector(
          //   child: CircleAvatar(
          //     backgroundColor: Colors.blue[100],
          //     radius: 60,
          //     backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png") as ImageProvider,
            
          //   child: const Align( 
          //     alignment: Alignment.bottomRight,
          //     child: CircleAvatar(
          //       backgroundColor: Colors.black,
          //       radius: 16,
          //       child: Icon(  
          //         Icons.camera_alt,
          //         size: 20,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          //   ),
          // ),
        Stack ( 
          children: [    
            Image.asset("forest.jpg",
            width: double.maxFinite,
            height: 200,
            fit: BoxFit.cover),

            const Positioned(
              top: 70,
              right: 150,
              left: 180,
              child: Text(  
                "PROFILE",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                )
              )
            )
          ],
          ),

          SizedBox(height: 100),
          Text(
            userData?['name'].toUpperCase(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300
            )
          ),

          const SizedBox(height:8),
          Text('Score: ${userData?['score']}',
            style: const TextStyle(  
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          ),

          const SizedBox(height: 2),
          const Divider(),
          const SizedBox(height: 15),
          Row(  
            children: [  
              Expanded(  
                child: MyButton(
                  onTap: SignOut, 
                  buttontext: 'Sign Out'),
              )
            ],
          )


        ])
      )
    );

  }
}