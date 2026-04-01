import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/core/widgets/snack_bar.dart';

class ScreenShotWidget extends StatelessWidget {
  const ScreenShotWidget({
    super.key,
    required this.header,
    required this.content,
    required this.details,
  });

  final String header;
  final String content;
  final String details;

  static final ScreenshotController _screenshotController =
      ScreenshotController();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return IntrinsicWidth(
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                header,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "QuranFont",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Gap(20.h),
            // Content
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "QuranFont",
                fontSize: 20.sp,
                height: 1.8,
                color: isDark ? Colors.white : AppColors.thirdColor,
              ),
            ),
            Gap(20.h),
            // Divider
            Divider(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              thickness: 1,
            ),
            Gap(12.h),
            // Footer: Details & App Branding
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  details,
                  style: TextStyle(
                    fontFamily: "QuranFont",
                    fontSize: 12.sp,
                    color: AppColors.onPrimaryColor,
                  ),
                ),
                Gap(20.w),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Ummah",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Gap(4.w),
                    Image.asset(
                      "assets/images/ummahLogo.png",
                      width: 24.r,
                      height: 24.r,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String header,
    required String content,
    required String details,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Smaller preview of the screenshot widget
              Transform.scale(
                scale: 0.8,
                child: ScreenShotWidget(
                  header: header,
                  content: content,
                  details: details,
                ),
              ),
              Gap(30.h),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(
                    context,
                    icon: Icons.save_alt_rounded,
                    label: AppStrings.save,
                    onTap: () =>
                        _saveScreenshot(context, header, content, details),
                  ),
                  Gap(40.w),
                  _actionButton(
                    context,
                    icon: Icons.share_rounded,
                    label: AppStrings.share,
                    onTap: () async {
                      try {
                        final tempDir = await getTemporaryDirectory();
                        final fileName =
                            "ayah_${header.trim()}${DateTime.now().millisecondsSinceEpoch}.png";
                        final file = File("${tempDir.path}/$fileName");
                        final Uint8List? image = await _screenshotController
                            .captureFromWidget(
                              InheritedTheme.captureAll(
                                context,
                                Material(
                                  color: Colors.transparent,
                                  child: ScreenShotWidget(
                                    header: header,
                                    content: content,
                                    details: details,
                                  ),
                                ),
                              ),
                              pixelRatio: 3.0,
                              delay: const Duration(milliseconds: 300),
                            );
                        if (image != null) {
                          await file.writeAsBytes(image, flush: true);
                          if (context.mounted) {
                            await SharePlus.instance.share(
                              ShareParams(
                                files: [XFile(file.path)],
                                text: AppStrings.shareText,
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          CustomSnackBar.show(
                            context,
                            message: AppStrings.shareError,
                            isError: true,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: REdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 28.sp),
          ),
        ),
        Gap(8.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  static Future<void> _saveScreenshot(
    BuildContext context,
    String header,
    String content,
    String details,
  ) async {
    try {
      final Uint8List? image = await _screenshotController.captureFromWidget(
        InheritedTheme.captureAll(
          context,
          Material(
            color: Colors.transparent,
            child: ScreenShotWidget(
              header: header,
              content: content,
              details: details,
            ),
          ),
        ),
        pixelRatio: 3.0,
        delay: const Duration(milliseconds: 100),
      );

      if (image != null) {
        await ImageGallerySaver().saveImage(image);

        if (context.mounted) {
          CustomSnackBar.show(
            context,
            message: AppStrings.saveSuccess,
            isError: false,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.show(
          context,
          message: "${AppStrings.saveError}: $e",
          isError: true,
        );
      }
    }
  }
}
