import 'package:store/store/repository/store_repository.dart';
import 'package:store/store/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreCubit extends Cubit<StoreState>{
  StoreCubit() : super(const StoreState());

  final StoreRepository api = StoreRepository();
}