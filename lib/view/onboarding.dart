import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizlet/resources/colors.dart';
import 'package:quizlet/resources/strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final List<OnBoardingInfo> onBoardList = [
    OnBoardingInfo(
        title: Strings.onBoardingText1, images: 'images/onboard_1.png'),
    OnBoardingInfo(
        title: Strings.onBoardingText2, images: 'images/onboard_2.png'),
    OnBoardingInfo(
        title: Strings.onBoardingText3, images: 'images/onboard_3.png'),
    OnBoardingInfo(
        title: Strings.onBoardingText4, images: 'images/onboard_4.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                'images/quizlet_logo.svg',
                height: 65,
                width: 100,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // handle with find
              },
              icon: const Icon(
                Icons.search,
                size: 35,
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            children: [
              OnBoardingPageView(
                list: onBoardList,
              ),
              const SizedBox(
                height: 24,
              ),
              const Expanded(
                child: Rule(
                  rule: Strings.rule,
                  term: Strings.terms,
                  privacy: Strings.privacy,
                  color: MyColors.boldGrayColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomButton(
                    text: Strings.freeRegister,
                    backgroundColor: MyColors.blueColor,
                    borderSideColor: MyColors.blueColor,
                    textColor: Colors.white,
                    fontSizeText: 17,
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomButton(
                    text: Strings.orlogin,
                    backgroundColor: Colors.white,
                    borderSideColor: MyColors.grayColor,
                    textColor: MyColors.boldGrayColor,
                    fontSizeText: 17,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

// only for onboarding
class OnBoardingPageView extends StatefulWidget {
  const OnBoardingPageView({super.key, required this.list});

  final List<OnBoardingInfo> list;

  @override
  State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView.builder(
            itemCount: widget.list.length,
            controller: _pageController,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  Image.asset(
                    widget.list[i].images,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.list[i].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.list.length,
          effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Colors.black45,
              dotColor: Color(0xFFD6DDE7)),
        )
      ],
    );
  }
}

// can reuse
class Rule extends StatefulWidget {
  const Rule({
    super.key,
    required this.rule,
    required this.term,
    required this.privacy,
    required this.color,
  });

  final String rule;
  final String term;
  final String privacy;
  final Color color;

  @override
  State<Rule> createState() => _RuleState();
}

class _RuleState extends State<Rule> {
  @override
  Widget build(BuildContext context) {
    double fontSize = 14.5;

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: widget.rule.split(widget.term)[0],
            style: TextStyle(
              color: MyColors.grayColor,
              fontSize: fontSize,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: InkWell(
              onTap: () {
                // redirect to term page
              },
              highlightColor: MyColors.yellowColor,
              splashColor: MyColors.yellowColor,
              child: Text(
                widget.term,
                style: TextStyle(
                  color: widget.color,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextSpan(
            text:
                ' ${widget.rule.split(widget.term)[1].split(widget.privacy)[0].trim()} ',
            style: TextStyle(
              color: MyColors.grayColor,
              fontSize: fontSize,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: InkWell(
              onTap: () {
                // redirect to term page
              },
              highlightColor: MyColors.yellowColor,
              splashColor: MyColors.yellowColor,
              child: Text(
                widget.privacy,
                style: TextStyle(
                  color: widget.color,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextSpan(
            text: widget.rule.split(widget.privacy)[1],
            style: TextStyle(
              color: MyColors.grayColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

// can reuse
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.icon,
    required this.text,
    required this.backgroundColor,
    required this.borderSideColor,
    required this.textColor,
    required this.fontSizeText,
    required this.onPressed,
  });

  final SvgPicture? icon;
  final String text;
  final Color backgroundColor;
  final Color borderSideColor;
  final Color textColor;
  final double fontSizeText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 16)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: borderSideColor, width: 2),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null)
              const SizedBox(
                width: 16,
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSizeText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingInfo {
  final String title;
  final String images;

  OnBoardingInfo({required this.title, required this.images});
}
