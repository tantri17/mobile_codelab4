import 'dart:io';
import 'package:codelab4/app/modules/video/controllers/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Menampilkan gambar yang diambil
              SizedBox(
                height: Get.height / 2.32,
                width: Get.width * 0.7,
                child: Obx(() {
                  if (controller.isImageLoading.value) {
                    return const CircularProgressIndicator();
                  } else if (controller.selectedImagePath.value != '') {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(controller.selectedImagePath.value),
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return const Text('No image selected');
                  }
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.pickImage(ImageSource.camera),
                child: const Text('Pick Image from Camera'),
              ),
              ElevatedButton(
                onPressed: () => controller.pickImage(ImageSource.gallery),
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 20),

              // Menampilkan video yang diambil
              SizedBox(
                height: Get.height / 2.32,
                width: Get.width * 0.7,
                child: Obx(() {
                  if (controller.selectedVideoPath.value.isNotEmpty) {
                    return Card(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: controller
                                    .videoPlayerController?.value.aspectRatio ??
                                1.0,
                            child:
                                VideoPlayer(controller.videoPlayerController!),
                          ),
                          VideoProgressIndicator(
                            controller.videoPlayerController!,
                            allowScrubbing: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  controller.isVideoPlaying.isTrue
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: controller.togglePlayPause,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('No video selected');
                  }
                }),
              ),
              ElevatedButton(
                onPressed: () => controller.pickVideo(ImageSource.camera),
                child: const Text('Pick Video from Camera'),
              ),
              ElevatedButton(
                onPressed: () => controller.pickVideo(ImageSource.gallery),
                child: const Text('Pick Video from Gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
