
import 'package:kemet/features/home/data/models/add_post_model/AddPostModel.dart';
import 'package:kemet/features/home/data/repos/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/utils/functions/location_fun.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this.homeRepo) : super(AddPostInitial());
  final HomeRepo homeRepo;
  bool isImage = false;
  TextEditingController desController = TextEditingController();

  void changeIsImage(change) {
    isImage = change;
    emit(ChangeIsImage());
  }

  void changeController() async{
    emit(AddLocationLoading());
    if(await requestLocationPermissionAndRetrieveLocation()!="Permission denied by user"){
      desController.text = await requestLocationPermissionAndRetrieveLocation();
      emit(FillControllerSuccess());
    }else{
      emit(FillControllerFailure());
    }


  }

  Future<void> addPost(Map<String, dynamic> data) async {
    emit(AddPostLoading());
    final res = await homeRepo.addPssts(data);
    res.fold((failure) {
      emit(AddPostFailure(failure.errorMessage));
    }, (post) {
      emit(AddPostSuccess(post));
    });
  }

}
