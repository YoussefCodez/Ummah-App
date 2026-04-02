import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/ayat_al_kursi/data/models/ayat_al_kursi_model.dart';

class RichTextContent extends StatelessWidget {
  final List<RichTextData> data;

  const RichTextContent({super.key, required this.data});
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final normalStyle = TextStyle(color: colorScheme.onSurface, fontSize: 16.sp, height: 1.8);
    final hadithStyle = TextStyle(color: colorScheme.primary, fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'QuranFont', height: 1.8);
    
    return RichText(
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: normalStyle,
        children: data.map((item) {
          return TextSpan(
            text: item.text,
            style: item.isHighlight ? hadithStyle : normalStyle,
          );
        }).toList(),
      ),
    );
  }
}
