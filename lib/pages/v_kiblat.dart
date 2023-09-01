import 'package:flutter/material.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';
// import 'package:simasjid/pages/settings.dart';

class KiblatView extends StatefulWidget {
  const KiblatView({Key? key}) : super(key: key);

  @override
  State<KiblatView> createState() => _KiblatViewState();
}

class _KiblatViewState extends State<KiblatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arah Kiblat',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true, // Tambahkan ini untuk mengatur judul di tengah
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("assets/kiblat/kabah.png"),
          ),
          Container(
            child: Center(
              child: SmoothCompass(
                isQiblahCompass: true,
                compassBuilder: (context, snapshot, child) {
                  return AnimatedRotation(
                    turns: snapshot?.data?.turns ?? 0 / 360,
                    duration: const Duration(milliseconds: 400),
                    child: SizedBox(
                      height: 350,
                      width: 350,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Image.asset(
                              "assets/kiblat/compasskabah.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 0,
                            right: 0,
                            bottom: 20,
                            child: AnimatedRotation(
                              turns: (snapshot?.data?.qiblahOffset ?? 0) / 360,
                              duration: const Duration(milliseconds: 400),
                              child: Image.asset(
                                "assets/kiblat/panahkiblat.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
