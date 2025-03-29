extension StringExtension on String {
  String get toFirstCapital {
    return this.split(' ').map((word) {
      if (word.isNotEmpty) {
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      }
      return word;
    }).join(' ');
  }
}
