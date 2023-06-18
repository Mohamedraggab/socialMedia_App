import 'package:flutter/material.dart';
Widget customTextFiled(
{
  required String labelString,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  required String? Function(String?)? validateFunction ,
  required bool isPassword,
  required TextInputType keyboardType ,
  required TextEditingController? controller,
}
    )
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35)),gapPadding: 4 ),
        label: Text(labelString),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: Icon(suffixIcon),
      ),
      controller: controller,
      maxLines: 1,
      validator: validateFunction,
      keyboardType: keyboardType,
      obscureText: isPassword,

    ),
  );
}






Widget customButton(
    {
      required String labelString,
      required var formKey,
      required void Function()? onPress
    }
    )
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35))),
          ),
          onPressed: onPress,
          child: Text(labelString)),
    ),
  );
}


