import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bnbcubit_state.dart';

class BNBCubit extends Cubit<BnbcubitState> {
  BNBCubit() : super(BnbcubitInitial());
  int currentIndex = 0;
  void changeIndex (index){
    currentIndex=index;
    emit(BnbcubitInitial());
  }
}
