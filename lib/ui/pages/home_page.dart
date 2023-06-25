import 'dart:async';

import 'package:batikku/main.dart';
import 'package:batikku/shared/theme.dart';
import 'package:batikku/ui/pages/detail_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = " ";

  // list ini akan menampung semua hasil prediksi selama 5 detik
  List<int> results = [];
  // 2 variabel berikut akan menyimpan mapping untuk ditampilkan ke UI
  Map<String, String> mapping = {
    "0": "Asimetris",
    "1": "Asmat",
    "2": "Burung Cendrawasih",
    "3": "Kamoro",
    "4": "Prada",
    "5": "Sentani",
    "6": "Tifa Honai",
  };
  Map<String, String> mappingDesc = {
    "0": "penjelasan Asimetris",
    "1": "penjelasan Asmat",
    "2": "penjelasan Burung",
    "3": "penjelasan Kamoro",
    "4": "penjelasan Prada",
    "5": "penjelasan Sentani",
    "6": "penjelasan Tifa Honai",
  };

  // fungsi untuk mengahpus semua hasil prediksi agar tetap valid saat dijalankan dalam waktu yang lama
  resetResult() {
    results.clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadmodel();
    // timer ini berfungsi menghapus semua hasil prediksi yang tersimpan secara periodik.
    Timer.periodic(const Duration(seconds: 5), (timer) {
      resetResult();
    });
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((ImageStream) {
            cameraImage = ImageStream;
            runModel();
          });
        });
      }
    });
  }

  bool isWorking = false;

  runModel() async {
    if (cameraImage != null && !isWorking) {
      isWorking = true;
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      print("here$output");

      for (var element in predictions!) {
        setState(() {
          output = element['label'];
        });

        results.add(int.parse(output[0]));
      }
      isWorking = false;
    }
  }

  // getter agar nulisnya ga panjang aja di UI
  get average => results.average();

  loadmodel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brownBackgroundColor,
        title: Text(
          "AR identifikasi Motif",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
            color: lightBackgroundColor,
          ),
        ),
      ),
      backgroundColor: lightBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Container(
            child: Text(
              output,
              // mapping["${average}"] ?? "....",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          // menampilkan hasil prediksi dengan menggunakan nama saja
          // jaga2 kalau baru running nilainya null, maka return container
          Builder(builder: (context) {
            if (average == null) return Container();
            return Container(
              child: Text(
                // output,
                mapping["$average"] ?? "....",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
              ),
            );
          }),

          // menampilkan detail hasil prediksi dengan menggunakan nama saja
          // jaga2 kalau baru running nilainya null, maka return container
          Builder(builder: (context) {
            if (average == null) return Container();
            return Container(
              child: Text(
                // output,
                mappingDesc["$average"] ?? "....",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              if (results.average() != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(result: results.average()!),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Try again"),
                  duration: Duration(seconds: 4),
                ));
              }
            },
            style: TextButton.styleFrom(
              backgroundColor:
                  brownBackgroundColor, // Warna latar belakang tombol
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(56), // Jari-jari border tombol
              ),
            ),
            child: Text("Baca selengkapnya",
                style: whiteTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                )),
          ),
          // button reset manual kalau diperlukan
          // ElevatedButton(
          //   onPressed: resetResult,
          //   child: Text("Reset"),
          // ),
        ],
      ),
    );
  }
}

// extension buat ngitung rata-rata, biar gampang aja
extension GetAverage on List<int> {
  int? average() {
    double sum = 0;
    forEach((element) {
      sum += element;
    });
    if (sum == 0 || isEmpty) return null;
    double avg = sum / length;
    return avg.round();
  }
}
