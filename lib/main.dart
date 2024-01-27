import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Pick & Do',
            style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "PoppinsBold",
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: CardShuffleAndPick(),
      ),
    );
  }
}

class CardShuffleAndPick extends StatefulWidget {
  @override
  _CardShuffleAndPickState createState() => _CardShuffleAndPickState();
}

class _CardShuffleAndPickState extends State<CardShuffleAndPick> {
  List<int> deck = List.generate(7, (index) => index + 1);
  Random random = Random();
  int? pickedCard;
  bool shuffle = true;
  void shuffleDeck() {
    setState(() {
      deck.shuffle();
      pickedCard = null;
    });
  }

  void pickRandomCard() {
    if (deck.isNotEmpty) {
      setState(() {
        setState(() {
          shuffle = true;
        });
        controller.swipeLeft();

        int counter = 0;
        Timer.periodic(Duration(milliseconds: 200), (timer) {
          counter++;
          if (counter % 2 == 0) {
            controller.swipeLeft();
          } else {
            controller.swipeRight();
          }

          if (counter >= 5) {
            timer.cancel();
            pickedCard = (random.nextInt(deck.length));
            setState(() {
              shuffle = false;
            });
          }
        });
        //
      });
    }
  }

  final CardSwiperController controller = CardSwiperController();

  final cards = [
    Image.asset(
      'assets/images/default.png',
      height: 350,
      width: 350,
    ),
    Image.asset(
      'assets/images/default.png',
      height: 350,
      width: 350,
    ),
    Image.asset(
      'assets/images/default.png',
      height: 350,
      width: 350,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0XFF21201E),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Text(
                          pickedCard == null ? "-" : pickedCard.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                          child: InkWell(
                        onTap: pickRandomCard,
                        child: Image.asset(
                          "assets/images/shuffle.png",
                          height: 60,
                        ),
                      )),
                    ],
                  )),
                  Container(child:Text("Click and see full the task",style: TextStyle(color: Colors.white,fontFamily: "PoppinsLight"),) ,),
              !shuffle
                  ? Card(
                      elevation: 0.0,
                      margin: EdgeInsets.only(
                          left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
                      color: Color(0x00000000),
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        side: CardSide.FRONT,
                        speed: 1000,
                        onFlipDone: (status) {
                          print(status);
                        },
                        front: Container(
                          decoration: BoxDecoration(
                            //color: Color(0xFF006666),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/$pickedCard.png',
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                              ),
                            ],
                          ),
                        ),
                        back: Container(
                          decoration: BoxDecoration(
                          
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/b$pickedCard.png',
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                width: MediaQuery.of(context).size.width * 2.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: CardSwiper(
                        isLoop: true,
                        controller: controller,
                        cardsCount: cards.length,
                        //onSwipe: _onSwipe,
                        //onUndo: _onUndo,
                        numberOfCardsDisplayed: 3,
                        backCardOffset: const Offset(40, 40),
                        padding: const EdgeInsets.all(24.0),
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) =>
                            cards[index],
                      ),
                    ),
              SizedBox(height: 20.0),
             
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
