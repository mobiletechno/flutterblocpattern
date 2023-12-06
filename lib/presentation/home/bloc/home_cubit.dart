import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/respository/repo.dart';
import '../../../data/respository/repo_impl.dart';
import '../model/home_model.dart';
import 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialState()) {
    getTrendingMovies();
  }
   late Repo repository;
  // final Repo repository;

  void getTrendingMovies() async {
    try {
      emit(LoadingState());
      repository=RepoImpl();
      final homeList = await repository.getList(1);
      final resultPort = ReceivePort();
      // spawn a new isolate and pass down a function that will be used in a new isolate
      // and pass down the result port that will send back the result.
      // you can send any number of arguments.
      await Isolate.spawn(
        _IsolateparseJson,
        [resultPort.sendPort, homeList],
      );
      emit(LoadedState(await resultPort.first as List<HomeModel>));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
Future<List<HomeModel>> _IsolateparseJson(List<dynamic> args) async {
SendPort resultPort = args[0];
  final List<dynamic> rawData = args[1];
  final parsed =
  rawData.map((e) => HomeModel.fromJson(e)).toList();
  Isolate.exit(resultPort, parsed);
}