class SettingsEntity {
  final double textFontSize;
  final bool isTextBold;
  final String mushafMode;

  SettingsEntity({
    required this.textFontSize,
    required this.isTextBold,
    required this.mushafMode,
  });

  SettingsEntity copyWith({
    double? textFontSize,
    bool? isTextBold,
    String? mushafMode,
  }) {
    return SettingsEntity(
      textFontSize: textFontSize ?? this.textFontSize,
      isTextBold: isTextBold ?? this.isTextBold,
      mushafMode: mushafMode ?? this.mushafMode,
    );
  }
}
