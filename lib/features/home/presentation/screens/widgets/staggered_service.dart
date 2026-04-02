
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaggeredService extends StatelessWidget {
  const StaggeredService({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });
  final String text;
  final String image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          alignment: .center,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
