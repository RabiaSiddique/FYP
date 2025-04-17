import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

// Load data
  Stream<List<Map<String, dynamic>>> getLeaderboardData() {
    return FirebaseFirestore.instance.collection('userData').orderBy('score', descending: true).snapshots().map(  
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: getLeaderboardData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(  
              child: CircularProgressIndicator(),
            );
          }
          final users = snapshot.data!;
          if (users.isEmpty) {
            return Center (  
              child: Text("No Users Found."),
            );
          }

          final topThree = users.take(3).toList();
          // final remainingUsers = users.skip(3).toList();
          final remainingUsers = users.toList();

          return Column (  
            children: [
              //top 3 users:
              Stack(  
                children: [
                  Image.asset("tree.jpg",
                  width: double.maxFinite,
                  height: 200,
                  fit: BoxFit.cover),

                  const Positioned(
                    top: 70,
                    right: 140,
                    left: 140,
                    child: Text(  
                      "LEADERBOARD",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      )
                    )
                  ),

                 if (topThree.isNotEmpty)
                 Positioned(
                  top: 175,
                  right: 50,
                  left:50,
                  child: _buildTopUser(topThree[0], 1, context), )

                ],
              ), 
                //Remaining Users List:
                  Expanded(
                    child: ListView.builder(
                      itemCount: remainingUsers.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final user = remainingUsers[index];
                        final rank = index + 1;
                        return _buildRegularUser(user, rank, context);
                      },
                    )
                  )
            ]
          );
        }
      )
      );
  }

  Widget _buildTopUser(
    Map <String, dynamic> user, int rank, BuildContext context
  ){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(  
        children: [
          const SizedBox(height: 10),
          //for name:
          Text(
            user['name'].toUpperCase(),
            style: TextStyle(
              fontSize: rank == 1? 22: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),
          Container(  
            height: 30,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(  
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 5),
                Text(
                  "${user['score']}", 
                  style:(
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                )),

              

              ]
            ),

          ), 
        ]
      )
    );

  }

  Widget _buildRegularUser(
    Map <String, dynamic> user, int rank, BuildContext context
  ){
    return Padding(  
      padding: const EdgeInsets.all(15),
      child: Row(  
        children: [
          //Rank NUmber:
          Text(  
            '$rank',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            )
          ),

          const SizedBox(width: 16),
          //name of user
          Text(  
            user['name'].toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ), 
          
          const Spacer(),
          //Total Points
          Container(
            height: 30,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(  
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ 
                const SizedBox(
                  width: 5
                ), 
                Text(
                  "${user['score']}", 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black
                    )
                  )
              ]
            )
          )


        ]
      )
    );
  }
}