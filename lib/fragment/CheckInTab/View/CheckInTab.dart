import 'package:flutter/material.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/ParkedInfoWidget/View/ParkedInfoWidget.dart';
import 'package:valet_app/fragment/CheckInTab/Presenter/CheckInTabPresenterImpl.dart';
import 'package:valet_app/fragment/CheckInTab/View/CheckInTabView.dart';
import 'package:valet_app/fragment/UnParkedTab/View/UnparkedTab.dart';

class CheckInTab extends StatefulWidget {
  static const String routeName = "CheckInTab";
  Function onTranscationSuccessful;

  CheckInTab(this.onTranscationSuccessful, {Key? key}) : super(key: key);

  // @override
  // State<CheckInTab> createState() => _CheckInTabState();

  var state = _CheckInTabState();

  @override
  _CheckInTabState createState() {
    return state = new _CheckInTabState();
  }

  void refresh() => state.refresh();
}

class _CheckInTabState extends State<CheckInTab>
    with TickerProviderStateMixin
    implements CheckInTabView {
  int _currentIndex = 0;
  TabController? tabController;

  bool checkIn = true;
  bool checkOut = false;

  bool isParked = false;
  bool isUnParked = false;
  bool isDataSet = false;

  UnParkedTab? _unParkedTab;
  ParkingInfoWidget? _parkingInfoWidget;
  late CheckInTabPresenterImpl _presenter;

  _CheckInTabState() {
    _presenter = CheckInTabPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _presenter.initData());
  }

  @override
  Widget build(BuildContext context) {
    _unParkedTab ??= UnParkedTab(onTranscationUpdated);
    _parkingInfoWidget ??= ParkingInfoWidget(onTranscationUpdated);
    return !isDataSet
        ? const SizedBox()
        : Column(
            children: [
              TabBar(
                  labelPadding: EdgeInsets.zero,
                  controller: tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  onTap: (index) {
                    if (mounted) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }
                  },
                  tabs: [
                    if (isUnParked)
                      Tab(
                        child: Center(
                          child: Text(
                            Strings.UNPARKED,
                            style: TextStyle(
                                fontSize: 16,
                                color: _currentIndex == 0
                                    ? Colors.black
                                    : Colors.black26),
                          ),
                        ),
                      ),
                    if (isParked)
                      Tab(
                        child: Center(
                          child: Text(
                            Strings.PARKED,
                            style: TextStyle(
                                fontSize: 16,
                                color: _currentIndex == 1
                                    ? Colors.black
                                    : _currentIndex ==
                                            (tabController?.length ?? 0) - 1
                                        ? Colors.black
                                        : Colors.black26),
                          ),
                        ),
                      ),
                  ]),
              Expanded(
                child: TabBarView(controller: tabController,
                    // physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      if (isUnParked) _unParkedTab!,
                      if (isParked) _parkingInfoWidget!
                    ]),
              )
            ],
          );
  }

  void onTranscationUpdated() {
    widget.onTranscationSuccessful();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void refresh() {
    if (_currentIndex == 0) {
      _unParkedTab?.refresh();
    } else {
      _parkingInfoWidget?.refresh();
    }
  }

  @override
  void setPermission(bool isParked, bool isUnParked) {
    this.isParked = isParked;
    this.isUnParked = isUnParked;
    isDataSet = true;

    tabController = TabController(
      vsync: this,
      length: (isParked && isUnParked) ? 2 : 1,
    );
    setState(() {});
  }
}
