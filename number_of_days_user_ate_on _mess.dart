class leave {
  DateTime? dateto;
  DateTime? datefrom;

  leave({this.datefrom, this.dateto});
}

void main() {
  DateTime signedin = DateTime(2023, 12, 27);
  double? totalDays = 0;

  DateTime now = DateTime(2024, 1, 25);
  List<leave> datePairs = [];
  datePairs
      .add(leave(datefrom: DateTime(2022, 1, 2), dateto: DateTime(2022, 1, 4)));
  datePairs.add(
      leave(datefrom: DateTime(2024, 1, 7), dateto: DateTime(2024, 1, 17)));

// datePairs.add(leave(datefrom: DateTime(2022, 3, 20), dateto: DateTime(2022, 3, 25)));

  if (datePairs.length != 0) {
    for (var pair in datePairs) {
      if ((now.isBefore(pair.datefrom!))) {
        totalDays = totalDays! + pair.dateto!.difference(now).inDays;
        break;
      } else
        totalDays = totalDays! + pair.dateto!.difference(pair.datefrom!).inDays;
    }

    int daysFromNow = now.difference(signedin).inDays;
    print('totaldates: $daysFromNow');
    print('no of days levae taken : $totalDays');
    var result = (daysFromNow - totalDays!).abs();

    print('final result :$result');
  }
}
