import './LogBook.dart';
import './FoodRecord.dart';

class FoodLogBook extends LogBook {
  List<FoodRecord> foodRecords;

  FoodLogBook(String email) : super(email: email);
}
