import 'package:dartz/dartz.dart';
import 'package:music_app/core/errors/exceptions.dart';
import 'package:music_app/core/errors/failures.dart';
import 'package:music_app/core/services/api_service.dart';
import 'package:music_app/shared/models/genre_model.dart';

class GenreListRepository {
  final ApiService _apiService;

  GenreListRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<Either<Failure, List<GenreModel>>> getGenreList() async {
    try {
      final genres = await _apiService.getGenres();

      return Right(genres);
    } on ApiException catch (apiException) {
      return Left(GetGenreDetailsFailure(apiException.message));
    } on GeneralException catch (generalException) {
      return Left(GetGenreDetailsFailure(generalException.message));
    }
  }
}


//<Failure, List<GenreModel>>