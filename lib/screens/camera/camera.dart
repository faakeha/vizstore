import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/controllers/camera_provider.dart';
import 'package:flutterdemo/models/product_json.dart';
import 'package:flutterdemo/screens/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../search/search.dart';
import 'package:http/http.dart' as http;
import 'storage_services.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({super.key, required this.camera});

  final CameraDescription camera;
  Storage storage = Storage();

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          await context.read<CameraProvider>().getProductsList(),
        });

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'AI Visual Search',
          backButton: true,
        ),
        // appBar: AppBar(
        //   leading: const BackButton(
        //     color: Colors.black,
        //   ),
        //   title: const Text(
        //     'Image Search',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //         color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        //   ),
        // ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();

              if (image != null) {
                _selectedImage = File(image.path);
              }
              setState(() {});
              if (!mounted) return;
              List similarImagesList = await context
                  .read<CameraProvider>()
                  .getSimilarImages(File(_selectedImage!.path),
                      "https://195a-111-88-41-214.ngrok.io/similar_image_search");

              List<ProductJson> list = context
                  .read<CameraProvider>()
                  .setSimilarProducts(similarImagesList);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Search(
                        allProducts: list,
                        imagePath: _selectedImage!.path,
                      )));
            } catch (e) {
              print(e);
            }
          },
          child: const Icon(Icons.camera_alt),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
