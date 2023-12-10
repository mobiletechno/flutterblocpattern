part of 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

  CartCubit() : super(InitialState()) {

  }


  final dbHelper = DatabaseHelper.instance;
   List<HomeModel> homeList=[];


  // final Repo repository;

  Future<void> getListFromDB(int pagination) async {
    try {
      emit(LoadingState());

    _loadDataBaseList().then((List<HomeModel> HomeModellist){
      homeList=HomeModellist;
      });

      emit(LoadedState(await homeList as List<HomeModel>));
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future<List<HomeModel>> _loadDataBaseList() async {
    List<HomeModel> notes = await dbHelper.getAllNotes();
    return notes;
  }



}
