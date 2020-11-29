import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
//import 'package:slideshow/src/models/slider_model.dart';

//Todo Borrar
//import 'package:flutter_svg/svg.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final int tamano;
  final double bulletPrimario;

  SlideShow({
    @required this.slides,
    this.puntosArriba = false,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    this.tamano = 12,
    this.bulletPrimario = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //create: (_) => new SliderModel(),
      create: (_) => new _SlideShowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SlideShowModel>(context).tamano = this.tamano;
              Provider.of<_SlideShowModel>(context).bulletPrimario =
                  this.bulletPrimario;

              return _CrearEstructuraSlideShow(
                puntosArriba: puntosArriba,
                slides: slides,
                colorPrimario: colorPrimario,
                colorSecundario: colorSecundario,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CrearEstructuraSlideShow extends StatelessWidget {
  const _CrearEstructuraSlideShow({
    Key key,
    @required this.puntosArriba,
    @required this.slides,
    @required this.colorPrimario,
    @required this.colorSecundario,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;
  final Color colorPrimario;
  final Color colorSecundario;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (this.puntosArriba)
          _Dots(this.slides.length, this.colorPrimario, this.colorSecundario),
        Expanded(
          child: _Slides(this.slides),
        ),
        if (!this.puntosArriba)
          _Dots(this.slides.length, this.colorPrimario, this.colorSecundario),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  final Color colorPrimario;
  final Color colorSecundario;

  _Dots(this.totalSlides, this.colorPrimario, this.colorSecundario);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: <Widget>[
        //   _Dot(0),
        //   _Dot(1),
        //   _Dot(2),
        //   _Dot(3),
        // ],
        children: List.generate(this.totalSlides,
            (i) => _Dot(i, this.colorPrimario, this.colorSecundario)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color colorPrimario;
  final Color colorSecundario;

  _Dot(
    this.index,
    this.colorPrimario,
    this.colorSecundario,
  );

  @override
  Widget build(BuildContext context) {
    //final pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    //final pageViewIndex = Provider.of<_SlideShowModel>(context).currentPage;
    final ssModel = Provider.of<_SlideShowModel>(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: (ssModel.currentPage >= index - 0.5 &&
              ssModel.currentPage < index + 0.5)
          ? ssModel.bulletPrimario
          : ssModel.tamano.toDouble(),
      height: (ssModel.currentPage >= index - 0.5 &&
              ssModel.currentPage < index + 0.5)
          ? ssModel.bulletPrimario
          : ssModel.tamano.toDouble(),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (ssModel.currentPage >= index - 0.5 &&
                ssModel.currentPage < index + 0.5)
            ? this.colorPrimario
            : this.colorSecundario,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      //Provider.of<SliderModel>(context, listen: false).currentPage = pageViewController.page;
      Provider.of<_SlideShowModel>(context, listen: false).currentPage =
          pageViewController.page;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        // children: <Widget>[
        //   _Slide('assets/svgs/slide1.svg'),
        //   _Slide('assets/svgs/slide2.svg'),
        //   _Slide('assets/svgs/slide3.svg'),
        // ],
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlideShowModel with ChangeNotifier {
  double _currentPage = 0;
  int _tamano = 12;
  double _bulletPrimario = 15;

  double get currentPage => this._currentPage;

  set currentPage(double currentPage) {
    this._currentPage = currentPage;
    notifyListeners();
  }

  int get tamano => this._tamano;

  set tamano(int tamano) {
    this._tamano = tamano;
  }

  double get bulletPrimario => this._bulletPrimario;

  set bulletPrimario(double bullet) {
    this._bulletPrimario = bullet;
  }
}
