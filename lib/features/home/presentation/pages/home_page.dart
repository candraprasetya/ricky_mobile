import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:ricky_mobile/features/authentication/presentation/widgets/image_picker_widget.dart';
import 'package:ricky_mobile/utilities/utilities.dart';
import 'package:ricky_mobile/widgets/appbar_with_logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithLogo(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Swiper(
              itemCount: 3,
              autoplay: true,
              autoplayDelay: 10000,
              curve: Curves.fastOutSlowIn,
              indicatorLayout: PageIndicatorLayout.COLOR,
              pagination: const SwiperPagination(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white30,
                      activeColor: Colors.white,
                      size: 10.0,
                      activeSize: 10.0)),
              itemBuilder: (context, index) => Image.network(
                "https://firebasestorage.googleapis.com/v0/b/rickysmartphone-4504a.appspot.com/o/banner%2Fricky.png?alt=media&token=d4714a26-8dc6-4f23-a373-e99edf0a278b",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const ImagePickerWidget(),
        ],
      ),
    );
  }
}
