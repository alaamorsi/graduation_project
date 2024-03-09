import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/profile/edit_profile.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  StudentData? studentData = StudentData();

  ProfileScreen({super.key, this.studentData,});

  @override
  Widget build(BuildContext context) {
    studentData!.firstName = studentData!.firstName ?? CacheHelper.getData(key: 'firstName');
    studentData!.lastName = studentData!.lastName ?? CacheHelper.getData(key: 'lastName');
    studentData!.bio = studentData!.bio ?? CacheHelper.getData(key: 'biography');
    var theme = Theme.of(context);
    StudentCubit.get(context).hasImage();
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (BuildContext context, StudentStates state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //Student data
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundColor: theme.canvasColor.withOpacity(.3),
                            radius: 50.0,
                            backgroundImage: imageProvider,
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, const EditProfileScreen());
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                              ),
                              child: const Icon(Icons.edit_rounded,
                                  size: 15, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${studentData!.firstName} ${studentData!.lastName}",
                          style: font.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: theme.primaryColorDark),
                        ),
                        Text(
                          studentData!.bio ?? "",
                          style: font.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 12.0,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                newDivider(),
                userdata(title: 'First name', data: studentData!.firstName!, theme: theme),
                const SizedBox(
                  height: 10,
                ),
                userdata(title: 'Last name', data: studentData!.lastName!, theme: theme),
                const SizedBox(
                  height: 10,
                ),
                userdata(
                    title: 'Email',
                    data: CacheHelper.getData(key: 'email'),
                    noIcon: false,
                    icon: Icons.email_rounded,
                    theme: theme),
                const SizedBox(
                  height: 10,
                ),
                userdata(title: 'bio', data: studentData!.bio ?? "", theme: theme),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget userdata({
    required String title,
    required String data,
    IconData? icon,
    bool noIcon = true,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: font.copyWith(
              fontSize: 13.0, color: theme.primaryColorDark.withOpacity(0.7)),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Text(
                data,
                style: font.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    color: theme.primaryColorDark),
              ),
              const Spacer(),
              if (!noIcon)
                Icon(
                  icon,
                  size: 30,
                  color: theme.primaryColor,
                ),
            ],
          ),
        )
      ],
    );
  }
}
