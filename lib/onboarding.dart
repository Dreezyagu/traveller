import 'package:flutter/material.dart';
import 'package:traveller/register.dart';
import 'utils.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController controller = PageController();
  int pageIndex = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          throw "";
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
                controller: controller,
                onPageChanged: (int current) {
                  setState(() {
                    pageIndex = current;
                    if (pageIndex == 1) {
                      isCompleted = true;
                    } else {
                      isCompleted = false;
                    }
                  });
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: context.width(.15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Freedom",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: context.width(.1)),
                            ),
                            Text(
                              "Begins here",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: context.width(.1)),
                            ),
                          ],
                        ),
                      ),
                      Hspace(context.height(.05)),
                      Image.asset(
                        "assets/icons/curve.png",
                        width: context.width(.6),
                      )
                    ],
                  ),
                  Container(
                    color: const Color(0xff0066FF),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontSize: context.width(.15)),
                        ),
                        Hspace(context.height(.05)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        context.width(.03)))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.height(.01),
                                  horizontal: context.width(.05)),
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: const Color(0xff0066FF),
                                    fontWeight: FontWeight.w700,
                                    fontSize: context.width(.05)),
                              ),
                            ))
                      ],
                    ),
                  )
                ]),
            Positioned(
              bottom: context.height(.1),
              child: Row(
                children: [
                  ScrollPoints(pageIndex == 0
                      ? const Color(0xff414140)
                      : white.withOpacity(.45)),
                  Wspace(context.width(.02)),
                  ScrollPoints(pageIndex == 0 ? const Color(0xffc4c4c4) : white)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
