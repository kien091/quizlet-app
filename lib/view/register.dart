import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';
import 'package:quizlet/resources/colors.dart';
import 'package:quizlet/resources/strings.dart';
import 'package:quizlet/view/onboarding.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: const IconThemeData(color: MyColors.blueColor),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                FastLogin(),
                SizedBox(height: 24),
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FastLogin extends StatelessWidget {
  const FastLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.fastLogin.toUpperCase(),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CustomButton(
                icon: SvgPicture.asset(
                  'images/icon_google.svg',
                  height: 24,
                  width: 24,
                ),
                text: 'Google',
                backgroundColor: Colors.white,
                borderSideColor: MyColors.grayColor,
                textColor: Colors.black,
                fontSizeText: 16,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                icon: SvgPicture.asset(
                  'images/icon_facebook.svg',
                  height: 24,
                  width: 24,
                ),
                text: 'Facebook',
                backgroundColor: Colors.white,
                borderSideColor: MyColors.grayColor,
                textColor: Colors.black,
                fontSizeText: 16,
                onPressed: () {},
              ),
            )
          ],
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final now = DateTime.now();
  var date = DateTime(DateTime.now().year - 1, 12, 31);
  var _obscureText = true;

  var birthDayController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var emailValidator = (String? value) {
    if (value == null ||
        value.isEmpty ||
        !value.contains('@') ||
        !value.contains('.com')) {
      return Strings.inputValidEmailAddress.toUpperCase();
    }
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.orRegisterByEmail.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: birthDayController,
            hintText: '31 thg 12, ${now.year - 1}',
            title: Strings.dateOfBirth,
            readOnly: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  surfaceTintColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.43,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          child: const Text(
                            Strings.pleaseInputYourDateOfBirth,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: ScrollDatePicker(
                            selectedDate: date,
                            locale: const Locale('vi'),
                            onDateTimeChanged: (value) {
                              setState(
                                () {
                                  date = value;
                                },
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                birthDayController.text =
                                    '${date.day} thg ${date.month}, ${date.year}';
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            suffixIcon: Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.info_outline,
                ),
                onPressed: () {
                  showPopover(
                    barrierColor: Colors.transparent,
                    context: context,
                    direction: PopoverDirection.top,
                    backgroundColor: Colors.black,
                    bodyBuilder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.black,
                        child: const Text(
                          Strings.ruleAge,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          CustomTextFormField(
            validator: emailValidator,
            controller: emailController,
            hintText: 'email@example.com',
            title: Strings.emailOfParent,
          ),
          CustomTextFormField(
            controller: passwordController,
            hintText: '••••••••',
            title: Strings.password,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            obscureText: !_obscureText,
          ),
          CustomButton(
            text: Strings.register,
            backgroundColor: MyColors.blueColor,
            borderSideColor: MyColors.blueColor,
            textColor: Colors.white,
            fontSizeText: 17,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          const Rule(
            rule: Strings.rule,
            term: Strings.terms,
            privacy: Strings.privacy,
            color: MyColors.blueColor,
          ),
        ],
      ),
    );
  }
}

// can reuse
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String title;
  final Widget? suffixIcon;
  final bool readOnly;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isValidate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: widget.obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          validator: (value) {
            String? result;
            if (widget.validator != null) {
              result = widget.validator!(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _isValidate = result == null;
                });
              });
              return result;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: MyColors.hintColor,
            ),
            helperText: widget.title.toUpperCase(),
            helperStyle: const TextStyle(
              color: MyColors.grayColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: widget.suffixIcon ??
                (_isValidate
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : null),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
