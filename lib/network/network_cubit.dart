import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../model/photos.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkInitial());
  Dio dio = Dio();

  void yukla() async {
    emit(NetworkLoading());
    try {
      var response =
          await dio.get("https://jsonplaceholder.typicode.com/photos");
      if (response.statusCode == 200) {
        emit(NetworkSuccess(listFromJson(response.data)));
      } else {
        emit(NetworkError("Server error"));
      }
    } catch (e) {
      emit(NetworkError(e.toString()));
    }
  }
}
