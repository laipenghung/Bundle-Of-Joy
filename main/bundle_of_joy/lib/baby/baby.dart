import 'package:cloud_firestore/cloud_firestore.dart';

class Baby {
  String b_id, m_id, b_registered_id, b_name, b_place_of_birth, b_gender, b_age, b_bloodType, b_mode_of_delivery;
  double b_weight_at_birth, b_length_at_birth, b_head_circumference;
  int b_order;
  Timestamp b_dob;

  Baby(
      this.b_id,
      this.m_id,
      this.b_registered_id,
      this.b_name,
      this.b_dob,
      this.b_place_of_birth,
      this.b_gender,
      this.b_age,
      this.b_bloodType,
      this.b_mode_of_delivery,
      this.b_weight_at_birth,
      this.b_length_at_birth,
      this.b_head_circumference,
      this.b_order);
}