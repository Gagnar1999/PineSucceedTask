import 'package:flutter/material.dart';
import 'package:test_project/components/TextFormField.dart';

class UpdateDialog extends StatefulWidget {
  const UpdateDialog({Key? key}) : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        backgroundColor: Colors.grey,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Update Profile",
                style: const TextStyle(
                    color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              AppTextFormField(
                label: "Enter Name*",
                textInputType: TextInputType.name,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter Name";
                  }
                  return null;
                },
              ),
              AppTextFormField(
                label: "Enter Age*",
                textInputType: TextInputType.number,
                maxLength: 3,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter age";
                  }
                  int age = int.parse(value);
                  if(age > 120 || age < 0){
                    return "Please enter valid age";
                  }
                  return null;
                },
              ),
              AppTextFormField(
                label: "Enter Mobile Number*",
                textInputType:  TextInputType.number,
                maxLength: 10,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter mobile number";
                  }
                  if(value.length != 10){
                    return "Please enter valid mobile number";
                  }
                  return null;
                },
              ),
              FilledButton(onPressed: () {
                if(_formKey.currentState?.validate() == true){
                  print("updated");
                }
              }, child: Text("Update"), style: FilledButton.styleFrom(backgroundColor: Colors.indigoAccent),)
            ],
          ),
        ),
      ),
    );
  }
}
