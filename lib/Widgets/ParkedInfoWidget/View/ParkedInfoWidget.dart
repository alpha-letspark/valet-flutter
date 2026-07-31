import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/ParkedInfoVehicleDetails.dart';
import 'package:valet_app/Data/Response/ParkingDetailsData.dart';
import 'package:valet_app/Data/Response/ParkingLocationData.dart';
import 'package:valet_app/Util/HexColor.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/ParkedInfoWidget/Presenter/ParkedInfoWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/ParkedInfoWidget/View/ParkedInfoWidgetView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Data/Response/ParkedInfoData.dart';
import '../../../Dialog/TapCarDialog/View/TapCarDialog.dart';
import '../../../Util/Utils.dart';

class ParkingInfoWidget extends StatefulWidget {
  Function onTranscationUpdated;
  ParkingInfoWidget(this.onTranscationUpdated, {Key? key}) : super(key: key);

  // @override
  // State<ParkingInfoWidget> createState() => _ParkingInfoWidgetState();
  var state = _ParkingInfoWidgetState();

  @override
  _ParkingInfoWidgetState createState() {
    return state = new _ParkingInfoWidgetState();
  }

  void refresh() => state.refresh();
}

class _ParkingInfoWidgetState extends State<ParkingInfoWidget>
    implements ParkedInfoWidgetView {
  bool isLoading = false;
  bool isOffline = false;

  List<ParkingLocationData> _locations = [];
  List<ParkedInfoData> _carDetails = [];
  List<ParkedInfoDataVehicleDetails> _selectedParkingLocation = [];
  late ConnectionStatusSingleton connectionStatus;
  late ParkedInfoWidgetPresenterImpl _presenter;

  int selectedParkingId = 0;
  String selectedParkingName = '';
  String searchString = '';

  _ParkingInfoWidgetState() {
    _presenter = ParkedInfoWidgetPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _presenter.initData());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              onChanged: (value) {
                searchString = value;
                if (mounted) setState(() {});
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.zero,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: Strings.SEARCH_VEHICLE_HOOK),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _locations.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  selectedParkingId = _locations[index].id ?? 0;
                  selectedParkingName = _locations[index].name ?? '';

                  if (mounted) setState(() {});
                },
                child: Card(
                  color: HexColor(_locations[index].color_code ?? ''),
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                _locations[index].name ?? '',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                _locations[index].capacity ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
        buildGridView(),
      ],
    );
  }

  Widget buildGridView() {
    var _selectedParkingLocation = sortListByName(selectedParkingName);
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.4),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _selectedParkingLocation.length,
          itemBuilder: (context, index) {
            return Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: () {
                            onCarClick(_selectedParkingLocation[index]);
                          },
                          child: Image.asset(
                            "images/Car.png",
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                _selectedParkingLocation[index]
                                        .vehicle_number ??
                                    '',
                                style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "HN: ${_selectedParkingLocation[index].hook_number ?? ''}",
                                style: const TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onCarClick(ParkedInfoDataVehicleDetails details) {
    _presenter.onCarTap(details.transaction_id ?? "");
  }

  @override
  Future<bool> isOnline() async {
    return isOffline = await connectionStatus.checkConnection();
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

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void setParkingLocationResponse(List<ParkingLocationData> locationList,
      List<ParkedInfoData> parkingList) {
    // TODO: implement setParkingLocationResponse

    _locations = locationList;
    _carDetails = parkingList;
    if (_locations.length > 1) {
      selectedParkingId = _locations[0].id ?? 0;
      selectedParkingName = _locations[0].name ?? "";
    }
    if (mounted) setState(() {});
  }

  List<ParkedInfoDataVehicleDetails> sortListByName(String name) {
    if (_carDetails.isNotEmpty) {
      ParkedInfoData? data = _carDetails.firstWhere((element) =>
          (element.name ?? '').toLowerCase() == name.toLowerCase());
      if (data != null) {
        _selectedParkingLocation = data.vehicle_details ?? [];
        if (searchString.isNotEmpty) {
          return _selectedParkingLocation
              .where((element) => element
                  .toSearchString()
                  .toLowerCase()
                  .contains(searchString.toLowerCase()))
              .toList();
        }
        return _selectedParkingLocation;
      }
      _selectedParkingLocation = [];

      return _selectedParkingLocation;
    }
    _selectedParkingLocation = [];
    return _selectedParkingLocation;
  }

  @override
  void onCarDetails(ParkingDetailsData? data) {
    // TODO: implement onCarDetails
    if (data != null) {
      showDialog(context: context, builder: (context) => TapCarDialog(data))
          .then((value) => handleCarDetailsClick(value));
    }
  }

  void handleCarDetailsClick(bool? value) {
    if (value != null && value) {
      _presenter.initData();
    }
  }

  void refresh() {
    _presenter.initData();
  }
}
