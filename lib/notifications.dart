import 'package:flutter/material.dart';
import 'package:traveller/utils.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: purple,
            )),
        title: const Logotext(),
        centerTitle: true,
        actions: [
          Center(
            child: Text(
              "Notifications",
              style: TextStyle(
                  color: purple,
                  fontSize: context.width(.045),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Wspace(context.width(.02))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: context.height(.02)),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Color(0xffEEEEEE)),
              padding: EdgeInsets.symmetric(vertical: context.height(.03)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Your application has been reeived",
                    style: TextStyle(
                        color: black,
                        fontSize: context.width(.04),
                        fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.message_outlined),
                  const ScrollPoints(Colors.red)
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Color(0xffF7F7F8)),
              padding: EdgeInsets.symmetric(vertical: context.height(.03)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Your application has been reeived",
                    style: TextStyle(
                        color: black,
                        fontSize: context.width(.04),
                        fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.message_outlined),
                  const ScrollPoints(Color(0xffC4C4C4))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
