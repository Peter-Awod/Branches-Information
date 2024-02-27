
import 'package:branches_information/shared/cubit/app_cubit.dart';
import 'package:branches_information/shared/cubit/app_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';

import '../../models/branche_model/branche_model.dart';
import 'full_screen_gallery.dart';

class BranchesDetails extends StatelessWidget {
  BranchModel branchModel;

  BranchesDetails({required this.branchModel});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubitVar = AppCubit.get(context);
        List<String>gallery=branchModel.imageUrls!;
        List<String>videoGallery=branchModel.videoUrls!;

        Widget videoItemBuilder( element){
          return Container(
            height: 300,
            child: Chewie(
              controller: ChewieController(
                videoPlayerController:
                VideoPlayerController.networkUrl(Uri.parse('${element}')),

                autoPlay: false,
                looping: false,
                // placeholder: Image(image: AssetImage('assets/images/images.png')),
              ),
            ),
          );
        }
        List<Widget>videoBuilder=[];
        videoGallery.forEach((element) {
          videoBuilder.add(videoItemBuilder(element));
        });
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
              '${branchModel.branchName}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // images view here
                  GestureDetector(
                    onTap: () {
                      // Get the tapped index and navigate to fullscreen

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenGallery(
                            gallery: gallery,
                            initialIndex: cubitVar.currentIndex,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 200, // Set the desired height of the image gallery
                      child: PhotoViewGallery.builder(
                        itemCount: gallery.length,
                        builder: (context, index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider:
                            NetworkImage(gallery[index]),
                            minScale: PhotoViewComputedScale.covered,
                            maxScale: PhotoViewComputedScale.covered * 2,
                            heroAttributes: PhotoViewHeroAttributes(tag: index),
                          );
                        },
                        scrollPhysics: BouncingScrollPhysics(),
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        pageController: PageController(initialPage: cubitVar.currentIndex),
                        onPageChanged: (index) {
                          cubitVar.updateIndex(index);
                        },
                      ),
                    ),
                  ),
                  ///////////
                  // Videos List here branchModel.videoUrls
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Videos:'),
                      SizedBox(height: 8),
                      // Add Video Player widget here
                      CarouselSlider(
                        items: videoBuilder,
                        options: CarouselOptions(
                          height: 250,
                          initialPage: 0,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          scrollDirection: Axis.horizontal,
                          scrollPhysics: BouncingScrollPhysics(),

                        ),
                      ),
                      // Container(
                      //   height: 300,
                      //   child: Chewie(
                      //     controller: ChewieController(
                      //       videoPlayerController:
                      //       VideoPlayerController.networkUrl(Uri.parse('${branchModel.videoUrls![0]}')),
                      //
                      //       autoPlay: false,
                      //       looping: false,
                      //       // placeholder: Image(image: AssetImage('assets/images/images.png')),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  /////////////////////////
                  Text('Branch name: ${branchModel.branchName}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Branch adderess: ${branchModel.address}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Added by: ${branchModel.userName}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Added time ${branchModel.dateTime}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Description ${branchModel.description}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}

////////


