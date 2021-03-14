class FoodRecord {
  String date;
  String time;
  String foodName;
  int carbs; // in grams
  int calories; // in kcal
  double servingSize;
  String notes;

  FoodRecord(this.date, this.time, this.foodName, this.carbs, this.calories, this.servingSize, [this.notes = ""]);
}