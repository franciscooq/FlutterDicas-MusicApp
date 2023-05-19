import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:music_app/features/genre_details/presentation/screens/genre_details_screen.dart';
import 'package:music_app/features/genre_list/presentation/controllers/genre_list_controller.dart';
import 'package:music_app/shared/widgets/img_and_title_row_widget.dart';

import '../../../../shared/widgets/screen_widget.dart';

class GenreListScreen extends StatelessWidget {
  static const routName = "/genre-list";

  const GenreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final genreListCtrl = Get.find<GenreListController>();

    return Obx(
      () => ScreenWidget(
        isLoading: false,
        title: "Lista de Generos",
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  itemBuilder: (_, int index) {
                    final genre = genreListCtrl.genres[index];

                    return InkWell(
                      onTap: () => Get.toNamed(
                        '${GenreListScreen.routName}${GenreDetailsScreen.routeName}',
                        arguments: genre,
                      ),
                      child: ImgAndTitleRowWidget(
                        title: genre.title,
                        heroTag: genre.title,
                        img: genre.img,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: genreListCtrl.genres.length,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
        // error: "Ocorreu um erro.",
        // onTryAgain: () {},
      ),
    );
  }
}
