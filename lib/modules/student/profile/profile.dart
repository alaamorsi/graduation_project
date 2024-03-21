import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/settings/settings.dart';
import 'package:graduation_project/modules/student/profile/edit_profile.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../shared/component/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (BuildContext context, StudentStates state) {},
      builder: (context, state) {
        var theme = Theme.of(context);
        var cubit = StudentCubit.get(context);
        return Scaffold(
          appBar:defaultAppBar(
            context: context,
            title: "Profile".tr,
            actions: [
              Padding(padding: const EdgeInsets.symmetric(horizontal:10.0),
                child:Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  ),
                  child: IconButton(
                    onPressed: (){navigateTo(context, const SettingsScreen());},
                    icon: Icon(Icons.settings,size: 25,color: theme.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Student data
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor: theme.canvasColor.withOpacity(.4),
                                radius: 50,
                                backgroundImage: cubit.imageProvider,
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
                                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  child: const Icon(Icons.edit_rounded,size: 15, color: Colors.white),
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
                              "${cubit.firstName} ${cubit.lastName}",
                              style: font.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0,
                                  color: theme.primaryColorDark),
                            ),
                            Text(
                              cubit.bio,
                              style: font.copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.0,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    userdata(title: 'First name'.tr, data: cubit.firstName, theme: theme),
                    const SizedBox(
                      height: 10,
                    ),
                    userdata(title: 'Last name'.tr, data:cubit.lastName, theme: theme),
                    const SizedBox(
                      height: 10,
                    ),
                    userdata(
                        title: "email address".tr,
                        data: CacheHelper.getData(key: 'email') ?? "",
                        noIcon: false,
                        icon: Icons.email_rounded,
                        theme: theme),
                    const SizedBox(
                      height: 10,
                    ),
                    userdata(title: 'bio'.tr,data: cubit.bio, theme: theme),
                  ],
                ),
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
          padding: const EdgeInsets.all(10),
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
