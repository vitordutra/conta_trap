import 'package:conta_trap/src/classes/match.dart';
import 'package:conta_trap/src/screens/results_screen.dart';
import 'package:conta_trap/src/services/database_handler.dart';
import 'package:conta_trap/src/services/match_dao.dart';
import 'package:conta_trap/src/utils/strings.dart';
import 'package:conta_trap/src/widgets/curved_header.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late MatchDAO matchDAO;

  @override
  void initState() {
    super.initState();

    DatabaseHandler handler = DatabaseHandler();
    matchDAO = MatchDAO(databaseHandler: handler);
  }

  Widget getListTile(Match match) {
    var date = match.createdAt;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: -8),
      title: Text(
          "${padLeft(date.day)}/${padLeft(date.month)}/${padLeft(date.year, 4)} às ${padLeft(date.hour)}:${padLeft(date.minute)}"),
      subtitle: Text(
        "Rachado entre ${match.playersLength} pessoas",
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Text(
        maskCurrencyBRL(match.bill),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        "/results",
        arguments: ResultsScreenArgs(matchId: match.id),
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
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              CurvedHeader(
                height: headerHeight,
                title: const Text(
                  "Histórico",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: EdgeInsets.only(top: headerHeight - 66),
                child:
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: <Widget>[
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      elevation: 4,
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      child: FutureBuilder(
                        future: matchDAO.list(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Match>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return getListTile(snapshot.data![index]);
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
