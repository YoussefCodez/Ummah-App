class RichTextData {
  final String text;
  final bool isHighlight;

  const RichTextData({required this.text, this.isHighlight = false});
}

class AyatAlKursiModel {
  final String textAr;
  final String textEn;
  final String titleAr;
  final String tafsirAlMuyassar;
  final String mukhtasar;
  final List<RichTextData> benefits;
  final List<RichTextData> story;

  AyatAlKursiModel({
    required this.textAr,
    required this.textEn,
    required this.titleAr,
    required this.tafsirAlMuyassar,
    required this.mukhtasar,
    required this.benefits,
    required this.story,
  });
}
