import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:traveller/notifications.dart';
import 'package:traveller/register2.dart';
import 'package:traveller/utils.dart';
import 'utils.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController bvn = TextEditingController();
  TextEditingController nin = TextEditingController();
  TextEditingController dob = TextEditingController();

  String gender = "";
  String? country;
  String? nationality;
  String? lga;
  String dobDB = "";

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
                "BIO DATA",
                style: TextStyle(
                    color: purple,
                    fontWeight: FontWeight.w500,
                    fontSize: context.width(.035)),
              ),
              Hspace(context.height(.03)),
              Formfield(
                controller: firstName,
                label: "First Name",
                type: TextInputType.name,
              ),
              Hspace(context.height(.02)),
              Formfield(
                controller: lastName,
                label: "Last Name",
                type: TextInputType.name,
              ),
              Hspace(context.height(.02)),
              InkWell(
                onTap: () async {
                  final today = DateTime.now();
                  final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(
                        today.year - 18,
                      ),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(today.year - 18));
                  if (date != null) {
                    setState(() {
                      dobDB = DateFormat('yyyy-MM-dd').format(date);
                      dob.text = DateFormat.yMMMMd().format(date);
                    });
                  }
                },
                child: Formfield(
                  controller: dob,
                  label: "Date of Birth",
                  enabled: false,
                  type: TextInputType.name,
                ),
              ),
              Hspace(context.height(.03)),
              Text(
                "Gender",
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
                        gender = "Male";
                      });
                    },
                    child: Text(
                      "MALE",
                      style: gender == "Male"
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
                        gender = "Female";
                      });
                    },
                    child: Text(
                      "FEMALE",
                      style: gender == "Female"
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
              Hspace(context.height(.03)),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width(.03),
                    vertical: context.width(.01)),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(context.width(.1))),
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: country,
                    items: countries.map<DropdownMenuItem<String>>((Map value) {
                      return DropdownMenuItem<String>(
                        value: value["name"],
                        child: Text(
                          value["name"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: context.width(.04),
                              fontWeight: FontWeight.w300),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Select country",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: context.width(.04),
                          fontWeight: FontWeight.w300),
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (String? value) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        country = value;
                      });
                    },
                  ),
                ),
              ),
              Hspace(context.height(.03)),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width(.03),
                    vertical: context.width(.01)),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(context.width(.1))),
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: nationality,
                    items: nationalities
                        .map<DropdownMenuItem<String>>((Map value) {
                      return DropdownMenuItem<String>(
                        value: value["nationality"],
                        child: Text(
                          value["nationality"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: context.width(.04),
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Select Nationality",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: context.width(.04),
                          fontWeight: FontWeight.w300),
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (String? value) {
                      FocusScope.of(context).unfocus();

                      setState(() {
                        nationality = value;
                      });
                    },
                  ),
                ),
              ),
              Hspace(context.height(.03)),
              Formfield(
                controller: nin,
                formatter: [FilteringTextInputFormatter.digitsOnly],
                label: "National Identity Number",
                type: TextInputType.number,
              ),
              Hspace(context.height(.03)),
              Formfield(
                controller: bvn,
                formatter: [FilteringTextInputFormatter.digitsOnly],
                label: "Bank Verification Number",
                type: TextInputType.number,
              ),
              Hspace(context.height(.03)),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width(.03),
                    vertical: context.width(.01)),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(context.width(.1))),
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: lga,
                    items: lGAs.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ));
                    }).toList(),
                    hint: Text(
                      "Local Government Area",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: context.width(.04),
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (String? value) {
                      setState(() {
                        lga = value;
                      });
                    },
                  ),
                ),
              ),
              Hspace(context.height(.05)),
              Button(() {
                FocusScope.of(context).unfocus();

                if (firstName.text.isEmpty ||
                    lastName.text.isEmpty ||
                    dobDB.isEmpty ||
                    gender.isEmpty ||
                    country == null ||
                    nationality == null ||
                    nin.text.isEmpty ||
                    bvn.text.isEmpty ||
                    lga == null) {
                  EasyLoading.showToast("Provide every detail",
                      toastPosition: EasyLoadingToastPosition.bottom);
                  return;
                }
                final Map body = {
                  "firstname": firstName.text,
                  "lastname": lastName.text,
                  "dateOfBirth": dobDB,
                  "gender": gender,
                  "country": country,
                  "nationality": nationality,
                  "nationalIdentityNumber": nin.text,
                  "bankVerificationNumber": bvn.text,
                  "localGovernmentArea": lga
                };

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register2(body),
                    ));
              }),
              Hspace(context.height(.05)),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback fun;
  const Button(this.fun);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: fun,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Next",
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
      ),
    );
  }
}
