import 'package:call_log/call_log.dart';
import 'package:contactsapp/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactsapp/UI/callLogs.dart';

class RecentsScreen extends StatefulWidget {
  @override
  _RecentsScreenState createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen>
    with WidgetsBindingObserver {
  CallLogs cl = new CallLogs();

  AppLifecycleState? _notification;
  Future<Iterable<CallLogEntry>>? logs;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addObserver(this);
    super.initState();

    logs = cl.getCallLogs();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.resumed == state) {
      setState(() {
        logs = cl.getCallLogs();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Text(
              "Recents",
              style: introScreen,
            ),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              height: 40.0,
              width: 400.0,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffededed)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(CupertinoIcons.search),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 25.0, right: 260.0),
                child: Text(
                  "Recents",
                  style: sideHeaders,
                  textAlign: TextAlign.start,
                )),
            FutureBuilder(
                future: logs,
                builder:
                    (context, AsyncSnapshot<Iterable<CallLogEntry>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Iterable<CallLogEntry> entries = snapshot.data!;

                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade200))),
                              padding: EdgeInsets.all(5.0),
                              child: ListTile(
                                leading: cl.getAvatar(
                                    entries.elementAt(index).callType!),
                                title: cl.getTitle(entries.elementAt(index)),
                                subtitle: Text(cl.formatDate(
                                        new DateTime.fromMillisecondsSinceEpoch(
                                            entries
                                                .elementAt(index)
                                                .timestamp!)) +
                                    "\n" +
                                    cl.getTime(
                                        entries.elementAt(index).duration!)),
                                isThreeLine: true,
                                trailing: IconButton(
                                    icon: Icon(Icons.phone),
                                    color: Colors.green,
                                    onPressed: () {
                                      cl.call(entries.elementAt(index).number!);
                                    }),
                              ),
                            ),
                            // onLongPress: () => pt.update(
                            //     entries.elementAt(index).number.toString()),
                          );
                        },
                        itemCount: entries.length,
                      ),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
