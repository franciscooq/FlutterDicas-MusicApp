import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/genre_details/presentation/bindings/genre_details_bidings.dart';
import '../../features/genre_details/presentation/screens/genre_details_screen.dart';
import '../../features/genre_list/presentation/bindings/genre_list_bindings.dart';
import '../../features/genre_list/presentation/screens/genre_list_screen.dart';
import 'music_app_colors.dart';

class MusicAppMaterial {
  MusicAppMaterial._();

  static String get getTitle => "Music App - Flutter Dicas Bootcamp";

  static List<GetPage> get GetPages => [
        GetPage(
            name: GenreListScreen.routName,
            page: () => const GenreListScreen(),
            binding: GenreListBindings(),
            children: [
              GetPage(
                name: GenreDetailsScreen.routeName,
                page: () => const GenreDetailsScreen(),
                binding: GenreDetailsBidings(),
              )
            ])
      ];

  static ThemeData get getTheme => ThemeData(
        primaryColor: MusicAppColors.primatyColor,
        appBarTheme: AppBarTheme(
          backgroundColor: MusicAppColors.primatyColor,
          titleTextStyle: TextStyle(
            color: MusicAppColors.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        fontFamily: 'Nunito',
      );
}
