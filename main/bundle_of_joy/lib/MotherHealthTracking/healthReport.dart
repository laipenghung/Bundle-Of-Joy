class HealthReport {
  String mh_id, date, time;
  double bloodPressure, bloodSugar, height, weight;
  int dayOfPregnancy;

  HealthReport(String mh_id, String date, String time, double bloodPressure, double bloodSugar, double height, double weight, int dayOfPregnancy){
    this.mh_id = mh_id;
    this.date = date;
    this.time = time;
    this.bloodPressure = bloodPressure;
    this.bloodSugar = bloodSugar;
    this.height = height;
    this.weight = weight;
    this.dayOfPregnancy = dayOfPregnancy;
  }
}