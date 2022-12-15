import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/screens/constants.dart';
import '../search/search.dart';
import 'package:http/http.dart' as http;

import 'storage_services.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({super.key, required this.camera});

  final CameraDescription camera;
  Storage storage = Storage();
  @override
  // ignore: no_logic_in_create_state
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
  Future<http.Response> uploadImage(File file, String link) async {
    String filename = file.path.split('/').last;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(link),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
      ),
    );
    request.headers.addAll(headers);
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black,),
        title: const Text(
          'Image Search',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),
          ),
        ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            //await GallerySaver.saveImage(image.path);
            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            //await widget.storage.uploadFile(image.name,image.path).then((value) => print("done"));
            //final res = await uploadImage(File(image.path),"https://9fce-111-88-37-179.ngrok.io/upload");
            final response = await http.get(Uri.parse("https://3de5-111-88-37-179.ngrok.io/upload"));
            var encodeFirst = json.encode(response.body);

            final decoded = json.decode(encodeFirst);
            // await Navigator.of(context).push(
            //   // MaterialPageRoute(
            //   //   builder: (context) => DisplayPictureScreen(
            //   //     // Pass the automatically generated path to
            //   //     // the DisplayPictureScreen widget.
            //   //     imagePath: image.path,
            //   //     camera: camera,
            //   //   ),
            //   // ),
            //   MaterialPageRoute(builder: (_) => Check(greeting : decoded))
            // );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.transparent,
    );
  }
}

// uploadImage(File file)(
//   var request = http.MultipartRequest("POST",Uri.parse(""));
  
// )


// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath, required this.camera});

  final CameraDescription camera;
  @override
  Widget build(BuildContext context) {
    print("Image 1: $imagePath");
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
                title: Text("Front Pose",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                ) ,
                textAlign: TextAlign.center,
                )
            ),
            SizedBox(
                  height: 500,
                  child: Image.file(File(imagePath)),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => ThirdScreen(camera: camera))
                // );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
              ),
              child: const Text("Next"),
            )
          ]
        ),
      )
    );
  }
}