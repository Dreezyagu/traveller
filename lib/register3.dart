import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:traveller/notifications.dart';
import 'package:traveller/sucess.dart';

import 'utils.dart';

class Register3 extends StatefulWidget {
  final Map body;
  final List<File?> files;
  const Register3(this.body, this.files);

  @override
  _Register3State createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  bool loading = false;
  String dateDB = "";
  String timeDB = "";
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
                "BOOK APPOINTMENT",
                style: TextStyle(
                    color: purple,
                    fontWeight: FontWeight.w500,
                    fontSize: context.width(.035)),
              ),
              Hspace(context.height(.03)),
              Text(
                "Book an Appointment",
                style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.05)),
              ),
              Hspace(context.height(.03)),
              InkWell(
                onTap: () async {
                  final DateTime? dates = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  if (dates != null) {
                    setState(() {
                      dateDB = DateFormat('yyyy-MM-dd').format(dates);
                      date.text = DateFormat.yMMMMd().format(dates);
                    });
                  }
                },
                child: Formfield(
                  controller: date,
                  label: "Day of Appointment",
                  enabled: false,
                  type: TextInputType.name,
                ),
              ),
              Hspace(context.height(.03)),
              InkWell(
                onTap: () async {
                  final TimeOfDay? times = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (times != null) {
                    setState(() {
                      final String minutes = times.minute < 10
                          ? "0${times.minute}"
                          : "${times.minute}";
                      final String hours =
                          times.hour < 10 ? "0${times.hour}" : "${times.hour}";
                      timeDB = "$hours:$minutes";

                      time.text = timeDB;
                    });
                  }
                },
                child: Formfield(
                  controller: time,
                  label: "Time",
                  enabled: false,
                  type: TextInputType.name,
                ),
              ),
              Hspace(context.height(.1)),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: purple,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(context.width(.03)))),
                    onPressed: () async {
                      if (dateDB.isEmpty || timeDB.isEmpty) {
                        EasyLoading.showToast("Provide every detail",
                            toastPosition: EasyLoadingToastPosition.bottom);
                        return;
                      }
                      setState(() {
                        loading = true;
                      });

                      try {
                        final Map body = widget.body;
                        final File nic = widget.files[0]!;
                        final File pvc = widget.files[1]!;
                        final File mr = widget.files[2]!;
                     

                        final String nicfilename = nic.path.split('/').last;
                        final String pvcfilename = pvc.path.split('/').last;
                        final String mrfilename = mr.path.split('/').last;

                        final FormData formData = FormData.fromMap({
                          "nationalIdentityCard": await MultipartFile.fromFile(
                            nic.path,
                            filename: nicfilename,
                          ),
                          "votersCard": await MultipartFile.fromFile(
                            nic.path,
                            filename: pvcfilename,
                          ),
                          "medicalReport": await MultipartFile.fromFile(
                            mr.path,
                            filename: mrfilename,
                          ),
                          "firstname": body["firstname"],
                          "lastname": body["lastname"],
                          "dateOfBirth": body["dateOfBirth"],
                          "gender": body["gender"],
                          "country": body["country"],
                          "nationality": body["nationality"],
                          "nationalIdentityNumber":
                              body["nationalIdentityNumber"],
                          "bankVerificationNumber":
                              body["bankVerificationNumber"],
                          "localGovernmentArea": body["localGovernmentArea"],
                          "appointmentDate": dateDB,
                          "appointmentTime": timeDB
                        });
                        const String url = "https://haypex.com.ng/lp/test.php";
                        final response = await Dio().post(
                          url,
                          data: formData,
                        );
                        if (response.statusCode == 200) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Success(),
                              ));
                        } else {
                          EasyLoading.showToast("Couldn't submit");
                        }
                      } catch (e) {
                        EasyLoading.showToast("Couldn't submit");

                        setState(() {
                          loading = false;
                        });
                      }

                      setState(() {
                        loading = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.height(.015),
                          horizontal: context.width(.1)),
                      child: loading
                          ? const CircularProgressIndicator(
                              color: white,
                            )
                          : Text(
                              "Submit",
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: context.width(.05)),
                            ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
