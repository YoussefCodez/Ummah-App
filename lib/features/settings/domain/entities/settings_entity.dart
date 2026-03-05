class SettingsEntity {
  final double textFontSize;
  final bool isTextBold;
  final String mushafMode;
  final String reciter;
  final bool isDarkMode;
  final String languageCode;

  SettingsEntity({
    required this.textFontSize,
    required this.isTextBold,
    required this.mushafMode,
    required this.reciter,
    required this.isDarkMode,
    required this.languageCode,
  });

  SettingsEntity copyWith({
    double? textFontSize,
    bool? isTextBold,
    String? mushafMode,
    String? reciter,
    bool? isDarkMode,
    String? languageCode,
  }) {
    return SettingsEntity(
      textFontSize: textFontSize ?? this.textFontSize,
      isTextBold: isTextBold ?? this.isTextBold,
      mushafMode: mushafMode ?? this.mushafMode,
      reciter: reciter ?? this.reciter,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
