// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Shared/widgets/Validator.dart';
import 'package:online_exam_app/Shared/widgets/custom_button.dart';
import 'package:online_exam_app/Shared/widgets/custom_password_text_field.dart';
import 'package:online_exam_app/Shared/widgets/custom_text_field.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/ui/Profile_Details/viewmodel/profile_details_cubit.dart';
import 'package:online_exam_app/ui/Profile_Details/viewmodel/profile_details_intent.dart';
import 'package:online_exam_app/ui/Profile_Details/viewmodel/profile_details_state.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load profile data when screen initializes
    context.read<ProfileDetailsCubit>().handleIntent(const LoadProfileIntent());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  void _updateTextFields(ProfileDetailsState state) {
    if (state.userProfile?.user != null) {
      final user = state.userProfile!.user;
      emailController.text = user?.email ?? '';
      userNameController.text = user?.username ?? '';
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
      phoneNumberController.text = user?.phone ?? '';
      // Don't set password as it's usually not returned from API
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileDetailsCubit, ProfileDetailsState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
        if (state.userProfile != null) {
          _updateTextFields(state);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                AppStrings.profile,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  size: 100,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomTextField(
                          label: AppStrings.userName,
                          placeholder: 'Mohamed123',
                          controller: userNameController,
                          validator: Validator.userName,
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: AppStrings.firstName,
                                placeholder: 'Mohamed',
                                validator: Validator.firstName,
                                controller: firstNameController,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: CustomTextField(
                                label: AppStrings.lastName,
                                placeholder: 'Ahmed',
                                controller: lastNameController,
                                validator: Validator.lastName,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        CustomTextField(
                          label: AppStrings.email,
                          placeholder: 'Mohamed.Ahmed@gmail.com',
                          controller: emailController,
                          validator: Validator.email,
                        ),
                        SizedBox(height: 30),
                        CustomPasswordField(
                          label: AppStrings.password,
                          controller: passwordController,
                          validator: Validator.password,
                        ),
                        SizedBox(height: 30),
                        CustomTextField(
                          label: AppStrings.phoneNumber,
                          placeholder: '1212312312433',
                          controller: phoneNumberController,
                          validator: Validator.phoneNumber,
                        ),
                        SizedBox(height: 70),
                        CustomButton(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<ProfileDetailsCubit>().handleIntent(
                                    UpdateProfileIntent(
                                      userName: userNameController.text,
                                      email: emailController.text,
                                      phoneNumber: phoneNumberController.text,
                                      password: passwordController.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                    ),
                                  );
                            }
                          },
                          text: AppStrings.update,
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
