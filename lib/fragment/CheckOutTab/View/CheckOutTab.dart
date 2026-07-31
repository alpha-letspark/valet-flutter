import 'package:flutter/material.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/fragment/ExitTab/View/ExitTab.dart';
import 'package:valet_app/fragment/GuestRequestTab/View/GuestRequestTab.dart';

import '../../HookNumberExitTab/View/HookNumberExitTab.dart';

class CheckOutTab extends StatefulWidget {
  static const String routeName = "CheckOutTab";
  Function onTranscationSuccessFul;
  String? totalRequestCount;
  String? totalExitCount;
  CheckOutTab(this.onTranscationSuccessFul, {Key? key}) : super(key: key);

  // @override
  // State<CheckOutTab> createState() => _CheckOutTabState();

  var state = _CheckOutTabState();
  @override
  //State<NewVehicleEntry> createState() => _state;
  @override
  _CheckOutTabState createState() {
    return state = new _CheckOutTabState();
  }

  void refresh() => state.refresh();

  void setCount(String totalRequestCount, String totalExitCount) {
    this.totalRequestCount = totalRequestCount;
    this.totalExitCount = totalExitCount;
    state.refresh();
  }
}

class _CheckOutTabState extends State<CheckOutTab>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  TabController? tabController;
  int tabLength = 2;

  bool checkIn = false;
  bool checkOut = true;
  bool isExitByHook = false;

  @override
  void initState() {
    super.initState();
    checkExitByHook();
  }

  void checkExitByHook() async {
    isExitByHook = await Preferences.getIntValue(Preferences.EXIT_BY_HOOK) == 1;
    if (isExitByHook) tabLength = 3;
    tabController = TabController(
      vsync: this,
      length: tabLength,
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        TabBar(
            labelPadding: EdgeInsets.zero,
            controller: tabController,
            indicatorColor: Theme.of(context).primaryColorDark,
            onTap: (index) {
              if (mounted) {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            tabs: [
              Tab(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.GUEST_REQUEST,
                        style: TextStyle(
                            fontSize: 15,
                            color: _currentIndex == 0
                                ? Colors.black
                                : Colors.black26),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: widget.totalRequestCount != null &&
                                widget.totalRequestCount != '' &&
                                widget.totalRequestCount != "0"
                            ? BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(2),
                              )
                            : const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.totalRequestCount != null &&
                                    widget.totalRequestCount != '' &&
                                    widget.totalRequestCount != "0"
                                ? widget.totalRequestCount ?? ""
                                : "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Tab(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.EXIT,
                        style: TextStyle(
                            fontSize: 15,
                            color: _currentIndex == 1
                                ? Colors.black
                                : Colors.black26),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: widget.totalExitCount != null &&
                                widget.totalExitCount != '' &&
                                widget.totalExitCount != "0"
                            ? BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(2),
                              )
                            : const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.totalExitCount != null &&
                                    widget.totalExitCount != '' &&
                                    widget.totalExitCount != "0"
                                ? widget.totalExitCount ?? ""
                                : "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (isExitByHook)
                Tab(
                  child: Center(
                    child: Text(
                      Strings.HN_EXIT,
                      style: TextStyle(
                          fontSize: 15,
                          color: _currentIndex == 2
                              ? Colors.black
                              : Colors.black26),
                    ),
                  ),
                ),
            ]),
        Expanded(
          child: TabBarView(
              controller: tabController,
              // physics: AlwaysScrollableScrollPhysics(),
              children: [
                GuestRequestTab(onTranscationUpdated),
                ExitTab(onTranscationUpdated),
                if (isExitByHook) HookNumberExitTab(onTranscationUpdated),
              ]),
        )
      ],
    );
  }

  void onTranscationUpdated() {
    widget.onTranscationSuccessFul();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
