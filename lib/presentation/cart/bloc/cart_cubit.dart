part of 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

  CartCubit() : super(InitialState()) {
    loadNotes();
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
  void loadNotes() async {
    List<HomeModel> notes = await dbHelper.getAllNotes();
  }



  void _updateNote(int index) async {
    // HomeModel updatedNote = HomeModel(
    //   id: _notes[index].id,
    //   date:"" ,link:"" ,protected:false ,slug:"" ,
    // );
    // await dbHelper.update(updatedNote);
    //
    //   _notes[index] = updatedNote;

  }

  void _deleteNote(int index) async {
    // await dbHelper.delete(_notes[index].id!);
    //
    //   _notes.removeAt(index);

  }



}
