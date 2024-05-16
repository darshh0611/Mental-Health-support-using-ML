class Answers {
  double? dailyStress110;
  String? stressCauses;
  String? behavioralEffects;
  String? psychologicalEffects;
  String? cognitiveEffects;
  String? socialEffects;
  String? stressRelievers;
  int? stressHandling110;
  String? pressingAcademicStressors;

  Answers(
      {this.dailyStress110,
        this.stressCauses,
        this.behavioralEffects,
        this.psychologicalEffects,
        this.cognitiveEffects,
        this.socialEffects,
        this.stressRelievers,
        this.stressHandling110,
        this.pressingAcademicStressors});

  Answers.fromJson(Map<String, dynamic> json) {
    dailyStress110 = json['Daily Stress (1-10)'];
    stressCauses = json['Stress Causes'];
    behavioralEffects = json['Behavioral Effects'];
    psychologicalEffects = json['Psychological Effects'];
    cognitiveEffects = json['Cognitive Effects'];
    socialEffects = json['Social Effects'];
    stressRelievers = json['Stress Relievers'];
    stressHandling110 = json['Stress Handling (1-10)'];
    pressingAcademicStressors = json['Pressing Academic Stressors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Daily Stress (1-10)'] = this.dailyStress110;
    data['Stress Causes'] = this.stressCauses;
    data['Behavioral Effects'] = this.behavioralEffects;
    data['Psychological Effects'] = this.psychologicalEffects;
    data['Cognitive Effects'] = this.cognitiveEffects;
    data['Social Effects'] = this.socialEffects;
    data['Stress Relievers'] = this.stressRelievers;
    data['Stress Handling (1-10)'] = this.stressHandling110;
    data['Pressing Academic Stressors'] = this.pressingAcademicStressors;
    return data;
  }
}