class ArabicUtils {
  static String numberToArabic(int number) {
    const arabic = [
      '٠','١','٢','٣','٤',
      '٥','٦','٧','٨','٩'
    ];

    return number
        .toString()
        .split('')
        .map((e) => arabic[int.parse(e)])
        .join();
  }
}