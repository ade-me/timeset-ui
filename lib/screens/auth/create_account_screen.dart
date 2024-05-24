import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../state_management/auth_provider.dart';
import '../../widgets/auth_widgets/auth_alternate_action_text.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/auth_social_options.dart';
import '../../widgets/general_widgets/app_bar_with_back_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/general_app_padding.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = '/CreateAccountScreen';

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool emailHasInput = false;
  bool passwordHasInput = false;

  void checkEmailHasInput() =>
      setState(() => emailTextController.text.isNotEmpty
          ? emailHasInput = true
          : emailHasInput = false);

  void checkPasswordHasInput() =>
      setState(() => passwordTextController.text.isNotEmpty
          ? passwordHasInput = true
          : passwordHasInput = false);

  @override
  void initState() {
    super.initState();

    emailTextController.addListener(checkEmailHasInput);
    passwordTextController.addListener(checkPasswordHasInput);
  }

  @override
  void dispose() {
    super.dispose();

    emailTextController.dispose();
    passwordTextController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 4.h);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: GeneralAppPadding(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          const AppBarWithBackButton(),
                          sizedBox,
                          Text(
                            'Create Your Account',
                            style: textTheme.headlineMedium,
                          ),
                          sizedBox,
                          CustomTextField(
                            textInputType: TextInputType.emailAddress,
                            controller: emailTextController,
                            focusNode: emailFocusNode,
                            iconName: 'email',
                            hintText: 'Email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('.com')) {
                                return 'Enter a valid email address';
                              }
                              if (!value.contains('@')) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 2.h),
                          CustomTextField(
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            controller: passwordTextController,
                            focusNode: passwordFocusNode,
                            iconName: 'password',
                            hintText: 'Password',
                            isPassword: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Your password must be at least 8 characters long';
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Your password must contain at least one number';
                              }
                              if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                  .hasMatch(value)) {
                                return 'Your password must contain one symbol';
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(value) ||
                                  !RegExp(r'[a-z]').hasMatch(value)) {
                                return 'Your password must have a mixture of uppercase and lowercase letters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 3.h),
                          AuthButton(
                            text: 'Sign Up',
                            isDisabled: emailHasInput && passwordHasInput
                                ? false
                                : true,
                            function: createUser,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const AuthSocialOptions(),
              AuthAlternateActionText(
                alternateText: 'Already have an account? ',
                actionText: 'Sign In',
                function: () => Navigator.pushNamed(
                  context,
                  LoginScreen.routeName,
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  void createUser() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid == false) {
      return;
    } else {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);

      await authProvider.createUser(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
        context: context,
        scaffoldKey: _scaffoldKey,
      );
    }
  }
}
