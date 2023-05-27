class TimeUtils {
  static String getCurrentPosition(int seconds) {
    String hours;
    int timeHours = seconds ~/ (60 * 60);
    int timeMinutes = seconds ~/ 60 - (timeHours * 60);
    int timeSeconds = seconds - (timeHours * 60 * 60) - (timeMinutes * 60);

    if (timeHours > 9) {
      hours = '$timeHours';
    } else if (timeHours > 0 && timeHours < 10) {
      hours = '0$timeHours';
    } else {
      hours = '00';
    }
    String minutes = '00';
    if (timeMinutes > 9) {
      minutes = '$timeMinutes';
    } else if (timeMinutes > 0 && timeMinutes < 10) {
      minutes = '0$timeMinutes';
    } else {
      minutes = '00';
    }
    String second = '00';
    if (timeSeconds > 9) {
      second = '$timeSeconds';
    } else if (timeSeconds > 0 && timeSeconds < 10) {
      second = '0$timeSeconds';
    } else {
      second = '00';
    }
    return '$hours:$minutes:$second';
  }

  static double getProgress(int seconds, int duration) {
    if (duration == 0){
      return 0;
    }
    return seconds / duration;
  }
}