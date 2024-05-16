import joblib
import numpy as np
from sklearn.ensemble import RandomForestRegressor

def load_model():
    model = joblib.load("my_stress_model.pkl")
    return model

def stress_level(features, weights, questions, options):
    stress_level = 0
    for question, weight in weights.items():
        if question in [1, 2]:
            print(questions[question])
            for i, option in enumerate(options[question]):
                print(f"{i+1}. {option}")
            answer = int(input("Enter your choice: "))
        else:
            print(questions[question])
            if question in [4, 5, 6, 7, 8, 9, 11]:
                print("Select multiple options separated by commas")
                for i, option in enumerate(options[question]):
                    print(f"{i+1}. {option}")
                answers = input("Enter your choices: ").split(",")
                stress_level += len(answers) * weight
            else:
                answer = int(input("Enter your choice: "))
                stress_level += answer * weight

    return round(stress_level / sum(weights.values()), 2)

def model_prediction():
    return np.random.uniform()

def conduct_questionnaire():
# Define the questions
    questions = {
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
    }

    options = {
        1: ["Freshman (Undergrad)", "Sophomore (Undergrad)", "Junior (Undergrad)", "Senior (Undergrad)", "Graduate student", "Other"],
        2: ["Female", "Male", "Other / I prefer not to respond"],
        3:  list(range(1, 11)),
        4: ["Studies issues", "Financial issues", "Family issues", "Friends issues", "Issues with the significant other (partner)", "Work (job-related) issues", "Health Related Issues", "Sports / Athletics activities issues", "My involvement in clubs and organizations", "Other"],
        5: ["Change in activity levels", "Decreased efficiency and effectiveness", "Difficulty communicating", "Increased sense of humor/gallows humor", "Irritability, outbursts of anger, frequent arguments", "Inability to rest, relax or let down", "Change in eating habits", "Change in sleep patterns", "Change in activity performance", "Periods of crying", "Increased use of tobacco, alcohol, drugs, sugar or caffeine", "Hyper-vigilance about safety or the surrounding environment", "Avoidance of activities or places that trigger memories", "Accident prone", "Other"],
        6: ["Feeling heroic, euphoric or invulnerable", "Denial", "Anxiety or fear", "Worry about safety of self or others", "Irritability or anger", "Restlessness", "Sadness, moodiness, grief or depression", "Vivid or distressing dreams", "Guilt or 'survivor guilt'", "Feeling overwhelmed, helpless or hopeless", "Feeling isolated, lost, lonely or abandoned", "Apathy", "Over-identification with survivors", "Feeling misunderstood or unappreciated", "None of the Above", "Other"],
        7: ["Memory problems/forgetfulness", "Disorientation", "Confusion", "Slowness in thinking, analyzing, or comprehending", "Difficulty calculating, setting priorities or making decisions", "Difficulty Concentrating", "Limited attention span", "Loss of objectivity", "Inability to stop thinking about the disaster or an incident", "None of the Above", "Other"],
        8: ["Withdrawing or isolating from people", "Difficulty listening", "Difficulty sharing ideas", "Difficulty engaging in mutual problem solving", "Blaming", "Criticizing", "Intolerance of group process", "Difficulty in giving or accepting support or help", "Impatient with or disrespectful to others", "None of the Above", "Other"],
        9: ["Eating", "Sleeping", "Drinking", "Drugs", "Sports / Exercise", "Talking with someone", "Shopping", "Computer Games", "Social Media", "None of the Above", "Other"],
        10: list(range(1, 11)),
        11: ["Study workload", "Grades", "Financial pressure (e.g. tuition, living costs)", "Work (and Study) - Life balance", "Relationship with (some) faculty members", "Relationship with other students", "Campus social life", "Other"]
    }

    weights = {
    1: 0, 
    2: 0,
    3: 6,  
    4: 4,  
    5: 6,  
    6: 7,  
    7: 3,  
    8: 5,  
    9: 4, 
    10: 7,  
    11: 6   
}

    random_forest_model = load_model()

    features = []
    features_array = np.array(features).reshape(1, -1) 
    f_model_prediction = model_prediction()
    final_stress_level = stress_level(features, weights, questions, options)

    print("Your final stress level is:", final_stress_level)

if __name__ == "__main__":
    conduct_questionnaire()
