part of 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

  CartCubit() : super(InitialState()) {
    getListFromDB();
  }


  final dbHelper = DatabaseHelper.instance;
   List<HomeModel> homeList=[];


  // final Repo repository;

  Future<void> getListFromDB() async {
    try {
      emit(LoadingState());

      homeList=await loadDataBaseList();

      emit(LoadedState( homeList as List<HomeModel>));
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future<List<HomeModel>> loadDataBaseList() async {
    List<HomeModel> notes = await dbHelper.getAllNotes();
    return notes;
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
