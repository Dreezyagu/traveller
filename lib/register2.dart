import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:traveller/notifications.dart';
import 'package:traveller/register.dart';
import 'package:traveller/register3.dart';
import 'package:traveller/utils.dart';
import 'package:path/path.dart' as p;

class Register2 extends StatefulWidget {
  final Map body;
  const Register2(this.body);

  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  File? nic;
  File? pvc;
  File? mr;

  String nicName = "";
  String pvcName = "";
  String mrName = "";

  Future pickFile(String name) async {
    final pickedFile = await FilePicker.platform.pickFiles();
    final List<String> exts = [
      ".pdf",
      ".doc",
      ".docx",
      ".txt",
      ".jpg",
      ".jpeg"
    ];
    if (pickedFile != null) {
      if (!exts.contains(p.extension(pickedFile.files.single.path!))) {
        EasyLoading.showToast("Invalid file type");
        return;
      }
      setState(() {
        switch (name) {
          case "nic":
            nic = File(pickedFile.files.single.path!);
            nicName = p.basename(nic!.path);
            break;
          case "pvc":
            pvc = File(pickedFile.files.single.path!);
            pvcName = p.basename(pvc!.path);
            break;
          case "mr":
            mr = File(pickedFile.files.single.path!);
            mrName = p.basename(mr!.path);
            break;

          default:
        }
      });
    }
  }

  String? visaType;
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ));
              },
              icon: Image.asset("assets/icons/notifications.png")),
          SizedBox(
            width: context.width(.05),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.04), vertical: context.height(.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Logotext(),
              Hspace(context.height(.03)),
              Text(
                "Register",
                style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: context.width(.08)),
              ),
              Hspace(context.height(.005)),
              Text(
                "VISA DETAILS",
                style: TextStyle(
                    color: purple,
                    fontWeight: FontWeight.w500,
                    fontSize: context.width(.035)),
              ),
              Hspace(context.height(.03)),
              Text(
                "Type of VISA",
                style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.05)),
              ),
              Hspace(context.height(.01)),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        visaType = "Ecowas";
                      });
                    },
                    child: Text(
                      "ECOWAS",
                      style: visaType == "Ecowas"
                          ? TextStyle(
                              color: purple,
                              fontWeight: FontWeight.w600,
                              fontSize: context.width(.04))
                          : TextStyle(
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: context.width(.04)),
                    ),
                  ),
                  Wspace(context.width(.05)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        visaType = "Global";
                      });
                    },
                    child: Text(
                      "GLOBAL",
                      style: visaType == "Global"
                          ? TextStyle(
                              color: purple,
                              fontWeight: FontWeight.w600,
                              fontSize: context.width(.04))
                          : TextStyle(
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: context.width(.04)),
                    ),
                  ),
                  Wspace(context.width(.05)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        visaType = "Student";
                      });
                    },
                    child: Text(
                      "STUDENT",
                      style: visaType == "Student"
                          ? TextStyle(
                              color: purple,
                              fontWeight: FontWeight.w600,
                              fontSize: context.width(.04))
                          : TextStyle(
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: context.width(.04)),
                    ),
                  ),
                ],
              ),
              Hspace(context.height(.075)),
              Text(
                "Attach Documents",
                style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.05)),
              ),
              Hspace(context.height(.01)),
              Container(
                width: double.infinity,
                color: const Color(0xffF7F7F8),
                padding: EdgeInsets.symmetric(
                    horizontal: context.width(.04),
                    vertical: context.height(.02)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Attachs(
                      title: "NATIONAL IDENTITY CARD",
                      fileName: nicName,
                      fun: () {
                        pickFile("nic");
                      },
                    ),
                    Attachs(
                      title: "Permanent voter’s card".toUpperCase(),
                      fileName: pvcName,
                      fun: () {
                        pickFile("pvc");
                      },
                    ),
                    Attachs(
                      title: "Medical Report".toUpperCase(),
                      fileName: mrName,
                      fun: () {
                        pickFile("mr");
                      },
                    ),
                  ],
                ),
              ),
              Hspace(context.height(.1)),
              Button(() {
                if (mr == null ||
                    nic == null ||
                    visaType == null ||
                    pvc == null) {
                  EasyLoading.showToast("Provide every detail",
                      toastPosition: EasyLoadingToastPosition.bottom);
                  return;
                }
                final Map body = widget.body;
                body["nationalIdentityCard"] = nic;
                body["votersCard"] = pvc;
                body["medicalReport"] = mr;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register3(
                        body,
                        [nic, pvc, mr],
                      ),
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}

class Attachs extends StatelessWidget {
  final String title;
  final VoidCallback fun;
  final String fileName;

  const Attachs(
      {Key? key,
      required this.fileName,
      required this.title,
      required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: black,
              fontWeight: FontWeight.w400,
              fontSize: context.width(.035)),
        ),
        Row(
          children: [
            TextButton(
                onPressed: fun,
                child: Text(
                  "Attach File",
                  style: TextStyle(
                      color: purple,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: context.width(.032)),
                )),
            Wspace(context.width(.02)),
            Expanded(
              child: Text(
                fileName,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.03)),
              ),
            )
          ],
        ),
        Hspace(context.height(.015)),
      ],
    );
  }
}
