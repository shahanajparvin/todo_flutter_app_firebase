// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/local/db/database_provider.dart' as _i629;
import '../../data/datasources/local/db/db_helper.dart' as _i734;
import '../../data/datasources/local/local_data_source.dart' as _i851;
import '../../data/datasources/local/local_data_source_impl.dart' as _i311;
import '../../data/datasources/remote/remote_data_source.dart' as _i284;
import '../../data/datasources/remote/remote_data_source_impl.dart' as _i503;
import '../../data/repository/todo_repository_impl.dart' as _i73;
import '../../domain/repository/todo_repository.dart' as _i530;
import '../../domain/usecases/add_task_usecase.dart' as _i363;
import '../../domain/usecases/delete_task_usecase.dart' as _i611;
import '../../domain/usecases/get_tasks_usecase.dart' as _i845;
import '../../domain/usecases/get_unsynced_tsks_usecase.dart' as _i4;
import '../../domain/usecases/update_iscompleted_usecase.dart' as _i841;
import '../../domain/usecases/update_task_usecase.dart' as _i676;
import '../../presentation/task/bloc/task_bloc.dart' as _i294;
import '../utils/app_alert_manager.dart' as _i839;
import '../utils/internet_connection_checker.dart' as _i338;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i338.InternetConnectionChecker>(
        () => _i338.InternetConnectionChecker());
    gh.factory<_i839.AppCustomAlertManager>(
        () => _i839.AppCustomAlertManager());
    gh.singleton<_i629.DatabaseProvider>(() => _i629.DatabaseProvider());
    gh.lazySingleton<_i284.RemoteDataSource>(
        () => _i503.RemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i734.DbHelper>(
        () => _i734.DbHelper(gh<_i629.DatabaseProvider>()));
    gh.singleton<_i851.LocalDataSource>(
        () => _i311.LocalDataSourceImpl(gh<_i734.DbHelper>()));
    gh.lazySingleton<_i530.TodoRepository>(() => _i73.TodoRepositoryImpl(
          remoteDataSource: gh<_i284.RemoteDataSource>(),
          localDataSource: gh<_i851.LocalDataSource>(),
          connectionChecker: gh<_i338.InternetConnectionChecker>(),
        ));
    gh.factory<_i363.AddTaskUseCase>(
        () => _i363.AddTaskUseCase(repository: gh<_i530.TodoRepository>()));
    gh.factory<_i676.UpdateTaskUseCase>(
        () => _i676.UpdateTaskUseCase(repository: gh<_i530.TodoRepository>()));
    gh.factory<_i611.DeleteTaskUseCase>(
        () => _i611.DeleteTaskUseCase(repository: gh<_i530.TodoRepository>()));
    gh.factory<_i4.GetUnsyncedTsksUsecase>(() =>
        _i4.GetUnsyncedTsksUsecase(repository: gh<_i530.TodoRepository>()));
    gh.factory<_i841.UpdateIsCompletedUseCase>(() =>
        _i841.UpdateIsCompletedUseCase(repository: gh<_i530.TodoRepository>()));
    gh.factory<_i845.GetTasksUseCase>(
        () => _i845.GetTasksUseCase(repository: gh<_i530.TodoRepository>()));
    gh.factory<_i294.TaskBloc>(() => _i294.TaskBloc(
          gh<_i845.GetTasksUseCase>(),
          gh<_i363.AddTaskUseCase>(),
          gh<_i676.UpdateTaskUseCase>(),
          gh<_i611.DeleteTaskUseCase>(),
          gh<_i841.UpdateIsCompletedUseCase>(),
        ));
    return this;
  }
}
