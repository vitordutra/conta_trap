import 'dart:async';
import 'package:conta_trap/src/utils/choices_controller.dart';
import 'package:conta_trap/src/widgets/choice_card.dart';
import 'package:conta_trap/src/widgets/fab.dart';
import 'package:conta_trap/src/classes/choice.dart';
import 'package:conta_trap/src/widgets/player_turn_card.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/material.dart';

class ChoiceScreenArgs {
  late List<String> players;
  late double billAmount;
}

class ChoiceScreen extends StatefulWidget {
  final ChoiceScreenArgs arguments;

  const ChoiceScreen({required this.arguments, Key? key}) : super(key: key);

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen>
    with TickerProviderStateMixin {
  List data = [1, 2, 3, 4];
  List selectedData = [];

  late int cardNum;

  late ChoicesController choicesController;
  Duration duration = const Duration(minutes: 1);
  Timer? timer;

  bool isWaitingPlayer = true;

  @override
  void initState() {
    super.initState();

    cardNum = 2 * (widget.arguments.players.length * 3);
    
    choicesController = ChoicesController(
        players: widget.arguments.players,
        billAmount: widget.arguments.billAmount);
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  // Timer stuff
  void resetTimer() {
    timer?.cancel();
    setState(() => duration = const Duration(minutes: 1));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  Widget buildTimer(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text('$minutes:$seconds',
        style: TextStyle(fontSize: 24, color: primaryColor));
  }

  void handleTimerStop() {}

  void handleSwipe() {
    isWaitingPlayer = !isWaitingPlayer;

    resetTimer();

    if (!isWaitingPlayer) {
      choicesController.next();
      startTimer();
    }
  }

  void handleAccept() {
    handleSwipe();
  }

  void handleReject() {
    handleSwipe();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    Size screenSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    Map a = ModalRoute.of(context)?.settings.arguments as Map;

    int dataLength = data.length;

    double cardHeight = screenSize.height - 240;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Timer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.timer,
                          color: primaryColor,
                          size: 32,
                        ),
                      ),
                      buildTimer(context),
                    ],
                  ),
                  // Card
                  Expanded(
                      child: Container(
                          // height: 400,
                          margin: const EdgeInsets.symmetric(vertical: 32),
                          child: TinderSwapCard(
                            animDuration: 300,
                            orientation: AmassOrientation.TOP,
                            totalNum: cardNum,
                            stackNum: 3,
                            swipeEdge: 4.0,
                            minWidth: (screenSize.width - 32) * 0.9,
                            maxWidth: screenSize.width - 32,
                            minHeight: cardHeight * 0.9,
                            maxHeight: cardHeight,
                            cardBuilder: (context, index) => index % 2 == 0
                                ? PlayerTurnCard(
                                    text:
                                        "${choicesController.getCurrentPlayer()},\né a sua vez",
                                    caption: "Arraste para qualquer lado")
                                : ChoiceCard(
                                    choice:
                                        choicesController.getCurrentChoice()),
                            cardController: controller = CardController(),
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation, int index) {
                              if (orientation == CardSwipeOrientation.LEFT) {
                                handleReject();
                              } else if (orientation ==
                                  CardSwipeOrientation.RIGHT) {
                                handleAccept();
                              }
                            },
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: isWaitingPlayer
                        ? <Widget>[
                            FAB(
                              size: 64,
                              onPressed: () => controller.triggerRight(),
                              child: const Image(
                                image: AssetImage("assets/icons/check.png"),
                                width: 28,
                                height: 28,
                              ),
                            )
                          ]
                        : <Widget>[
                            FAB(
                              size: 64,
                              onPressed: () => controller.triggerLeft(),
                              child: const Image(
                                image: AssetImage("assets/icons/close.png"),
                                width: 28,
                                height: 28,
                              ),
                            ),
                            FAB(
                              size: 64,
                              onPressed: () {
                                resetTimer();
                              },
                              child: const Image(
                                image: AssetImage("assets/icons/redo.png"),
                                width: 28,
                                height: 28,
                              ),
                            ),
                            FAB(
                              size: 64,
                              onPressed: () => controller.triggerRight(),
                              child: const Image(
                                image: AssetImage("assets/icons/check.png"),
                                width: 28,
                                height: 28,
                              ),
                            )
                          ],
                  )
                ],
              ))),
    );
  }
}
