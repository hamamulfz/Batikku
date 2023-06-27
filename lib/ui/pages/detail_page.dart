import 'package:batikku/model/batik_detail_model.dart';
import 'package:batikku/shared/theme.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.result});
  final int result;

  final List<BatikDetailModel> mappingDesc = [
    BatikDetailModel(
        // assets nya nanti di tambahkan ke dalam folder assets untuk mengambil data foto dari batik yang nanti di ambil dari toko
        0,
        "Motif Asmat",
        "Namanya diambil dari suku asli penghuni Bumi Cendrawasih. Batik ini umumnya didominasi corak ukiran khas suku Asmat, seperti patung-patung duduk kayu yang menggambarkan keunikan dan tradisi patung ukir kayu dari masyarakat suku Asmat Papua",
        [
          'assets/img_motif_asmat.png'
        ], // contoh untuk memanggil data foto "assets/asimetris.png"
        "Price: Rp. 98.000"),
    BatikDetailModel(
        1,
        "Motif Cendrawasih",
        "Motif batik ini menonjolkan kecantikan burung cendrawasih dan alat musik Tifa. Warna-warna batiknya didominasi hijau, merah, dan kuning keemasan. Batik bermotif burung cendrawasih yang gagah memberikan kesan tegas pada penampilan pemakainya.",
        ['assets/img_motif_cendrawasih.png'],
        "Price: Rp. 107.000"),
    BatikDetailModel(
        2,
        "Motif Kamoro",
        "Motifnya melambangkan simbol Patung Berdiri membawa tombak. Motif Komoro menggambarkan kreativitas, semangat, keberanian penduduk asli Papua seperti kombinasi biru dan hijau, hitam dan kuning, merah dan merah muda.",
        ['assets/img_motif_kamoro.png'],
        "Price: Rp. 135.000"),
    BatikDetailModel(
        // coba penjelasan
        3,
        "Motif Parada",
        "Motif Prada menawarkan kemewahan dan kemegahan dengan sentuhan garis-garis emas. “Prada” adalah tekstil batik yang dihiasi dengan tinta emas. Motif Prada Papua mengadopsi peninggalan arkeologi di Papua. Motifnya sebagian besar diambil dari lukisan dinding gua di Biak di Papua Barat dan wilayah kabupaten Jayapura di Papua.",
        ['assets/img_motif_pradapapua.png'],
        "Price: Rp. 140.000"),
    BatikDetailModel(
        4,
        "Motif Sentani",
        "Batik Sentani dengan motifnya yang menampilkan alur batang kayu yang melingkar dengan sentuhan garis-garis emas. Batik ini memiliki filosofi yang unik, menggambarkan tanah Papua yang sangat subur dan kaya akan hasil bumi.",
        ['assets/img_motif_sentani.png'],
        "Price: Rp. 98.000"),
    BatikDetailModel(
        5,
        "Motif Tifa Honai",
        "Batik Tifa Honai memiliki filosofi yang cukup kuat. Sesuai namanya, Honai sebagai rumah adat Papua melambangkan keluarga, sedangkan alat musik tifa menonjolkan kebahagiaan. Keduanya bermakna kebersamaan keluarga yang bahagia. Motif ini juga terinspirasi kekayaan alam di Pulau Emas, seperti sumber mata air dan pemandangan yang indah.",
        ['assets/img_motif_tifahonai.png'],
        "Price: Rp. 99.000"),
  ];

  @override
  Widget build(BuildContext context) {
    // code dibawa, jika tidak ditemukan elemen pada list mappingDesc yang memiliki nilai <id> yang sama dengan result, maka objek BatikDetailModel dengan nilai default akan digunakan sebagai nilai selected.
    final selected = mappingDesc.firstWhere((element) => element.id == result,
        orElse: () => BatikDetailModel(0, "", "", [], ""));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brownBackgroundColor,
        title: Text(
          "Batik Information",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
            color: lightBackgroundColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: lightBackgroundColor,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  selected.images.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            // Tambahkan tindakan yang diinginkan ketika gambar di-tap
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                selected.images.first,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : const Placeholder(),
                  const SizedBox(height: 20),
                  Text(
                    selected.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 25,
                      fontWeight: semiBold,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(2, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    selected.price,
                    style: blackTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      selected.desc,
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  selected.desc.length > 300
                      ? const SizedBox(height: 20)
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
