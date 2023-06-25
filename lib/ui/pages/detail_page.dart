import 'package:batikku/model/batik_detail_model.dart';
import 'package:batikku/shared/theme.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.result});
  final int result;

  // uji coba untuk membuat desc
  final List<BatikDetailModel> mappingDesc = [
    BatikDetailModel(
        // assets nya nanti di tambahkan ke dalam folder assets untuk mengambil data foto dari batik yang nanti di ambil dari toko
        0,
        "Asimetris",
        "penjelasan Asimetris",
        [
          'assets/img_onboarding1.png'
        ], // contoh untuk memanggil data foto "assets/asimetris.png"
        "Price: 160rb"),
    BatikDetailModel(1, "Asmat", "penjelasan Asmat",
        ['assets/img_onboarding1.png'], "Price: 160rb"),
    BatikDetailModel(2, "Burung", "penjelasan Burung",
        ['assets/img_onboarding2.png'], "Price: 160rb"),
    BatikDetailModel(
        // coba penjelasan
        3,
        "Kamoro",
        "penjelasan Kamoro : There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. ",
        ['assets/img_onboarding3.png'],
        "Price: 160rb"),
    BatikDetailModel(4, "Prada", "penjelasan Prada",
        ['assets/img_onboarding1.png'], "Price: 160rb"),
    BatikDetailModel(5, "Sentani", "penjelasan Sentani",
        ['assets/img_onboarding1.png'], "Price: 160rb"),
    BatikDetailModel(6, "Tifa Honai", "penjelasan Tifa Honai",
        ['assets/img_onboarding1.png'], "Price: 160rb"),
  ];

  @override
  Widget build(BuildContext context) {
    // code dibawa, jika tidak ditemukan elemen pada list mappingDesc yang memiliki nilai <id> yang sama dengan result, maka objek BatikDetailModel dengan nilai default akan digunakan sebagai nilai selected.
    final selected = mappingDesc.firstWhere((element) => element.id == result,
        orElse: () => BatikDetailModel(0, "", "", [], ""));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brownBackgroundColor,
        title: const Text("Batik Information"),
      ),
      // menggunkan singlechildscrollview karna apa bila widget desc melebih 300 kata kan bisa di scroll ke bawa  untuk dibaca
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selected.images.isNotEmpty
                  ? Image.asset(
                      selected.images.first,
                      height: 200,
                    )
                  : const Placeholder(),
              const SizedBox(height: 20),
              Text(
                selected.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                selected.price,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  selected.desc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              // apabila key dari deskripsi melebih 300 kata akan di jalankan fungsi
              selected.desc.length > 300
                  ? const SizedBox(height: 20)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
