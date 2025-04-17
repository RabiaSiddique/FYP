import 'dart:math';
import 'package:carbon_quiz_app/Views/login_screen.dart';
import 'package:carbon_quiz_app/Views/navbar_cat_selection.dart';
import 'package:carbon_quiz_app/Views/result_screen.dart';
import 'package:carbon_quiz_app/Widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List <Map<String, dynamic>> question = [];
  int currentIndex = 0,
  score = 0;
  int? selectedOption;
  bool hasAnswered = false,
  isLoading = true;
  
  @override
  void initState() {
    _fetchQuestions();
    super.initState();
  }

//To fetch the questions
  Future<void> _fetchQuestions() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("ListOfQuestions").doc("Flutter").get();

      if (snapshot.exists) {
        var data = snapshot.data(); 
        if (data!=null && data.containsKey("questions")) {
          var questionMap = data['questions'];

          if (questionMap is Map<String, dynamic>) {
            var fetchedQuestions = questionMap.entries.map( (entry) {
              var q = entry.value;
              var optionsMap = q['options'] as Map<String, dynamic>;
              var optionList = optionsMap.entries.toList()..sort(
              (a,b) => int.parse(a.key).compareTo(int.parse(b.key),)
            );
            var options = optionList.map((e) => e.value.toString()).toList();
            return {
              'questionText': q['questionText']??'No Question',
              'options': options,
              'correctOptionKey': int.tryParse(q['correctOptionKey'].toString())??0
            };
            }).toList();
            //shuffle and limit the questions asked
            fetchedQuestions.shuffle(Random()); //it shows the random question
            if (fetchedQuestions.length > 4) {
              fetchedQuestions = fetchedQuestions.sublist(0,4);
            }
            setState( () => question = fetchedQuestions);
              
          }
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
      isLoading = false;
      });
    }
  }

//Check the correct Answer:
void _checkAnswer(int index) {
  setState( () {
    hasAnswered = true;
    selectedOption = index;
    if (question[currentIndex]['correctOptionKey'] == index + 1 ) {
      score ++;
    } else {score = 0;}
  
  });
}

//Only Asking 1 question and going to result Screen:
Future<void> _nextQuestion() async {
  if (currentIndex <= 1) {
    await _updateUserScore();
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => ResultScreen(score: score, totalQuestion: question.length,))
    );
}
}

Future <void> _updateUserScore() async {
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  try{
    var userRef = FirebaseFirestore.instance.collection("userData").doc(user.uid);
    await FirebaseFirestore.instance.runTransaction( (transaction) async {
        var snapshot = await transaction.get(userRef);
        if (!snapshot.exists) return;
        int existingScore = snapshot['score'] ?? 0;
        transaction.update(userRef, {'score': existingScore + score});
      });
  } catch (e) {
    debugPrint('error update in score $e');
  }
}

@override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(  
        body: Center(  
          child: CircularProgressIndicator(),
        )
      );
    }



    if (question.isEmpty) {
      return const Scaffold(  

        body: const Center(  
          child: Text("No Questions Available"),
        ),
      );
    }

    return Scaffold (  

      body: Padding (  
        padding: EdgeInsets.all(15),
        child: Column(children: [
          //Image
          Image.asset("assets/globe_question_mark.png", height: 70),

          const SizedBox(height: 20),
          // For Question
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              question[currentIndex]['questionText'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color : Colors.blue
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          //For Options:
          const SizedBox(height: 30),
          Expanded(        
            child:  ListView.separated( 
            itemBuilder: (context, index) {
              return _buildOption(index);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemCount: question[currentIndex]['options'].length,
          )
        ),

        //conditionally render the finmish button:
        if (hasAnswered)
        MyButton(
          onTap: _nextQuestion,
         buttontext:"Finish",
         ),
        const SizedBox(height:200),

        ],)
      )
    );
  }

  Widget _buildOption(int index) {
    bool isCorrect = question[currentIndex]['correctOptionKey'] == index + 1;
    bool isSelected = selectedOption == index;
    Color bgColor = hasAnswered? (isCorrect ? Colors.green.shade300:isSelected?Colors.red.shade300: Colors.grey.shade200): Colors.grey.shade200;
    Color textColor = hasAnswered && (isCorrect || isSelected) ? Colors.white: Colors.black;
    return InkWell(
      onTap: hasAnswered? null: () => _checkAnswer(index),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal:12,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text (
          question[currentIndex]['options'][index],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: textColor
          )
        )
      )
    );
  }
}


