import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/respository/repo.dart';
import '../../../data/respository/repo_impl.dart';
import '../model/home_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  ScrollController scrollListenercontroller = ScrollController();
  HomeCubit() : super(InitialState()) {
    scrollListenercontroller.addListener(_scrollListener);

    getTrendingMovies(_paginationIndex);
  }
  Future<void> _scrollListener() async {
    if (scrollListenercontroller.hasClients) {
      if (scrollListenercontroller.position.pixels ==
          scrollListenercontroller.position.maxScrollExtent) {
        _paginationIndex += 10;
        final homeList = await repository.getList(_paginationIndex);
        // if (homeList.toString() != "[]") {
          final resultPort = ReceivePort();
          await Isolate.spawn(
            _IsolateparseJson,
            [resultPort.sendPort, homeList],
          );

          emit(LoadedState(await resultPort.first as List<HomeModel>));
        // }
      }
    }
  }

  late Repo repository;
  int _paginationIndex = 10;

  // final Repo repository;

  Future<void> getTrendingMovies(int pagination) async {
    try {
      emit(LoadingState());
      repository = RepoImpl();
      final homeList = await repository.getList(pagination);
      final resultPort = ReceivePort();
      await Isolate.spawn(
        _IsolateparseJson,
        [resultPort.sendPort, homeList],
      );

      emit(LoadedState(await resultPort.first as List<HomeModel>));
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future<void> handleRefresh() async {
    _paginationIndex += 10;
    getTrendingMovies(_paginationIndex);
  }
}

Future<List<HomeModel>> _IsolateparseJson(List<dynamic> args) async {
  SendPort resultPort = args[0];
  final List<dynamic> rawData = args[1];
  final parsed = rawData.map((e) => HomeModel.fromJson(e)).toList();
  Isolate.exit(resultPort, parsed);
}
