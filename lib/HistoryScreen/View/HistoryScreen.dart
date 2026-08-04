import 'package:flutter/material.dart';
import 'package:valet_app/ConnectivityStatusSingleton.dart';
import 'package:valet_app/Data/Response/HistoryCountData.dart';
import 'package:valet_app/HistoryScreen/Presenter/HistoryScreenPresenterImpl.dart';
import 'package:valet_app/HistoryScreen/View/HistoryScreenView.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/AppBarWidget/View/AppBarWidget.dart';
import 'package:valet_app/fragment/TodayTab/View/TodayTab.dart';

import 'package:valet_app/fragment/YesterdayTab/View/YesterdayTab.dart';

import '../../Util/Utils.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = "HistoryScreen";

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin
    implements HistoryScreenView {
  int _currentIndex = 0;
  late TabController tabController;
  bool isLoading = false;
  late ConnectionStatusSingleton connectionStatus;
  late HistoryScreenPresenterImpl _presenter;
  bool isCountLoaded = false;
  String? todayCount;
  String? yesterdayCount;
  _HistoryScreenState() {
    _presenter = HistoryScreenPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    print('This is history screeen');
    tabController = TabController(vsync: this, length: 2);
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _presenter.initData());

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  bool onMenuClick = false;
  bool onNewEntryClick = false;
  bool onHistoryClick = true;
  bool isCheckInClick = false;
  bool isCheckOutClick = false;
  bool onCheckInOutClick = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          AppBarWidget(
            onNewEntryClicked,
            onRefreshClicked,
            onMenuClicked,
          ),
          Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black26),
          ),
        ),
        child: const ListTile(
          title: Text(
            Strings.HISTORY,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),

    if (isCountLoaded)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DefaultTabController(
          length: 2,
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.black45,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.TODAY,
                      style: TextStyle(
                        color: _currentIndex == 0
                            ? Colors.black
                            : Colors.black38,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (todayCount != null && todayCount != "0")
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A8A8A),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          todayCount!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.YESTERDAY,
                      style: TextStyle(
                        color: _currentIndex == 1
                            ? Colors.black
                            : Colors.black38,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (yesterdayCount != null && yesterdayCount != "0")
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A8A8A),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          yesterdayCount!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
  ],
),
          // !isCountLoaded
          //     ? const SizedBox()
          //     : Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //               horizontal: 10,
          //             ),
          //             child: Container(
          //                 decoration: const BoxDecoration(
          //                   border: Border(
          //                     bottom:
          //                         BorderSide(width: 1.0, color: Color.fromARGB(66, 150, 109, 109)),
          //                   ),
          //                 ),
          //                 child: const ListTile(
          //                   title: Text(
          //                     Strings.HISTORY,
          //                     style: TextStyle(
          //                         color: Colors.red,
          //                         fontWeight: FontWeight.w600,
          //                         fontSize: 18),
          //                   ),
          //                 )),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //               horizontal: 10,
          //             ),
          //             child: DefaultTabController(
          //                 length: 2,
          //                 child: TabBar(
          //                     controller: tabController,
          //                     indicatorColor: Colors.black45,
          //                     onTap: (index) {
          //                       if (mounted) {
          //                         setState(() {
          //                           _currentIndex = index;
          //                         });
          //                       }
          //                     },
          //                     tabs: [
          //                       Tab(
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               Strings.TODAY,
          //                               style: TextStyle(
          //                                   color: _currentIndex == 0
          //                                       ? Colors.black
          //                                       : Colors.black38,
          //                                   fontSize: 18),
          //                             ),
          //                             const SizedBox(
          //                               width: 10,
          //                             ),
          //                             Container(
          //                               decoration: (todayCount == null ||
          //                                       todayCount == "0")
          //                                   ? const BoxDecoration()
          //                                   : BoxDecoration(
          //                                       color: Color(0xFF8A8A8A),
          //                                       borderRadius:
          //                                           BorderRadius.circular(2),
          //                                     ),
          //                               child: Padding(
          //                                 padding: const EdgeInsets.all(2.0),
          //                                 child: Text(
          //                                   todayCount.toString(),
          //                                   style: const TextStyle(
          //                                       fontWeight: FontWeight.w600,
          //                                       color: Colors.white),
          //                                 ),
          //                               ),
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                       Tab(
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               Strings.YESTERDAY,
          //                               style: TextStyle(
          //                                   color: _currentIndex == 1
          //                                       ? Colors.black
          //                                       : Colors.black38,
          //                                   fontSize: 18),
          //                             ),
          //                             const SizedBox(
          //                               width: 10,
          //                             ),
          //                             Container(
          //                               decoration: (yesterdayCount == null ||
          //                                       yesterdayCount == "0")
          //                                   ? const BoxDecoration()
          //                                   : BoxDecoration(
          //                                       color: Color(0xFF8A8A8A),
          //                                       borderRadius:
          //                                           BorderRadius.circular(2),
          //                                     ),
          //                               child: Padding(
          //                                 padding: const EdgeInsets.all(2.0),
          //                                 child: Text(
          //                                   yesterdayCount.toString(),
          //                                   style: const TextStyle(
          //                                       fontWeight: FontWeight.w600,
          //                                       color: Colors.white),
          //                                 ),
          //                               ),
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                     ])),
          //           ),
          //         ],
          //       ),
          Visibility(
            visible: onHistoryClick,
            child: Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TabBarView(
                    controller: tabController,
                    children: [TodayTab(), YesterdayTab()]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void onMenuClicked() {
    Navigator.of(context).pop();
  }

  void onNewEntryClicked() {
    Navigator.of(context).pop(true);
  }

  void onRefreshClicked() {}

  @override
  void setHistoryCount(HistoryCountData? countData) {
    // TODO: implement setHistoryCount
    todayCount = countData?.today ?? "0";
    yesterdayCount = countData?.yesterday ?? "0";
    isCountLoaded = true;
    if (mounted) setState(() {});
  }

  @override
  Future<bool> isOnline() async {
    return await connectionStatus.checkConnection();
  }

  @override
  void showOfflineMessage() {
    showErrorMsg(Strings.OFFLINE_MESSAGE);
    if (isLoading) {
      hideProgress();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void showProgress() {
    // TODO: implement showProgress

    if (!isLoading) {
      isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
              height: 30,
              width: 30,
              child: Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor)));
        },
      );
    }
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
    if (isLoading) {
      isLoading = false;
      Navigator.pop(context);
    }
  }

  @override
  void showErrorMsg(String? msg) {
    Utils.showToastMsg(msg!,
        textColor: Colors.black, backgroundColor: Colors.white);
  }
}
