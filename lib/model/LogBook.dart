import '../model/Data.dart';

/// Abstract class for user's various log books.
abstract class LogBook {
  /// Gets data to create chart on home page.
  List<Data> getHomePageData() {
    List<Data> chartData = logBookToData();
    int end = chartData.length >= 7 ? 7 : chartData.length;
    return chartData.sublist(0, end);
  }

  /// Gets data to create chart on log book page.
  List<Data> getLogBookPageData() {
    List<Data> chartData = logBookToData();
    return chartData;
  }

  /// Get records for the charts.
  List<Data> logBookToData();

  /// Get records for displaying log book.
  List<List<String>> getListOfRecords();
}