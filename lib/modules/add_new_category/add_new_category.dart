import 'package:branches_information/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class NewCategoryScreen extends StatelessWidget {
  var categoryNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is CreateCategorySuccessState)
        {
          categoryNameController.text='';
          AppCubit.get(context).getCategories();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                )),
            title: Text(
              'Add category',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: TextFormField(
                        controller: categoryNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          label: const Text('Category name'),
                          prefixIcon: const Icon(Icons.category_outlined),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Category name must not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultMaterialButton(
                    function: () {
                      if(formKey.currentState!.validate())
                        {
                          AppCubit.get(context).addNewCategory(categoryName: categoryNameController.text);
                        }


                    },
                    text: 'Add',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
