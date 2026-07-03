import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'technician_bottom_nav_bar_state.dart';

class TechnicianBottomNavBarCubit extends Cubit<int> {
  TechnicianBottomNavBarCubit() : super(0);
  void changeTab(int index) => emit(index);
}
