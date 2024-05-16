from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)

model = joblib.load(r"D:\v\final.pkl") 

def preprocess_input(data):

    df = pd.DataFrame(data, index=[0])

    categorical_features = ['Stress Causes', 'Behavioral Effects', 'Psychological Effects', 
                            'Cognitive Effects', 'Social Effects', 'Stress Relievers', 
                            'Pressing Academic Stressors']

  
    numeric_features = ['Daily Stress (1-10)', 'Stress Handling (1-10)']

#pre-processing

    cat_df = df[categorical_features].fillna('missing')

    num_df = df[numeric_features].fillna(df[numeric_features].median())

    processed_data = pd.concat([cat_df, num_df], axis=1)

    return processed_data

@app.route('/predict', methods=['POST'])
def predict():

    data = request.json
    
    processed_data = preprocess_input(data)

    prediction = model.predict(processed_data)

    return jsonify({'predicted_stress_level': prediction[0]})

if __name__ == '__main__':
    app.run(debug=True)

