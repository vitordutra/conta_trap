import 'dart:async';
import 'dart:math';
import 'package:conta_trap/src/classes/match.dart';
import 'package:conta_trap/src/core/widgets/badge.dart';
import 'package:conta_trap/src/screens/results_screen.dart';
import 'package:conta_trap/src/services/database_handler.dart';
import 'package:conta_trap/src/services/match_dao.dart';
import 'package:conta_trap/src/utils/choices_controller.dart';
import 'package:conta_trap/src/widgets/choice_card.dart';
import 'package:conta_trap/src/widgets/fab.dart';
import 'package:conta_trap/src/widgets/player_turn_card.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:path/path.dart';

class GameplayScreenArgs {
  final List<String> players;
  final double bill;

  const GameplayScreenArgs({required this.players, required this.bill});
}

class GameplayScreen extends StatefulWidget {
  final GameplayScreenArgs arguments;

  const GameplayScreen({required this.arguments, Key? key}) : super(key: key);

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen>
    with TickerProviderStateMixin {
  // initialized in initState
  late MatchController matchController;
  List<int> playesTurns = [];

  late CardController controller = CardController();

  late Duration duration;
  Timer? timer;

  bool isWaitingPlayer = true;

  @override
  void initState() {
    super.initState();

    const int turnsPerPlayer = 2;
    final int totalTurns =
        2 * (widget.arguments.players.length * turnsPerPlayer);

    matchController = MatchController(
        players: widget.arguments.players, bill: widget.arguments.bill);

    for (int i = 0; i < totalTurns; i++) {
      playesTurns.add(i % widget.arguments.players.length);
    }

    resetTimer();
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  // Timer stuff
  void resetTimer() {
    timer?.cancel();
    setState(
      () => duration = const Duration(seconds: 30),
    );
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => addTime(),
    );
  }

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        timer?.cancel();

        onTimeout();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void onTimeout() {
    if (Random().nextBool()) {
      controller.triggerLeft();
    } else {
      controller.triggerRight();
    }
  }

  Widget buildTimer(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(
      duration.inMinutes.remainder(60),
    );
    final seconds = twoDigits(
      duration.inSeconds.remainder(60),
    );

    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: 24, color: primaryColor),
    );
  }

  void handleSwipe() {
    isWaitingPlayer = !isWaitingPlayer;

    resetTimer();

    if (!isWaitingPlayer) {
      startTimer();
      matchController.nextPlayer();
    } else {
      matchController.createNextChoice();
    }
  }

  void handleAccept() {
    if (!isWaitingPlayer) {
      matchController.accept();
    }

    handleSwipe();
  }

  void handleReject() {
    if (!isWaitingPlayer) {
      matchController.reject();
    }

    handleSwipe();
  }

  void onFinishCards(context) async {
    // Salvar resultados
    Match match = Match.fromMatchController(matchController);

    DatabaseHandler handler = DatabaseHandler();
    MatchDAO matchDAO = MatchDAO(databaseHandler: handler);

    int matchId = await matchDAO.save(match);

    Navigator.pushReplacementNamed(context, "/results",
        arguments: ResultsScreenArgs(matchId: matchId));
  }

  void onRechoice() {
    var player = matchController.getCurrentPlayer();

    if (player.hasRechoicesAvailable()) {
      matchController.rechoice();
      player.doRechoice();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    int dataLength = playesTurns.length;
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
                    totalNum: dataLength,
                    stackNum: 3,
                    swipeEdge: 4.0,
                    minWidth: (screenSize.width - 32) * 0.9,
                    maxWidth: screenSize.width - 32,
                    minHeight: cardHeight * 0.9,
                    maxHeight: cardHeight,
                    cardBuilder: (context, index) => index % 2 == 0
                        ? PlayerTurnCard(
                            text:
                                "${matchController.getCurrentPlayer().name},\né a sua vez",
                            caption: "Arraste para qualquer lado")
                        : ChoiceCard(
                            choice: matchController.getCurrentChoice(),
                          ),
                    cardController: controller,
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      if (orientation == CardSwipeOrientation.LEFT) {
                        handleReject();
                      } else if (orientation == CardSwipeOrientation.RIGHT) {
                        handleAccept();
                      }

                      if (index == dataLength - 1) {
                        onFinishCards(context);
                      }
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: isWaitingPlayer
                    ? <Widget>[
                        FAB(
                          size: 64,
                          onPressed: controller.triggerRight,
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
                          onPressed: controller.triggerLeft,
                          child: const Image(
                            image: AssetImage("assets/icons/close.png"),
                            width: 28,
                            height: 28,
                          ),
                        ),
                        Badge(
                          text: matchController
                              .getCurrentPlayer()
                              .rechoicesAvailable
                              .toString(),
                          child: FAB(
                            size: 64,
                            disabled: !matchController
                                .getCurrentPlayer()
                                .hasRechoicesAvailable(),
                            onPressed: onRechoice,
                            child: const Image(
                              image: AssetImage("assets/icons/redo.png"),
                              width: 28,
                              height: 28,
                            ),
                          ),
                        ),
                        FAB(
                          size: 64,
                          onPressed: controller.triggerRight,
                          child: const Image(
                            image: AssetImage("assets/icons/check.png"),
                            width: 28,
                            height: 28,
                          ),
                        )
                      ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
