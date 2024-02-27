import 'package:branches_information/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/category_model/category_model.dart';
import '../../models/user_model/user_model.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import '../../shared/styles/icon_broken.dart';

class NewBranchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var branchNameController = TextEditingController();
  var describtionController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CreateBranchSuccessState) {
          branchNameController.text = '';
          describtionController.text = '';
          addressController.text = '';
          AppCubit.get(context).selectedCategory = null;
          showToast(msg: 'Branch added successfully', status: MsgState.SUCCESS);
        }
      },
      builder: (context, state) {
        var user = AppCubit.get(context).userModel;

        var categoriesList = AppCubit.get(context).categories;

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
              'Add branch',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ConditionalBuilder(
              condition: user != null && categoriesList.isNotEmpty,
              fallback: (context) => const LinearProgressIndicator(),
              builder: (context) {
                return Center(
                  child: addBranch(
                      userModel: user!,
                      context: context,
                      categoriesList: categoriesList,
                      state: state,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget addBranch({
    required UserModel userModel,
    required BuildContext context,
    required List<CategoryModel> categoriesList,
    required state,
  }) =>
      Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // dropDownMenu(categoriesList: categoriesList, context: context),
              Center(
                child: DropdownButtonFormField<String>(
                  hint: Text(
                    'Select category',
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                    AppCubit.get(context).changeSelectedCategory(newValue);
                  },
                  items: categoriesList
                      .map<DropdownMenuItem<String>>((CategoryModel category) {
                    return DropdownMenuItem<String>(
                      value: category.categoryID,
                      child: Text('${category.name}'),
                    );
                  }).toList(),
                  value: AppCubit.get(context).selectedCategory,
                  // initial value
                  borderRadius: BorderRadius.circular(10),
                  validator: (val) {
                    if (val == null) {
                      return 'You have to select a category';
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.category_outlined,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade900),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelStyle: TextStyle(color: Colors.grey[900]),
                    prefixIconColor: Colors.grey[900],
                  ),
                  dropdownColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //
              TextFormField(
                controller: branchNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade900),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text(
                    'Branch name',
                  ),
                  prefixIcon: const Icon(
                    Icons.home_work_outlined,
                  ),
                  labelStyle: TextStyle(color: Colors.grey[900]),
                  prefixIconColor: Colors.grey[900],
                ),
                cursorColor: Colors.grey[900],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Branch name must not be empty';
                  } else {
                    return null;
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),

              //
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade900),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text('Branch address'),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  labelStyle: TextStyle(color: Colors.grey[900]),
                  prefixIconColor: Colors.grey[900],
                ),
                cursorColor: Colors.grey[900],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Branch address must not be empty';
                  } else {
                    return null;
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),
              //
              TextFormField(
                controller: describtionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade900),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Branch describtion (optional)',
                  prefixIconColor: Colors.grey[900],
                  hintStyle: TextStyle(color: Colors.grey[900]),
                ),
                cursorColor: Colors.grey[900],
                minLines: 3,
                maxLines: 10,
              ),
              //
              SizedBox(
                height: 20,
              ),
              // button
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await AppCubit.get(context).getImages().then((value) {
                            AppCubit.get(context)
                                .upload(branchName: branchNameController.text);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Text('Get images'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(IconBroken.Camera),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await AppCubit.get(context).getVideos().then((value) {
                            AppCubit.get(context)
                                .uploadVideos(branchName: branchNameController.text);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Text('Get Videos'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(IconBroken.Camera),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ConditionalBuilder(
                  condition: state is UploadImagesLoadingState || state is UploadVideosLoadingState,
                  builder: (context) => LinearProgressIndicator(),
                  fallback: (context) => OutlinedButton(
                    onPressed: () {
                      var dateTime = DateFormat.yMMMMEEEEd()
                          .add_jm()
                          .format(DateTime.now());

                      // String formattedDateTime=DateFormat('EEEE, MMMM, dd, yyyy, HH:mm:ss').format(dateTime);

                      if (formKey.currentState!.validate()) {
                        print('Safe Submission');

                        AppCubit.get(context).addNewbranch(
                          branchName: branchNameController.text,
                          address: addressController.text,
                          dateTime: dateTime.toString(),
                          categoryID: AppCubit.get(context).selectedCategory!,
                          description: describtionController.text,
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );


// End {}
}
