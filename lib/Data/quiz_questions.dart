// import 'package:cloud_firestore/cloud_firestore.dart';

// class UploadQuestions {
//   // Function to upload questions
//   Future<void> uploadQuestionsToExistingProject() async {
//     try {
//       // List of questions with options and correct answers
//       final questions = [
//         {
//           'question': 'What is the leading cause of global warming?',
//           'options': [
//             'Burning fossil fuels',
//             'Deforestation',
//             'Overfishing',
//             'Ozone layer depletion'
//           ],
//           'correctAnswerIndex': 0
//         },
//         {
//           'question': 'Which greenhouse gas is primarily responsible for climate change?',
//           'options': ['Carbon dioxide', 'Methane', 'Nitrous oxide', 'Water vapor'],
//           'correctAnswerIndex': 0
//         },
//         {
//           'question': 'What is a major effect of rising global temperatures?',
//           'options': [
//             'Increased biodiversity',
//             'Rising sea levels',
//             'Stabilized weather patterns',
//             'Expansion of polar ice'
//           ],
//           'correctAnswerIndex': 1
//         },
//         {
//           'question': 'How can individuals reduce their carbon footprint?',
//           'options': [
//             'Use renewable energy',
//             'Increase plastic use',
//             'Drive more often',
//             'Use single-use products'
//           ],
//           'correctAnswerIndex': 0
//         },
//         {
//           'question': 'Which international agreement aims to combat climate change?',
//           'options': [
//             'Kyoto Protocol',
//             'Montreal Protocol',
//             'Geneva Convention',
//             'Paris Agreement'
//           ],
//           'correctAnswerIndex': 3
//         },
//       ];

//       // Use Firestore instance from the existing Firebase project
//       final firestore = FirebaseFirestore.instance;

//       // Upload each question
//       for (var question in questions) {
//         await firestore.collection('quizQuestions').add(question);
//       }

//       print('Questions successfully uploaded to the existing Firebase project!');
//     } catch (e) {
//       print('Error uploading questions: $e');
//     }
//   }
// }

// void main() async {
//   final uploader = UploadQuestions();
//   await uploader.uploadQuestionsToExistingProject();
// }


import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadQuestionsToFirebase() async {
  for (final sector in data.entries) {
    uploadQuestionsForAField(
      sector.key,
    sector.value);
  }
}


Future<void> uploadQuestionsForAField(String field, dynamic data) async {
  FirebaseFirestore.instance.collection('ListOfQuestions').doc(field).set(data);
}

