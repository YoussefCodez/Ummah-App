import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/dua/domain/models/dua_entity.dart';

class DuaItemCard extends StatelessWidget {
  final DuaItem dua;

  const DuaItemCard({super.key, required this.dua});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.format_quote_rounded,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
                size: 30.r,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  dua.title,
                  style: TextStyle(
                    fontFamily: 'Main',
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Gap(15.h),
          Text(
            dua.content,
            style: TextStyle(
              fontFamily: 'QuranFont',
              fontSize: 20.sp,
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          if (dua.reference.isNotEmpty) ...[
            Gap(15.h),
            Text(
              '[ ${dua.reference} ]',
              style: TextStyle(
                fontFamily: 'Main',
                fontSize: 11.sp,
                color: Theme.of(context).colorScheme.outline,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            ),
          ],
          Gap(10.h),
          Divider(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: dua.content));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppStrings.copiedLabel,
                        style: TextStyle(
                          fontFamily: 'Main',
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: Icon(
                  Icons.copy_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
