

import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_color.dart';
import 'package:todo_app/core/constant/app_constants.dart';
import 'package:todo_app/core/constant/app_size.dart';

class AppButton extends StatelessWidget {
  final double height;
  final String label;
  final Color? backGroundColor;
  final Color? labelColor;
  final String? iconAssetPath;
  final Color? borderColor;
  final bool isIcon;
  final double iconHeight;
  final double iconWidth;
  final bool isBorder;
  final void Function()? onPressed;
  final Widget? child;

  const AppButton(
      {super.key,
        required this.height,
        required this.label,
        this.backGroundColor,
        this.iconAssetPath,
        this.isIcon = false,
        this.iconHeight = 22.0,
        this.iconWidth = 22.0,
        this.labelColor,
        this.isBorder = false,
        this.onPressed,

        this.child, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min, // Keeps the button compact
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: labelColor ?? Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: AppTextSize.s15,
              ),
            ),
            if(isIcon)
            Row(
              children: [
                SizedBox(width: 8), // Optional space between the text and icon
                Icon(
                  Icons.arrow_forward, // Change this to any icon you prefer
                  color: labelColor ?? Colors.white, // Matches the icon color to the text color
                  size: AppWidth.s20, // Adjust the size of the icon
                ),
              ],
            ),
          ],
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backGroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isBorder ? borderColor ?? AppColor.windowBackgroundColor : Colors.transparent,
              width: AppWidth.s1,

            ),
            borderRadius: BorderRadius.circular(5),
          ),
          foregroundColor: Colors.transparent, // Ensures the button text color is managed by label style
          surfaceTintColor: Colors.transparent, // Ensures the button surface color does not affect the ripple
        ).copyWith(
         /* overlayColor: MaterialStateProperty.all<Color>(AppColor.rippleEffectColor), // Ripple color*/
        ),
      )
    );
  }
}