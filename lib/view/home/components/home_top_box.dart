import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_arion/res/app_images.dart';
import 'package:quran_arion/res/app_svg.dart';

import '../../../res/app_colors.dart';

class HomeIntroBox extends StatelessWidget {
  const HomeIntroBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.imageList[11] ?? 'assets/images/12.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: shadowColor, offset: const Offset(8, 6), blurRadius: 12),
            const BoxShadow(
                color: Colors.white, offset:  Offset(-8, -6), blurRadius: 12),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Декоративные исламские паттерны (геометрические формы)
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.03),
                ),
              ),
            ),
            // Основное содержимое
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white70,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'See Recently',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Sweet Melody',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Little Mix  ',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Text(
                            '2033533 Listeners',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 8),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
                        child: Container(
                          height: 40,
                          width: 110,
                          margin: const EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black26),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Listen',style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                              ),),
                              const SizedBox(width: 10,),
                              CircleAvatar(
                                radius: 11,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: SvgPicture.asset(AppSvg.play,color: Colors.grey,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
