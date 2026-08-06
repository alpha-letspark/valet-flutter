import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/Widgets/AppBarWidget/Presenter/AppBarWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/AppBarWidget/View/AppBarWidgetView.dart';

class AppBarWidget extends StatefulWidget {
  Function onNewEntryClick;
  Function onRefreshClick;
  Function onMenuClick;
  AppBarWidget(this.onNewEntryClick, this.onRefreshClick, this.onMenuClick,
      {Key? key})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    implements AppBarWidgetView {
  bool isNewEntryClicked = false;
  bool isSyncClicked = false;
  bool isMenuClicked = false;
  late AppBarWidgetPresenterImpl _presenter;
  LoginResponse? response;
  bool isNewEntry = false;

  _AppBarWidgetState() {
    _presenter = AppBarWidgetPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => onDataSet());
  }

//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       Expanded(
//         flex: 2,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SizedBox(
//                 height: 50,
//                 width: 70,
//                 child: Image.network(
//                   (response?.data?.client_logo ?? ""),
//                   errorBuilder: (BuildContext context, Object exception,
//                       StackTrace? stackTrace) {
//                     return const SizedBox();
//                   },
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Text(
//                   (response?.data?.client_name ?? ""),
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w700, fontSize: 16),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   (response?.data?.username ?? ""),
//                   style: TextStyle(color: Colors.black87),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       Expanded(
//         flex: 1,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Visibility(
//                   visible: isNewEntry,
//                   child: FloatingActionButton(
//                     backgroundColor: isNewEntryClicked
//                         ? const Color(0xffDE6000)
//                         : Theme.of(context).primaryColor,
//                     mini: true,
//                     elevation: 0.5,
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                     onPressed: () {
//   print("PLUS BUTTON CLICKED");
//   isNewEntryClicked = true;
//   widget.onNewEntryClick();
// }
//                     // onPressed: () {
//                     //   isNewEntryClicked = true;
//                     //   widget.onNewEntryClick();
//                     // },
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 // InkWell(
//                 //     onTap: () {
//                 //       isSyncClicked = true;
//                 //       widget.onRefreshClick();
//                 //     },
//                 //     child: Image.asset(
//                 //       "images/ActiveRefresh.png",
//                 //       height: 30,
//                 //     )),
//                 // const SizedBox(
//                 //   width: 15,
//                 // ),
//                 InkWell(
//                     onTap: () {
//                       isMenuClicked = true;
//                       widget.onMenuClick();
//                     },
//                     child: Icon(
//                       Icons.more_vert,
//                       size: 30,
//                       color: isMenuClicked ? Colors.black : Colors.black45,
//                     )),
//               ],
//             ),
//           ],
//         ),
//       )
//     ]);
//   }

@override
Widget build(BuildContext context) {
  return Container(
    height: 75,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 5,
          offset: const Offset(0, 2),
        )
      ],
    ),

    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),

      child: Row(
        children: [

          Expanded(
            flex: 3,

            child: Row(
              children: [

                Container(
                  height: 50,
                  width: 70,

                  padding: const EdgeInsets.all(5),

                  child: Image.network(
                    response?.data?.client_logo ?? "",

                    fit: BoxFit.contain,

                    errorBuilder:
                        (context, error, stackTrace) {

                      return const Icon(
                        Icons.business,
                        size: 35,
                        color: Colors.grey,
                      );

                    },
                  ),
                ),


                const SizedBox(width: 10),


                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      response?.data?.client_name ?? "",
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),


                    const SizedBox(height: 4),


                    Text(
                      response?.data?.username ?? "",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),

                  ],
                )

              ],
            ),
          ),



          Row(

            children: [

              Visibility(

                visible: isNewEntry,

                child: InkWell(

                  onTap: () {

                    setState(() {
                      isNewEntryClicked = true;
                    });

                    widget.onNewEntryClick();

                  },


                  child: Container(

                    height: 40,
                    width: 40,


                    decoration: BoxDecoration(

                      shape: BoxShape.circle,

                      color: isNewEntryClicked
                          ? const Color(0xffDE6000)
                          : Theme.of(context)
                              .primaryColor,

                    ),


                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28,
                    ),

                  ),

                ),

              ),



              if(isNewEntry)
                const SizedBox(width: 15),



              InkWell(

                onTap: () {

                  setState(() {
                    isMenuClicked = true;
                  });

                  widget.onMenuClick();

                },


                child: Container(

                  height: 40,
                  width: 40,


                  decoration: BoxDecoration(

                    color: Colors.grey.shade100,

                    shape: BoxShape.circle,

                  ),


                  child: Icon(

                    Icons.more_vert,

                    size: 28,

                    color: isMenuClicked
                        ? Colors.black
                        : Colors.black54,

                  ),

                ),

              ),


            ],

          )

        ],
      ),

    ),

  );
}


  void onDataSet() {
    _presenter.initData();
  }

  @override
  void setDataAndPermission(LoginResponse? loginResponse, bool isNewEntry) {
    // TODO: implement setDataAndPermission
    response = loginResponse;
    this.isNewEntry = isNewEntry;
    if (mounted) setState(() {});
  }
}
