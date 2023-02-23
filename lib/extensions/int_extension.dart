extension IntExtension on int {
  int convertToHoursFromSeconds() => (this / 3600).floor();
  int convertToMinutesFromSeconds() => ((this % 3600) / 60).floor();
  int convertToSecondsFromSeconds() => this % 60;
}
