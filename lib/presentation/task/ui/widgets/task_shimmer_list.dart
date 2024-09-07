import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/core/constant/app_size.dart';

class ShimmerTaskList extends StatelessWidget {
  const ShimmerTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          height: AppHeight.s15,
        );
      },
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s20, vertical: AppHeight.s10),
      itemCount: 5, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return ShimmerTaskListItem();
      },
    );
  }
}

class ShimmerTaskListItem extends StatelessWidget {
  const ShimmerTaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              color: Colors.grey.shade300,
              width: AppWidth.s6,
            ),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300, // Placeholder for title
                        borderRadius: BorderRadius.circular(AppRound.s3)
                      ),
                      height: AppHeight.s15,

                    ),
                  ),
                  Gap(AppWidth.s50),

                ],
              ),
              SizedBox(height: AppHeight.s8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: AppHeight.s15,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300, // Placeholder for title
                          borderRadius: BorderRadius.circular(AppRound.s3)
                      ),
                    ),
                  ),
                  Gap(AppWidth.s100),

                ],
              ),
              Gap(AppHeight.s10),
              Divider(color: Colors.grey.shade200, height: 0.5),
              Gap(AppHeight.s10),
              Row(
                children: [

                  Container(
                    width: AppWidth.s80,
                    height: AppHeight.s14,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Placeholder for title
                        borderRadius: BorderRadius.circular(AppRound.s3)
                    ),
                  ),
                  SizedBox(width: AppWidth.s15),

                  Container(
                    width: AppWidth.s80,
                    height: AppHeight.s14,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300, // Placeholder for title
                        borderRadius: BorderRadius.circular(AppRound.s3)
                    ),
                  ),
                ],
              ),
            ],
          )),
        )
    );
  }
}
