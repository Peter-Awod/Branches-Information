import 'package:branches_information/shared/components/components.dart';
import 'package:branches_information/shared/cubit/app_cubit.dart';
import 'package:branches_information/shared/cubit/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'branches_details.dart';

class BranchesListView extends StatelessWidget {
  String categoryID;
  String categoryName;

  BranchesListView({required this.categoryID, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitVar = AppCubit.get(context);
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
              ),
            ),
            title: Text(
              '${categoryName} branches',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: cubitVar.branches.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return OutlinedButton(
                      onPressed: () {
                        pushNavigateTo(context, BranchesDetails(branchModel: cubitVar.branches[index],));
                      },
                      child: Text('${cubitVar.branches[index].branchName}'),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                  itemCount: cubitVar.branches.length,
                );
              },
              fallback: (context) => LinearProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
