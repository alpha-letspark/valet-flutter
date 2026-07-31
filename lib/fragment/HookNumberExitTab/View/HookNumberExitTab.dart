import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/ExitByHNData.dart';
import 'package:valet_app/Dialog/ETA_Dialog/View/ETA_Dialog.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/ExitByHNWidget/view/ExitByHNWidget.dart';
import 'package:valet_app/fragment/HookNumberExitTab/Presenter/HookNumberExitTabPresenterImpl.dart';
import 'package:valet_app/fragment/HookNumberExitTab/View/HookNumberExitTabView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Util/Utils.dart';

class HookNumberExitTab extends StatefulWidget {
  Function onTranscationUpdated;
  HookNumberExitTab(this.onTranscationUpdated, {Key? key}) : super(key: key);

  @override
  State<HookNumberExitTab> createState() => _HookNumberExitTabState();
}

class _HookNumberExitTabState extends State<HookNumberExitTab>
    implements HookNumberExitTabView {
  bool isOffline = false;
  bool isLoading = false;
  bool isDriver = false;
  List<ExitByHNData> exitByHNList = [];
  TextEditingController searchController = TextEditingController();

  late HookNumberExitTabPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  _HookNumberExitTabState() {
    _presenter = HookNumberExitTabPresenterImpl();
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 25),
                      controller: searchController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        onSearchTextChanged(value);
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColorDark,
                            size: 25,
                          ),
                          contentPadding: EdgeInsets.zero,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          hintText: Strings.HOOK_NUMBER,
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: exitByHNList.length,
                  itemBuilder: (context, index) => ExitByHNWidget(
                      exitByHNList[index], onDataUpdated, isDriver)),
            ),
          ],
        ),
      ),
    );
  }

  void onDataUpdated() {
    searchController.text = "";
    _presenter.onSearchTextChanged("");
    widget.onTranscationUpdated();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  void onSearchTextChanged(String value) {
    _presenter.onSearchTextChanged(value);
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
  void setResponse(List<ExitByHNData> exitByHNList) {
    // TODO: implement setResponse
    this.exitByHNList = exitByHNList;
    if (mounted) setState(() {});
  }

  @override
  void showDriver(bool isDriver) {
    // TODO: implement showDriver
    this.isDriver = isDriver;
  }
}

// Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//                   child: Container(
//                     color: Colors.grey[200],
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 10),
//                           child: Row(
//                             children: [
//                               const Expanded(
//                                 child: Text(
//                                   Strings.ETA,
//                                   style: TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       _history[index].timeIn!,
//                                       style: const TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.black87,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     checkETAStatus(
//                                       _history[index].eTA!,
//                                     ),
//                                     // Container(
//                                     //   decoration: BoxDecoration(
//                                     //       color: Colors.grey[400],
//                                     //       border: Border.all(
//                                     //           color: Colors.black54)),
//                                     //   child: Padding(
//                                     //     padding: const EdgeInsets.all(3.0),
//                                     //     child: Text(
//                                     //       _history[index].eTA!,
//                                     //       style: TextStyle(
//                                     //           fontWeight: FontWeight.w700,
//                                     //           color: Theme.of(context)
//                                     //               .primaryColorDark),
//                                     //     ),
//                                     //   ),
//                                     // )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ExpansionTile(
//                           trailing: _customTileExpanded
//                               ? Icon(
//                                   Icons.keyboard_arrow_down_rounded,
//                                   color: Theme.of(context).primaryColorDark,
//                                   size: 30,
//                                 )
//                               : const Icon(
//                                   Icons.keyboard_arrow_right_rounded,
//                                   size: 30,
//                                 ),
//                           tilePadding:
//                               const EdgeInsets.symmetric(horizontal: 5),
//                           title: Row(
//                             children: [
//                               const Expanded(
//                                 child: Text(
//                                   Strings.VEHICLE_NUMBER,
//                                   style: TextStyle(
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                     Expanded(
//                                       flex: 3,
//                                       child: TextField(
//                                         readOnly: true,
//                                         showCursor: false,
//                                         decoration: InputDecoration(
//                                             hintText:
//                                                 _history[index].vehicleNumber!,
//                                             hintStyle: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Colors.black87),
//                                             border: InputBorder.none),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Expanded(
//                                       child: TextField(
//                                         readOnly: true,
//                                         onTap: () {
//                                           showDialog(
//                                               context: context,
//                                               builder: (context) =>
//                                                   VehicleTypeDialog([]));
//                                         },
//                                         showCursor: false,
//                                         decoration: InputDecoration(
//                                             hintText:
//                                                 _history[index].vehicleName!,
//                                             hintStyle: const TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Colors.black87),
//                                             border: InputBorder.none),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           children: [
//                             const Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Row(
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       Strings.DATE_TIME,
//                                       style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Row(
//                                       //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Text(
//                                           _history[index].dateIn!,
//                                           style: const TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.black87,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                         const SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text(
//                                           _history[index].timeIn!,
//                                           style: const TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.black87,
//                                               fontWeight: FontWeight.w700),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Row(
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       Strings.GUEST_NAME,
//                                       style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       _history[index].guestName!,
//                                       style: const TextStyle(
//                                           color: Colors.black87,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Row(
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       Strings.GUEST_NUMBER + "*",
//                                       style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       _history[index].guestNumber!,
//                                       style: const TextStyle(
//                                           color: Colors.black87,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Row(
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       Strings.ANYTHING_VALUABLE,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       _history[index].valuableThing!,
//                                       style: const TextStyle(
//                                           color: Colors.black87,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Row(
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       Strings.ADD_PHOTOS,
//                                       style: TextStyle(
//                                           color: Colors.black54,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 15),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                                     Radius.circular(3)),
//                                             border: Border.all(
//                                                 color: Colors.black54),
//                                           ),
//                                           child: const Icon(
//                                             Icons.directions_car,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                                     Radius.circular(3)),
//                                             border: Border.all(
//                                                 color: Colors.black54),
//                                           ),
//                                           child: const Icon(
//                                             Icons.directions_car,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                                     Radius.circular(3)),
//                                             border: Border.all(
//                                                 color: Colors.black54),
//                                           ),
//                                           child: const Icon(
//                                             Icons.directions_car,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                                     Radius.circular(3)),
//                                             border: Border.all(
//                                                 color: Colors.black54),
//                                           ),
//                                           child: const Icon(
//                                             Icons.directions_car,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                                     Radius.circular(3)),
//                                             border: Border.all(
//                                                 color: Colors.black54),
//                                           ),
//                                           child: const Icon(
//                                             Icons.directions_car,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 5, vertical: 5),
//                               child: Row(
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       Strings.NOTES,
//                                       style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: TextField(
//                                       onTap: () {
//                                         showDialog(
//                                             context: context,
//                                             builder: (context) =>
//                                                 NotesDialog(''));
//                                       },
//                                       readOnly: true,
//                                       showCursor: false,
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                         contentPadding:
//                                             EdgeInsets.symmetric(horizontal: 5),
//                                         hintText: Strings.UNASSIGNED,
//                                         hintStyle:
//                                             const TextStyle(fontSize: 12),
//                                         border: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.black)),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Theme.of(context)
//                                                 .primaryColorDark,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                           onExpansionChanged: (bool expanded) {
//                             if (mounted) setState(() => _customTileExpanded = expanded);
//                           },
//                         ),
//                         // const Divider(
//                         //   thickness: 1,
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 5),
//                           child: Row(
//                             children: [
//                               const Expanded(
//                                 child: Text(
//                                   Strings.VALET_DRIVER,
//                                   style: TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   onTap: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) =>
//                                             SelectDriverDialog([]));
//                                   },
//                                   showCursor: false,
//                                   readOnly: true,
//                                   decoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     contentPadding:
//                                         EdgeInsets.symmetric(horizontal: 5),
//                                     hintText: Strings.UNASSIGNED,
//                                     hintStyle: const TextStyle(fontSize: 12),
//                                     border: const OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.black)),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color:
//                                             Theme.of(context).primaryColorDark,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Divider(
//                           thickness: 1,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Row(
//                             children: [
//                               const Expanded(
//                                 child: Text(
//                                   Strings.LOCATION,
//                                   style: TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   onTap: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) =>
//                                             ParkingLocationDialog([]));
//                                   },
//                                   showCursor: false,
//                                   readOnly: true,
//                                   decoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 5),
//                                     hintText: Strings.UNASSIGNED,
//                                     hintStyle: const TextStyle(fontSize: 12),
//                                     border: const OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.black)),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color:
//                                             Theme.of(context).primaryColorDark,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Divider(
//                           thickness: 1,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Row(
//                             children: [
//                               const Expanded(
//                                 child: Text(
//                                   Strings.HOOK_NUMBER,
//                                   style: TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   showCursor: false,
//                                   readOnly: true,
//                                   decoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 5),
//                                     hintText: Strings.UNASSIGNED,
//                                     hintStyle: const TextStyle(fontSize: 12),
//                                     border: const OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.black)),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color:
//                                             Theme.of(context).primaryColorDark,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: RawMaterialButton(
//                                 shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                   color: Theme.of(context).primaryColorDark,
//                                 )),
//                                 child: Text(
//                                   Strings.SUBMIT,
//                                   style: TextStyle(
//                                       color: Theme.of(context).primaryColorDark,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 onPressed: () {},
//                                 fillColor: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
             
