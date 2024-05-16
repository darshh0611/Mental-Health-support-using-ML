# IPD (Integrated Mental Health Predictor) Flutter App

# 1. Overview:

The IPD Flutter app is a powerful tool designed to help users track and manage their mental health effectively. With its intuitive interface and comprehensive features, the app provides users with valuable insights and personalized recommendations for improving their well-being.

# 2. Key Features:

a. Stress Tracking: Users can log their daily stress levels using the stress questionnaire feature. The app provides a set of questions to assess various aspects of stress, allowing users to track their stress levels over time.

b. Activity Tracking: The app includes features for tracking daily activities such as sleep patterns, exercise routines, and journal entries. By monitoring these activities, users can identify patterns and correlations with their mental health.

c. Mental Health Score: Based on the data collected from stress questionnaires and activity tracking, the app generates a mental health score for the user (hidden from the user). This score provides a holistic view of the user's mental well-being and enables them to monitor their progress over time.

d. Personalized Insights: The app offers personalized insights and recommendations based on the user's mental health score and activity data. Users receive actionable tips and suggestions for improving their mental well-being, tailored to their individual needs and preferences.

e. Integration with ML Model: Behind the scenes, the app leverages a machine learning model to analyze user data and predict mental health scores. This integration enables the app to provide accurate assessments and personalized recommendations for each user.

# 3. Future Enhancements:

a. Community Support: Introduce features for users to connect with peers, share experiences, and access support resources within the app.

b. Advanced Analytics: Enhance the app's analytics capabilities to provide deeper insights into factors influencing mental health and well-being.

c. Integration with Wearable Devices: Integrate with wearable devices to gather additional data such as heart rate variability and activity levels, further enhancing the accuracy of mental health assessments.

d. Expanded Questionnaire: Expand the questionnaire to include additional factors that contribute to mental health, such as nutrition, social interactions, and environmental factors.

e. Gamification Elements: Incorporate gamification elements to make the app more engaging and encourage users to maintain healthy habits and routines.

# 4. Dataset

The data set used for training the data is [data.csv](ML/dataset/data.csv).
Other datasets in the dataset folder were used initially and the [data.csv](ML/dataset/data.csv) is made in reference to those datasets.

# 5. Model

The model used to detecting the mental health score is [final.pkl](ML/models/final.pkl)
All the other models in the models directory were used earlier and was replaced by this single file.

The training notebook is [training.ipynb](ML/training.ipynb), contains all the pre-processing and training and testing code.

# 6. Server

The model is run through the [flask_server.py](ML/flask_server.py), make sure to change the loaded model's path before running. 

The server for integrating model with mobile app is run through ngrok, located in gitignore for this branch.
For details checkout their official documentation.

 [ngrok](https://ngrok.com/docs)

# 7. Disclaimer:

This app is not intended to diagnose or treat any medical condition. Users are advised to consult with healthcare professionals for personalized medical advice and treatment.

# 8. Contributors:

[darshh0611] (https://github.com/darshh0611) - ML 

[neminsheth] (https://github.com/neminsheth) - Flutter


# Privacy 
© 2024. All rights reserved. 

(Code available to use for non-commercial purposes ONLY.)

Licensed under MIT license.

