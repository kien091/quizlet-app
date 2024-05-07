import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizlet/resources/colors.dart';
import 'package:quizlet/resources/strings.dart';
import 'package:quizlet/view/onboarding.dart';
import 'package:quizlet/view/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: const IconThemeData(color: MyColors.blueColor),
        ),
        body: LayoutBuilder(
          builder: (ct, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          FastLogin(),
                          SizedBox(height: 24),
                          LoginForm(),
                        ],
                      ),
                      Rule(
                          rule: Strings.rule,
                          term: Strings.terms,
                          privacy: Strings.privacy,
                          color: MyColors.blueColor)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var emailOrUsernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.orLoginWithYourEmail.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: emailOrUsernameController,
            hintText: Strings.inputEmailOrUsername,
            title: Strings.emailOrUsername,
          ),
          CustomTextFormField(
            controller: passwordController,
            hintText: Strings.inputPassword,
            title: Strings.password,
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              CustomButton(
                text: Strings.login,
                backgroundColor: MyColors.blueColor,
                borderSideColor: MyColors.blueColor,
                textColor: Colors.white,
                fontSizeText: 17,
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              Rule(
                rule: Strings.forgotUsernameOrPassword,
                term: Strings.username.toLowerCase(),
                privacy: Strings.password.toLowerCase(),
                color: MyColors.blueColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
