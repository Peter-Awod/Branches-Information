import 'package:branches_information/models/user_model/user_model.dart';
import 'package:branches_information/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/add_new_branch/add_new_branch.dart';
import '../modules/add_new_category/add_new_category.dart';
import '../modules/details/branches_list_view.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/app_cubit.dart';
import '../shared/cubit/app_states.dart';
import '../shared/styles/icon_broken.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // if (state is GetCategoriesSuccessState) {
        //   // pushNavigateTo(context, NewBranchScreen());
        // }
      },
      builder: (context, state) {
        var user = AppCubit.get(context).userModel;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Home',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    logOut(context: context);
                  },
                  icon:  Icon(
                    IconBroken.Logout,
                    color: Colors.grey,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ConditionalBuilder(
              condition: user != null,
              fallback: (context) => const LinearProgressIndicator(),
              builder: (context) {
                if (user!.isAdmin == true) {
                  return adminView(userModel: user, context: context);
                } else {
                  return userView(userModel: user, context: context);
                }
              },
            ),
          ),
        );
      },
    );
  }

  // User view
  Widget userView(
          {required UserModel userModel, required BuildContext context}) =>
      Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Welcome ${userModel.name}'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('To add a new branch '),
              TextButton(
                onPressed: () async {
                  await AppCubit.get(context).getCategories().then((value) {
                    pushNavigateTo(context, NewBranchScreen());
                  });
                },
                child: Text('Click here'),
              ),
            ],
          )
        ],
      );

  // Admin view
  Widget adminView(
          {required UserModel userModel, required BuildContext context}) =>
      Column(
        children: [
          Text('Welcome Admin ${userModel.name}'),
          Expanded(
            flex: 4,
            child: ConditionalBuilder(
              condition: AppCubit.get(context).categories.isNotEmpty,
              fallback: (context) => Text('No categories added yet'),
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) {
                  return OutlinedButton(
                    onPressed: () async {
                      await AppCubit.get(context)
                          .getBranches(
                              categoryId: AppCubit.get(context)
                                  .categories[index]
                                  .categoryID!)
                          .then((value) {
                        pushNavigateTo(
                          context,
                          BranchesListView(
                            categoryID: AppCubit.get(context)
                                .categories[index]
                                .categoryID!,
                            categoryName:
                                AppCubit.get(context).categories[index].name!,
                          ),
                        );
                      });
                    },
                    child:
                        Text('${AppCubit.get(context).categories[index].name}'),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
                itemCount: AppCubit.get(context).categories.length,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('To add a new category '),
                    TextButton(
                      onPressed: () {
                        pushNavigateTo(context, NewCategoryScreen());
                      },
                      child: Text(
                        'Click here',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('To add a new branch '),
                    TextButton(
                      onPressed: () async {
                        await AppCubit.get(context)
                            .getCategories()
                            .then((value) {
                          pushNavigateTo(context, NewBranchScreen());
                        });
                      },
                      child: Text(
                        'Click here',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
