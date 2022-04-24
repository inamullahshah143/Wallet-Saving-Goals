import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'login_screen.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        imageWidth: MediaQuery.of(context).size.width * 0.75,
        pageController: _pageController,
        onSkip: () {
          Get.off(LoginScreen());
        },
        onDone: () {
          Get.off(LoginScreen());
        },
        onBoardData: onBoardData,
        titleStyles: TextStyle(
          color: AppColor.primary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: AppColor.fonts.withOpacity(0.75),
        ),
        pageIndicatorStyle: PageIndicatorStyle(
          width: 100,
          inactiveColor: AppColor.primary,
          activeColor: AppColor.fonts,
          inactiveSize: const Size(8, 8),
          activeSize: const Size(12, 12),
        ),
        skipButton: TextButton(
          onPressed: () {
            Get.off(LoginScreen());
          },
          child: Text(
            "Skip",
            style: TextStyle(color: AppColor.primary),
          ),
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColor.primary,
                ),
                child: Text(
                  state.isLastPage ? "Get Started" : "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      Get.off(LoginScreen());
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Set your own goals and get better",
    description: "Goal support your motivation and inspire you to work harder",
    imgUrl: "assets/images/step-1.png",
  ),
  const OnBoardModel(
    title: "Track your progress with statistics",
    description:
        "Analyse personal result with detailed chart and numerical values",
    imgUrl: 'assets/images/step-2.png',
  ),
  const OnBoardModel(
    title: "Create photo comparision and share your results",
    description:
        "Take before and after photos to visualize progress and get the shape that you dream about",
    imgUrl: 'assets/images/step-3.png',
  ),
];
