import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_bottom_nav_bar_state.dart';

class CustomerBottomNavBarCubit extends Cubit<int> {
  CustomerBottomNavBarCubit() : super(0);
  void changeTab(int index) => emit(index);
}
