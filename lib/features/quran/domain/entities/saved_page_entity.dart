class SavedPageEntity {
  final String surahName;
  final String surahNameEn;
  final int juzNumber;
  final int pageNumber;

  SavedPageEntity({
    required this.surahName,
    required this.surahNameEn,
    required this.juzNumber,
    required this.pageNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'surahName': surahName,
      'surahNameEn': surahNameEn,
      'juzNumber': juzNumber,
      'pageNumber': pageNumber,
    };
  }

  factory SavedPageEntity.fromJson(Map<String, dynamic> json) {
    return SavedPageEntity(
      surahName: json['surahName'] as String,
      surahNameEn: json['surahNameEn'] as String,
      juzNumber: json['juzNumber'] as int,
      pageNumber: json['pageNumber'] as int,
    );
  }
}
