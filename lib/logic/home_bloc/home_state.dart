import 'package:equatable/equatable.dart';
import 'package:rajkumarpractice/data/model/home_model.dart';

import '../../data/respository/repo.dart';


abstract class HomeState extends Equatable {}

class InitialState extends HomeState {

  InitialState();
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedState extends HomeState {
  LoadedState(this.homeList);

  final List<HomeModel> homeList;

  @override
  List<Object> get props => [homeList];
}

class ErrorState extends HomeState {
  @override
  List<Object> get props => [];
}
