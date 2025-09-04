import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:testing_riverpod/data/datasource/note_database.dart';
import 'package:testing_riverpod/data/datasource/sqlf_data_source.dart';
import 'package:testing_riverpod/data/repo/notes_repository_impl.dart';
import 'package:testing_riverpod/data/service/note_service.dart';
import 'package:testing_riverpod/data/service/notes_service_impl.dart';
import 'package:testing_riverpod/data/service/sqlf_data_source_impl.dart';
import 'package:testing_riverpod/domain/repo/notes_repositroy.dart';
import 'package:testing_riverpod/domain/usecase/notes/delete_note_usecase.dart';
import 'package:testing_riverpod/domain/usecase/notes/get_all_notes_usecase.dart';
import 'package:testing_riverpod/domain/usecase/notes/get_note_usecase.dart';
import 'package:testing_riverpod/domain/usecase/notes/store_note_usecase.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_bloc.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocators() async {
  locator.registerLazySingleton<Logger>(() => Logger(level: Level.debug));

  //Provide datasources
  locator.registerLazySingleton<SqlfDataSource>(
    () =>
        SqlfDataSourceImpl(database: NoteDatabase.instance, logger: locator()),
  );

  //Provide services
  locator.registerLazySingleton<NoteService>(
    () => NotesServiceImpl(locator(), locator()),
  );

  //Provide repositories
  locator.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(logger: locator(), service: locator()),
  );

  //Provide usecases“
  locator.registerLazySingleton<GetAllNotesUsecase>(
    () => GetAllNotesUsecase(locator()),
  );

  locator.registerLazySingleton<StoreNoteUsecase>(
    () => StoreNoteUsecase(locator()),
  );

  locator.registerLazySingleton<GetNoteUsecase>(
    () => GetNoteUsecase(locator()),
  );

  locator.registerLazySingleton<DeleteNoteUsecase>(
    () => DeleteNoteUsecase(locator()),
  );

  //Provide blocs
  locator.registerFactory<NotesBloc>(() => NotesBloc(locator(), locator()));

  locator.registerFactory<NoteDetailsBloc>(
    () => NoteDetailsBloc(locator(), locator()),
  );
}
