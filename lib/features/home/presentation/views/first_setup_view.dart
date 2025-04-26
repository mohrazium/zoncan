
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/core/common/common.dart';

class FirstSetupView extends StatefulWidget {
  const FirstSetupView({super.key});

  @override
  State<FirstSetupView> createState() => _FirstSetupViewState();
}

class _FirstSetupViewState extends State<FirstSetupView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormCard(
        haveShadow: false,

        // globalFormKey: controller.personalInfoFormGlobalKey,
        // readyOnly: controller.readOnly.value,
        onConfirmButtonPressed: () => {},
        onCancelButtonPressed: () => {},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        headerContent: const Center(
          child: Text(
            "Strings.personalInfo",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        readyOnly: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              children: [
                TextBox(
                  keyboardType: TextInputType.number,
                  titleText: "Strings.nationalCode",
                  maxLength: 10,
                  // controller: controller.nationalCodeController,
                  // readOnly: controller.readOnly.value,
                  isRequired: true,
                  // validator: (val) => controller.nationalIdentityValidator(
                  //     value: val,
                  //     errorMessage: Strings.wrongNationalIdentity),
                  //   onChanged: (val) =>
                  //       controller.onChangedNationalCodeField(val),
                ),
                //! National code field
                TextBox(
                  keyboardType: TextInputType.number,
                  titleText: "Strings.nationalCode",
                  maxLength: 10,
                  // controller: controller.nationalCodeController,
                  // readOnly: controller.readOnly.value,
                  isRequired: true,
                  // validator: (val) => controller.nationalIdentityValidator(
                  //     value: val,
                  //     errorMessage: Strings.wrongNationalIdentity),
                  //   onChanged: (val) =>
                  //       controller.onChangedNationalCodeField(val),
                ),

                //! First name field
                TextBox(
                  titleText: "Strings.firstName",
                  // controller: controller.firstNameController,
                  // readOnly: controller.readOnly.value,
                  isRequired: true,
                  // validator: (val) =>
                  //     controller.requiredFieldValidator(value: val),
                  // onChanged: (val) =>
                  //     controller.onChangedFirstAndLastNameField(val),
                ),

                //! Father name field
                TextBox(
                  titleText: "Strings.fatherName",
                  // controller: controller.fatherNameController,
                  // readOnly: controller.readOnly.value,
                  isRequired: true,
                  // validator: (val) =>
                  //     controller.requiredFieldValidator(value: val),
                ),
                //! Place of birth field
                TextBox(
                  titleText: "Strings.placeOfBirth",
                  // controller: controller.placeOfBirthController,
                  // readOnly: controller.readOnly.value,
                ),
              ],
            ),
            Column(
              children: [
                //! National id field
                const TextBox(
                  keyboardType: TextInputType.number,
                  titleText: "Strings.nationalIdentity",
                  maxLength: 10,
                  // controller: controller.nationalIdentityController,
                  // readOnly: controller.readOnly.value,
                ),

                //! Last name field
                const TextBox(
                  titleText: "Strings.lastName",
                  // controller: controller.lastNameController,
                  // readOnly: controller.readOnly.value,
                  isRequired: true,
                  // validator: (val) =>
                  //     controller.requiredFieldValidator(value: val),
                  // onChanged: (val) =>
                  //     controller.onChangedFirstAndLastNameField(val),
                ),

                //! Date of birth field
                TextBox(
                  titleText: "Strings.dateOfBirth",
                  // controller: controller.dateOfBirthController,
                  // readOnly: controller.readOnly.value,
                  // inputFormatters: [
                  //   MaskedInputFormatter(
                  //     "0000/00/00",
                  //     allowedCharMatcher: RegExp('[0-9]'),
                  //   ),
                  // ],
                  prefixIcon: IconButton(
                    icon: const Icon(
                      EvaIcons.calendar,
                      // color: Colorize.primaryColorShade300,
                    ),
                    onPressed: () {},
                    // validator: (val) => controller.dateValidator(value: val)
                  ),
                ),

                //! Place of birth name field
                const TextBox(
                  titleText: "Strings.placeOfIssue",
                  // controller: controller.placeOfIssueController,
                  // readOnly: controller.readOnly.value,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
