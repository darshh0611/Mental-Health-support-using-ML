import 'dart:io';

double stressLevel(Map<int, String> questions, Map<int, List<String>> options, Map<int, int> weights, List<List<String>> answers) {
  double totalStressLevel = 0;
  double totalWeight = 0;

  for (var question in weights.keys) {
    if (question == 1 || question == 2 || question == 10) {
      int? answer = int.tryParse(answers[question - 1].first);
      if (answer != null) {
        totalStressLevel += answer * weights[question]!;
        totalWeight += weights[question]!;
      }
    } else {
      totalStressLevel += answers[question - 1].length * weights[question]!;
      totalWeight += weights[question]!;
    }
  }

  // Normalize the total stress level
  double normalizedStressLevel = totalStressLevel / totalWeight;

  // Cap the normalized stress level at 10 if it exceeds
  normalizedStressLevel = normalizedStressLevel > 10 ? 10 : normalizedStressLevel;

  // Adjust the normalized stress level to fit within the range [1, 10]
  normalizedStressLevel = 1 + ((normalizedStressLevel - 1) * (9 / 10));

  return normalizedStressLevel;
}



double conductQuestionnaire(List<List<String>> answers) {
  // Define the questions, options, and weights
  var questions = {
    1: "Your current class level is:",
    2: "Your gender is:",
    3: "How stressed do you feel on a daily basis during the academic year? (1-10)",
    4: "What are the usual causes of stress in your life?",
    5: "What are the usual behavioral effects of stress you've noticed at yourself?",
    6: "What are the usual psychological or emotional effects of stress you've noticed at yourself?",
    7: "What are the usual cognitive effects of stress you've noticed at yourself?",
    8: "What are the usual social effects of stress you've noticed at yourself?",
    9: "What are your personal methods to relieve stress?",
    10: "How able do you feel to handle stress when you are experiencing it? (1-10)",
    11: "What are the most pressing stress factors in your current academic context?"
  };

  var options = {
    1: ["Freshman (Undergrad)", "Sophomore (Undergrad)", "Junior (Undergrad)", "Senior (Undergrad)", "Graduate student", "Other"],
    2: ["Female", "Male", "Other / I prefer not to respond"],
    3: List.generate(10, (index) => (index + 1).toString()),
    4: ["Studies issues", "Financial issues", "Family issues", "Friends issues", "Issues with the significant other (partner)", "Work (job-related) issues", "Health Related Issues", "Sports / Athletics activities issues", "My involvement in clubs and organizations", "Other"],
    5: ["Change in activity levels", "Decreased efficiency and effectiveness", "Difficulty communicating", "Increased sense of humor/gallows humor", "Irritability, outbursts of anger, frequent arguments", "Inability to rest, relax or let down", "Change in eating habits", "Change in sleep patterns", "Change in activity performance", "Periods of crying", "Increased use of tobacco, alcohol, drugs, sugar or caffeine", "Hyper-vigilance about safety or the surrounding environment", "Avoidance of activities or places that trigger memories", "Accident prone", "Other"],
    6: ["Feeling heroic, euphoric or invulnerable", "Denial", "Anxiety or fear", "Worry about safety of self or others", "Irritability or anger", "Restlessness", "Sadness, moodiness, grief or depression", "Vivid or distressing dreams", "Guilt or 'survivor guilt'", "Feeling overwhelmed, helpless or hopeless", "Feeling isolated, lost, lonely or abandoned", "Apathy", "Over-identification with survivors", "Feeling misunderstood or unappreciated", "None of the Above", "Other"],
    7: ["Memory problems/forgetfulness", "Disorientation", "Confusion", "Slowness in thinking, analyzing, or comprehending", "Difficulty calculating, setting priorities or making decisions", "Difficulty Concentrating", "Limited attention span", "Loss of objectivity", "Inability to stop thinking about the disaster or an incident", "None of the Above", "Other"],
    8: ["Withdrawing or isolating from people", "Difficulty listening", "Difficulty sharing ideas", "Difficulty engaging in mutual problem solving", "Blaming", "Criticizing", "Intolerance of group process", "Difficulty in giving or accepting support or help", "Impatient with or disrespectful to others", "None of the Above", "Other"],
    9: ["Eating", "Sleeping", "Drinking", "Drugs", "Sports / Exercise", "Talking with someone", "Shopping", "Computer Games", "Social Media", "None of the Above", "Other"],
    10: List.generate(10, (index) => (index + 1).toString()),
    11: ["Study workload", "Grades", "Financial pressure (e.g. tuition, living costs)", "Work (and Study) - Life balance", "Relationship with (some) faculty members", "Relationship with other students", "Campus social life", "Other"]
  };

  var weights = {
    1: 0,
    2: 0,
    3: 6,
    4: 4,
    5: 6,
    6: 7,
    7: 3,
    8: 5,
    9: 4,
    10: 5,
    11: 6
  };

  double finalStressLevel = stressLevel(questions, options, weights, answers);
  return finalStressLevel;
}
