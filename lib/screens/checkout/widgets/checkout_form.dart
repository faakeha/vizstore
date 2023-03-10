import 'package:flutter/material.dart';
import 'package:flutterdemo/controllers/checkout_provider.dart';
import 'package:flutterdemo/models/user_json.dart';
import 'package:flutterdemo/screens/constants.dart';
import 'package:flutterdemo/screens/edit_profile/edit_profile.dart';
import 'package:flutterdemo/screens/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({Key? key}) : super(key: key);

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  String dropdownvalue = 'Karachi';

  bool enabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) async => {context.read<CheckoutProvider>().setCity(dropdownvalue)});
  }

  TextEditingController controllerAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserJson user = context.watch<CheckoutProvider>().user;

    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 250, 204, 67))
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                ).then((value) => context.read<CheckoutProvider>().getUser());
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.edit,color: Colors.black,),
                  ),
                  const Text("Edit Profile",style: TextStyle(color: Colors.black),),
                ],
              )
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Name",
            hintText: '${user.firstName} ${user.lastName}',
            enabled: enabled,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: SuffixIcon(icon: Icons.person),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Contact Number",
            hintText: user.contact,
            enabled: enabled,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: SuffixIcon(icon: Icons.phone_android),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Address",
            hintText: "Enter your address",
            enabled: !enabled,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: SuffixIcon(icon: Icons.location_on),
          ),
          onChanged: (String text) {
            context.read<CheckoutProvider>().setAddress(text);
          },
          controller: controllerAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter shipping address';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        Stack(children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "City",
              enabled: !enabled,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          Container(
            height: 64,
            padding: const EdgeInsets.only(left: 40.0, right: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                borderRadius: BorderRadius.circular(28),
                isExpanded: true,
                value: dropdownvalue,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: SecondaryDarkColor,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(color: SecondaryDarkColor),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    context.read<CheckoutProvider>().setCity(dropdownvalue);
                  });
                },
              ),
            ),
          ),
        ]),
        SizedBox(height: 20),
      ]),
    );
  }
}
