class Data {
  final DateTime dateTime;
  final double y;

  Data({
    this.dateTime,
    this.y,
  });
}

DateTime getMinDate(List<Data> list) {
  return list
      .reduce(
          (curr, next) => curr.dateTime.isBefore(next.dateTime) ? curr : next)
      .dateTime;
}

DateTime getMaxDate(List<Data> list) {
  return list
      .reduce(
          (curr, next) => curr.dateTime.isAfter(next.dateTime) ? curr : next)
      .dateTime;
}
