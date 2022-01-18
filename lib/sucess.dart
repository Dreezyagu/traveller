import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:traveller/dashboard.dart';
import 'utils.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          throw "";
        },
        child: SafeArea(
          child: Column(
            children: [
              Hspace(context.height(.15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/yay.png",
                    height: context.width(.1),
                  ),
                  Wspace(context.width(.02)),
                  Image.asset(
                    "assets/icons/yay.png",
                    height: context.width(.1),
                  ),
                ],
              ),
              Hspace(context.height(.03)),
              Text(
                "Yaah we got",
                style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.08)),
              ),
              Text(
                "your Response",
                style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.08)),
              ),
              Hspace(context.height(.03)),
              Icon(
                Icons.check_circle_outlined,
                color: Colors.green,
                size: context.width(.13),
              ),
              Hspace(context.height(.04)),
              InkWell(
                onTap: () async {
                  EasyLoading.show();
                  final response = await getData();
                  if (response != null) {
                    EasyLoading.dismiss();

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(response),
                        ));
                  } else {
                    EasyLoading.showToast("Error");
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Go to Dashboard",
                      style: TextStyle(
                          color: purple,
                          fontSize: context.width(.05),
                          fontWeight: FontWeight.w500),
                    ),
                    Wspace(context.width(.01)),
                    const Icon(
                      Icons.arrow_forward,
                      color: purple,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getData() async {
    try {
      final Uri url = Uri.parse("https://haypex.com.ng/lp/genderRatio.php");
      final response = await get(url).timeout(const Duration(minutes: 2));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
