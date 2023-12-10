import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/storage/database_helper.dart';
import '../../home/model/home_model.dart';

part 'cart_cubit.dart';


abstract class CartState extends Equatable {}

class InitialState extends CartState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class LoadedState extends CartState {
  LoadedState(this.homeList);

  final List<HomeModel> homeList;

  @override
  List<Object> get props => [homeList];
}

class ErrorState extends CartState {
  @override
  List<Object> get props => [];
}
