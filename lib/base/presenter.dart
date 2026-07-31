abstract class Presenter<V> {
  void attachView(V view);

  void detachView();

  bool isViewAttached();
}
