class FormatTime {
  static String formatTime(time){
    return time.replaceAll('T', ' ').split('.')[0];
  }
}