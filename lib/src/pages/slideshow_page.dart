import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:slideshow/src/widgets/slideshow.dart';

class SlideShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.purple,
        body: Column(
      children: <Widget>[
        Expanded(child: MiSlideShow()),
        //Expanded(child: MiSlideShow()),
      ],
    ));
  }
}

class MiSlideShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlideShow(
      bulletPrimario: 15,
      puntosArriba: false,
      colorPrimario: Colors.orange,
      colorSecundario: Colors.grey,
      tamano: 10,
      slides: <Widget>[
        SvgPicture.asset('assets/svgs/slide1.svg'),
        SvgPicture.asset('assets/svgs/slide2.svg'),
        SvgPicture.asset('assets/svgs/slide3.svg'),
        SvgPicture.asset('assets/svgs/slide4.svg'),
        SvgPicture.asset('assets/svgs/slide5.svg'),
        // Text('Hello world'),
        // Container(
        //   width: 200,
        //   height: 200,
        //   color: Colors.blue,
        // ),
      ],
    );
  }
}
