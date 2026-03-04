class SettingsEntity {
  final double textFontSize;
  final bool isTextBold;
  final String mushafMode;
  final String reciter;
  final bool isDarkMode;

  SettingsEntity({
    required this.textFontSize,
    required this.isTextBold,
    required this.mushafMode,
    required this.reciter,
    required this.isDarkMode,
  });

  SettingsEntity copyWith({
    double? textFontSize,
    bool? isTextBold,
    String? mushafMode,
    String? reciter,
    bool? isDarkMode,
  }) {
    return SettingsEntity(
      textFontSize: textFontSize ?? this.textFontSize,
      isTextBold: isTextBold ?? this.isTextBold,
      mushafMode: mushafMode ?? this.mushafMode,
      reciter: reciter ?? this.reciter,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
