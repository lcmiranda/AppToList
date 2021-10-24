import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  /// Comment or uncomment to run both examples
  runApp(
    WithBuilder(),
    //WithPages()
  );
}

///Class to hold data for itembuilder in Withbuilder app.
class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

/// Example of LiquidSwipe with itemBuilder
class WithBuilder extends StatefulWidget {
  @override
  _WithBuilder createState() => _WithBuilder();
}

class _WithBuilder extends State<WithBuilder> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  List<ItemData> data = [
    ItemData(Color(0xFF90cf5d), "assets/images/capa.jpg", "O", "Testamento", "da cachorra"),
    ItemData(Color(0xFF5dcf9c), "assets/images/chico.png", "Não sei!", "só sei quie foi assim.",
        ""),
        ItemData(Color(0xFF5dcfc9), "assets/images/dora.jpg", "Abre", "essa porta,", "eurico.!"),
    ItemData(Color(0xFF5d98cf), "assets/images/1599742240900.jpg", "Isso é", "hora de chegar", "em uma casa de respeito?!"),
    
    ItemData(Color(0xFF705dcf), "assets/images/1599742240901.jpg", "- Foi Logo dizendo I love you.", "- I love you?!",
      "É, quer dizer Morena em francês"),
    ItemData(Color(0xFFcf5d6c), "assets/images/chico-e-joao-grilo.jpg", "Ta aí Chicó, tu tem cara de ajudante.", "Tu ajuda o padeiro e com o dinheiro que ele te der, tu vai e me ajuda.", 
    "Ta achando que tenho cara de besta?!  Besta e ajudate é quase a mesma coisa."),
    
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  color: data[index].color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        data[index].image,
                        height: 400,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 60),
                      child:
                      Column(
                        children: <Widget>[
                          
                          Text(
                            data[index].text1,
                            style: WithPages.style,
                          ),
                          Text(
                            data[index].text2,
                            style: WithPages.style,
                          ),
                          Text(
                            data[index].text3,
                            style: WithPages.style,
                          ),
                        ],
                      ),
                       ),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              enableLoop: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Padding(
            //     padding: const EdgeInsets.all(25.0),
            //     child: FlatButton(
            //       onPressed: () {
            //         liquidController.animateToPage(
            //             page: data.length - 1, duration: 700);
            //       },
            //       child: Text("Skip to End"),
            //       color: Colors.white.withOpacity(0.01),
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.all(25.0),
            //     child: FlatButton(
            //       onPressed: () {
            //         liquidController.jumpToPage(
            //             page: liquidController.currentPage + 1 > data.length - 1
            //                 ? 0
            //                 : liquidController.currentPage + 1);
            //       },
            //       child: Text("Next"),
            //       color: Colors.white.withOpacity(0.01),
            //     ),
            //   ),
            //)
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

///Example of App with LiquidSwipe by providing list of widgets
class WithPages extends StatefulWidget {
  // ignore: prefer_const_constructors
  static final style = TextStyle(
    fontSize: 25,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  const WithPages({Key? key}) : super(key: key);

  @override
  _WithPages createState() => _WithPages();
}

class _WithPages extends State<WithPages> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    Container(
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Hi",
                style: WithPages.style,
              ),
              Text(
                "It's Me",
                style: WithPages.style,
              ),
              Text(
                "Sahdeep",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Take a",
                style: WithPages.style,
              ),
              Text(
                "look at",
                style: WithPages.style,
              ),
              Text(
                "Liquid Swipe",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Liked?",
                style: WithPages.style,
              ),
              Text(
                "Fork!",
                style: WithPages.style,
              ),
              Text(
                "Give Star!",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.yellowAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Can be",
                style: WithPages.style,
              ),
              Text(
                "Used for",
                style: WithPages.style,
              ),
              Text(
                "Onboarding Design",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Do",
                style: WithPages.style,
              ),
              Text(
                "Try it",
                style: WithPages.style,
              ),
              Text(
                "Thank You",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              enableSideReveal: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Padding(
            //     padding: const EdgeInsets.all(25.0),
            //     child: FlatButton(
            //       onPressed: () {
            //         liquidController.animateToPage(
            //             page: pages.length - 1, duration: 700);
            //       },
            //       child: Text("Skip to End"),
            //       color: Colors.white.withOpacity(0.01),
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.all(25.0),
            //     child: FlatButton(
            //       onPressed: () {
            //         liquidController.jumpToPage(
            //             page:
            //                 liquidController.currentPage + 1 > pages.length - 1
            //                     ? 0
            //                     : liquidController.currentPage + 1);
            //       },
            //       child: Text("Next"),
            //       color: Colors.white.withOpacity(0.01),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}