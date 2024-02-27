import 'package:branches_information/shared/cubit/app_cubit.dart';
import 'package:branches_information/shared/cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class FullScreenGallery extends StatelessWidget {
  final List<String> gallery;
  final int initialIndex;

  FullScreenGallery({required this.gallery, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context, state) {

     },
     builder: (context, state) {
       return Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.black,
         ),
         body: Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,
           child: PhotoViewGallery.builder(
             itemCount: gallery.length,
             builder: (context, index) {

               return PhotoViewGalleryPageOptions(
                 imageProvider: NetworkImage(gallery[index]),
                 minScale: PhotoViewComputedScale.contained,
                 maxScale: PhotoViewComputedScale.covered * 2,
                 heroAttributes: PhotoViewHeroAttributes(tag: index),
               );
             },
             scrollPhysics: BouncingScrollPhysics(),
             backgroundDecoration: BoxDecoration(
               color: Colors.black,
             ),
             pageController: PageController(initialPage: initialIndex),
           ),
         ),
       );
     },
   );
  }
}

