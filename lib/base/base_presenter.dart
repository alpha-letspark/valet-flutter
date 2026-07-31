import 'package:valet_app/API/ApiClientImpl.dart';
import 'package:valet_app/Database/DatabaseHelper.dart';

import 'presenter.dart';

class BasePresenter<V> implements Presenter {
  V? view;
  late ApiClientImpl apiClientImpl;
  late DatabaseHelper db;

  BasePresenter() {
    apiClientImpl = ApiClientImpl();
    db = DatabaseHelper.get;
    db.db();
  }

  void detachView() {
    this.view = null;
  }

  void checkViewAttached() {
    if (view == null) {
      throw new Exception("attached view is null!");
    }
  }

  V? getView() {
    return view;
  }

  @override
  void attachView(view) {
    this.view = view;
  }

  @override
  bool isViewAttached() {
    // TODO: implement isViewAttached
    return view != null;
  }
}
