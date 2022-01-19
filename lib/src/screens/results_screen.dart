import 'package:conta_trap/src/classes/match.dart';
import 'package:conta_trap/src/screens/gameplay_screen.dart';
import 'package:conta_trap/src/services/database_handler.dart';
import 'package:conta_trap/src/services/match_dao.dart';
import 'package:conta_trap/src/utils/strings.dart';
import 'package:conta_trap/src/widgets/curved_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ResultsScreenArgs {
  final int matchId;

  const ResultsScreenArgs({required this.matchId});
}

class ResultsScreen extends StatefulWidget {
  final ResultsScreenArgs arguments;

  const ResultsScreen({required this.arguments, Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late MatchDAO matchDAO;

  @override
  void initState() {
    super.initState();

    DatabaseHandler handler = DatabaseHandler();
    matchDAO = MatchDAO(databaseHandler: handler);
  }

  void handleRedoMatch(Match match) {
    Navigator.pushReplacementNamed(
      context,
      '/gameplay',
      arguments: GameplayScreenArgs(
        bill: match.bill,
        players: match.players.map((p) => p.name).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    AppBar appBar = AppBar(
      elevation: 0,
    );

    double headerHeight = 0.26 * screenHeight - appBar.preferredSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: FutureBuilder(
        future: matchDAO.get(widget.arguments.matchId),
        builder: (BuildContext context, AsyncSnapshot<Match> snapshot) {
          if (snapshot.hasData) {
            Match match = snapshot.data as Match;
            var date = match.createdAt;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Stack(
                    children: <Widget>[
                      CurvedHeader(
                        height: headerHeight,
                        title: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Resultados",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "${padLeft(date.day)}/${padLeft(date.month)}/${padLeft(date.year, 4)} às ${padLeft(date.hour)}:${padLeft(date.minute)}",
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Positioned(
                        top: headerHeight - 50,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                elevation: 4,
                                margin: EdgeInsets.zero,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: match.players
                                        .map(
                                          (p) => ListTile(
                                            title: Text(p.name),
                                            trailing: Text(
                                              maskCurrencyBRL(p.bill),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black26,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: OutlinedButton(
                    onPressed: () => handleRedoMatch(match),
                    child: const Text("JOGAR NOVAMENTE"),
                  ),
                ),
              ],
            );

            // Stack(
            //   children: <Widget>[
            //     Column(
            //       children: [
            //         CurvedHeader(
            //           height: headerHeight,
            //           title: Container(
            //             margin: const EdgeInsets.only(bottom: 8),
            //             child: const Text(
            //               "Resultados",
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 24,
            //               ),
            //             ),
            //           ),
            //           subtitle: Text(
            //             "${padLeft(date.day)}/${padLeft(date.month)}/${padLeft(date.year, 4)} às ${padLeft(date.hour)}:${padLeft(date.minute)}",
            //             style: const TextStyle(
            //               color: Colors.white54,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Positioned(
            //       top: 0,
            //       left: 0,
            //       right: 0,
            //       bottom: 0,
            //       child: Expanded(
            //         child: Container(
            //           margin: const EdgeInsets.all(16),
            //           padding: EdgeInsets.only(top: headerHeight - 66),
            //           child: Card(
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(16)),
            //             ),
            //             elevation: 4,
            //             margin: EdgeInsets.zero,
            //             clipBehavior: Clip.antiAlias,
            //             child: ListView.builder(
            //               itemCount: match.players.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return ListTile(
            //                   title: Text(match.players[index].name),
            //                   trailing: Text(
            //                     maskCurrencyBRL(match.players[index].bill),
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     OutlinedButton(
            //       onPressed: () => handleRedoMatch(match),
            //       child: const Text("JOGAR NOVAMENTE"),
            //     ),
            //   ],
            // );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