// List of questions with options and correct answers
final data = {
   "Flutter": {
    "title": "Questions",
    "image_url": "https://cdn2.vectorstock.com/i/1000x1000/70/46/confused-earth-character-with-question-mark-vector-30307046.jpg",
    "questions": {
  "0": {
    "correctOptionKey": "1",
    "options": {
      "1": "Burning fossil fuels",
      "2": "Deforestation",
      "3": "Overfishing",
      "4": "Ozone layer depletion"
    },
    "questionText": "What is the leading cause of global warming?"
  },
  "1": {
    "correctOptionKey": "2",
    "options": {
      "1": "Recycling more",
      "2": "Planting more trees",
      "3": "Increasing meat consumption",
      "4": "Driving fuel-powered cars"
    },
    "questionText": "Which of the following helps combat climate change?"
  },
  "2": {
    "correctOptionKey": "3",
    "options": {
      "1": "Coal",
      "2": "Natural gas",
      "3": "Solar energy",
      "4": "Oil"
    },
    "questionText": "Which energy source is considered renewable?"
  },
  "3": {
    "correctOptionKey": "1",
    "options": {
      "1": "Greenhouse gases",
      "2": "Oxygen",
      "3": "Nitrogen",
      "4": "Helium"
    },
    "questionText": "What do fossil fuels primarily emit when burned?"
  },
  "4": {
    "correctOptionKey": "4",
    "options": {
      "1": "Plastic pollution",
      "2": "Desertification",
      "3": "Increasing urbanization",
      "4": "Melting ice caps"
    },
    "questionText": "Which of the following is a direct consequence of global warming?"
  },
  "5": {
    "correctOptionKey": "1",
    "options": {
      "1": "Wind",
      "2": "Coal",
      "3": "Diesel",
      "4": "Gasoline"
    },
    "questionText": "Which energy source does not produce carbon emissions during use?"
  },
  "6": {
    "correctOptionKey": "3",
    "options": {
      "1": "Deforestation",
      "2": "Mining coal",
      "3": "Using biofuels",
      "4": "Burning plastics"
    },
    "questionText": "Which practice is considered more sustainable for energy production?"
  },
  "7": {
    "correctOptionKey": "2",
    "options": {
      "1": "Carbon monoxide",
      "2": "Carbon dioxide",
      "3": "Methane",
      "4": "Oxygen"
    },
    "questionText": "Which gas is most responsible for trapping heat in the Earth's atmosphere?"
  },
  "8": {
    "correctOptionKey": "3",
    "options": {
      "1": "Coal plants",
      "2": "Gas turbines",
      "3": "Hydroelectric dams",
      "4": "Oil refineries"
    },
    "questionText": "Which of the following generates electricity without greenhouse gas emissions?"
  },
  "9": {
    "correctOptionKey": "2",
    "options": {
      "1": "Harm the environment",
      "2": "Reduce carbon footprints",
      "3": "Increase deforestation",
      "4": "Cause more pollution"
    },
    "questionText": "What is a key benefit of carbon neutrality?"
  },
  "10": {
    "correctOptionKey": "4",
    "options": {
      "1": "Burning more fossil fuels",
      "2": "Expanding landfills",
      "3": "Using non-renewable resources",
      "4": "Switching to electric vehicles"
    },
    "questionText": "Which action can help reduce emissions?"
  },
  "11": {
    "correctOptionKey": "1",
    "options": {
      "1": "Solar panels",
      "2": "Coal mining",
      "3": "Fracking",
      "4": "Oil drilling"
    },
    "questionText": "Which technology converts sunlight into electricity?"
  },
  "12": {
    "correctOptionKey": "3",
    "options": {
      "1": "Gasoline-powered cars",
      "2": "Diesel generators",
      "3": "Wind turbines",
      "4": "Oil refineries"
    },
    "questionText": "Which of the following generates clean energy?"
  },
  "13": {
    "correctOptionKey": "2",
    "options": {
      "1": "Increasing pesticide use",
      "2": "Using organic farming methods",
      "3": "Reducing tree planting",
      "4": "Expanding urban areas"
    },
    "questionText": "What is one way to make food production more sustainable?"
  },
  "14": {
    "correctOptionKey": "1",
    "options": {
      "1": "Using energy-efficient appliances",
      "2": "Burning more fossil fuels",
      "3": "Wasting resources",
      "4": "Ignoring climate policies"
    },
    "questionText": "Which action can improve sustainability at home?"
  },
  "15": {
    "correctOptionKey": "3",
    "options": {
      "1": "Mining coal",
      "2": "Expanding deforestation",
      "3": "Building solar farms",
      "4": "Using more plastic"
    },
    "questionText": "Which action contributes to cleaner energy production?"
  },
  "16": {
    "correctOptionKey": "4",
    "options": {
      "1": "Coal",
      "2": "Natural gas",
      "3": "Petroleum",
      "4": "Geothermal energy"
    },
    "questionText": "Which energy source is derived from heat within the Earth?"
  },
  "17": {
    "correctOptionKey": "2",
    "options": {
      "1": "Higher carbon emissions",
      "2": "Reduced reliance on fossil fuels",
      "3": "Increased air pollution",
      "4": "Faster deforestation"
    },
    "questionText": "What is a major benefit of using renewable energy sources?"
  },
  "18": {
    "correctOptionKey": "3",
    "options": {
      "1": "Nuclear power plants",
      "2": "Coal-burning factories",
      "3": "Solar farms",
      "4": "Diesel engines"
    },
    "questionText": "Which of the following produces clean energy with minimal environmental impact?"
  },
  "19": {
    "correctOptionKey": "1",
    "options": {
      "1": "Reducing meat consumption",
      "2": "Using more plastic packaging",
      "3": "Expanding industrial farming",
      "4": "Ignoring deforestation concerns"
    },
    "questionText": "Which lifestyle change can help reduce greenhouse gas emissions?"
  },
  "20": {
    "correctOptionKey": "2",
    "options": {
      "1": "Ocean acidification",
      "2": "Rising global temperatures",
      "3": "Increased oxygen levels",
      "4": "Growing polar ice caps"
    },
    "questionText": "What is a major consequence of excessive carbon emissions?"
  },
  "21": {
    "correctOptionKey": "3",
    "options": {
      "1": "Using single-use plastics",
      "2": "Cutting down forests",
      "3": "Switching to sustainable materials",
      "4": "Increasing fossil fuel consumption"
    },
    "questionText": "How can businesses reduce their environmental footprint?"
  },
  "22": {
    "correctOptionKey": "1",
    "options": {
      "1": "A carbon tax",
      "2": "Increased use of coal",
      "3": "Deforestation subsidies",
      "4": "Less regulation on air pollution"
    },
    "questionText": "Which policy measure can help reduce carbon emissions?"
  },
  "23": {
    "correctOptionKey": "4",
    "options": {
      "1": "Plastic waste",
      "2": "Chemical runoff",
      "3": "Air pollution",
      "4": "Overuse of natural resources"
    },
    "questionText": "What is a major challenge of unsustainable consumption?"
  },
  "24": {
    "correctOptionKey": "2",
    "options": {
      "1": "Ignoring climate change",
      "2": "Investing in renewable energy",
      "3": "Using more fossil fuels",
      "4": "Increasing greenhouse gas emissions"
    },
    "questionText": "Which action supports a transition to a greener economy?"
  },
  "25": {
    "correctOptionKey": "3",
    "options": {
      "1": "Burning fossil fuels",
      "2": "Cutting down trees",
      "3": "Promoting energy efficiency",
      "4": "Using non-recyclable materials"
    },
    "questionText": "How can individuals contribute to sustainability?"
  }

}

    }
  }
;























