import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  final ImagePicker _picker = ImagePicker(); // Object image picker
  final box = GetStorage(); // Get storage variable
  var selectedImagePath = ''.obs; // Variable untuk menyimpan path image
  var isImageLoading =
      false.obs; // Variable untuk menyimpan image loading state
  var selectedVideoPath = ''.obs; // Variable untuk menyimpan path video
  var isVideoPlaying = false.obs; // Variable untuk play/pause state
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }

  // Function Future untuk mendapatkan foto menggunakan kamera atau galeri
  Future<void> pickImage(ImageSource source) async {
    try {
      isImageLoading.value = true;
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        box.write('imagePath',
            pickedFile.path); // Menyimpan image path ke Get Storage
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  // Function Future untuk mendapatkan video menggunakan kamera atau galeri
  Future<void> pickVideo(ImageSource source) async {
    try {
      isImageLoading.value = true;
      final XFile? pickedFile = await _picker.pickVideo(source: source);
      if (pickedFile != null) {
        selectedVideoPath.value = pickedFile.path;
        box.write('videoPath', pickedFile.path);

        // Initialize VideoPlayerController
        videoPlayerController =
            VideoPlayerController.file(File(pickedFile.path))
              ..initialize().then((_) {
                videoPlayerController!.play();
                isVideoPlaying.value = true; // Update status
                update(); // Notify UI
              });
      } else {
        print('No video selected.');
      }
    } catch (e) {
      print('Error picking video: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  void _loadStoredData() {
    selectedImagePath.value = box.read('imagePath') ?? '';
    selectedVideoPath.value = box.read('videoPath') ?? '';

    if (selectedVideoPath.value.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.file(File(selectedVideoPath.value))
            ..initialize().then((_) {
              videoPlayerController!.play();
              isVideoPlaying.value = true; // Update status
              update(); // Notify UI
            });
    }
  }

  // Function untuk memutar video
  void play() {
    videoPlayerController?.play();
    isVideoPlaying.value = true; // Update status
    update(); // Notify UI
  }

  // Function untuk pause video
  void pause() {
    videoPlayerController?.pause();
    isVideoPlaying.value = false; // Update status
    update(); // Notify UI
  }

  // Function untuk toggle play/pause
  void togglePlayPause() {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
        isVideoPlaying.value = false; // Update status
      } else {
        videoPlayerController!.play();
        isVideoPlaying.value = true; // Update status
      }
      update(); // Notify UI
    }
  }
}
