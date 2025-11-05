import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyur_practicle/common_widget/app_image.dart';
import '../../bloc/home/home_bloc.dart';
import '../../core/app_colors.dart';
import '../../core/app_styles.dart';
import '../../main.dart';
import 'logout_sheet.dart';
import '../../data/models/login_response.dart';

class HomePage extends StatelessWidget {
  final void Function(Locale) onLocaleChange;

  const HomePage({required this.onLocaleChange, super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations(Localizations.localeOf(context));

    return BlocProvider(
      create: (_) => HomeBloc()..add(LoadAlbums()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            child: AppBar(
              elevation: 0,
              backgroundColor: AppColors.primary,
              leadingWidth: 70,
              leading: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    String profileImage = "";
                    if (state is HomeLoaded) {
                      profileImage = state.profileImage;
                    }
                    return Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ImageView(
                            imageUrl: "assets/images/profile_image_bg.png",
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ClipOval(
                              child: Image.network(
                                profileImage,
                                height: 32,
                                width: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Image.asset(
                                  "assets/images/user_placeholder.png",
                                  height: 32,
                                  width: 32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                loc.tr('appTitle'),
                style: AppTextStyle.appTitle.copyWith(fontSize: 30),
              ),
              centerTitle: true,
              actions: [
                // 🌐 Language change button
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () async {
                      // show simple bottom sheet to choose language
                      await showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return _buildLanguageSheet(context);
                        },
                      );
                    },
                    child: const Icon(Icons.language, color: Colors.white, size: 26),
                  ),
                ),

                // 🚪 Logout button
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () => showLogoutBottomSheet(context),
                    child: ImageView(
                      imageUrl: "assets/images/logout_icon.svg",
                      height: 28,
                      width: 28,
                    ),
                  ),
                ),
              ],

            ),
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else if (state is HomeLoaded) {
              return Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                            color: AppColors.black.withOpacity(0.10),
                          )
                        ],
                      ),
                      child: TextFormField(
                        cursorColor: AppColors.primary,
                        onChanged: (value) => context
                            .read<HomeBloc>()
                            .add(FilterAlbums(value)),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 15, right: 11, top: 15, bottom: 15),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ImageView(
                              imageUrl: "assets/images/search_icon.svg",
                              height: 24,
                              width: 24,
                            ),
                          ),
                          suffixIconConstraints: BoxConstraints(minWidth: 24, minHeight: 24),
                          hintText: loc.tr('search_by_name'),
                          hintStyle: AppTextStyle.raleWayMedium16.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: state.filteredAlbums.isEmpty
                          ? const Center(child: Text('No pets found'))
                          : ListView.builder(
                        itemCount: state.filteredAlbums.length,
                        itemBuilder: (context, index) {
                          final album = state.filteredAlbums[index];
                          return _buildAlbumItem(album);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildAlbumItem(Album album) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 9),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ImageView(imageUrl: album.profileImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(album.name,
                            style: AppTextStyle.raleWayMedium14.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.mediumGray2)),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.liteBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Male',
                              style: AppTextStyle.raleWayMedium16.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blue)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text('ID: ${album.id}',
                        style: AppTextStyle.raleWayMedium16.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayLite)),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: AppColors.black.withOpacity(0.10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDataColumn("Mating date", "12/12/23"),
              _buildDataColumn("Breeding Partner", "Emmy"),
              _buildDataColumn("Pregnancy", "Y"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataColumn(String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyle.raleWayMedium14.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.blackLite)),
        Text(subTitle,
            style: AppTextStyle.raleWayMedium14.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.mediumGray2)),
      ],
    );
  }

  Widget _buildLanguageSheet(BuildContext context) {
    final loc = AppLocalizations(Localizations.localeOf(context));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              loc.tr('choose_language'),
              style: AppTextStyle.appTitle.copyWith(fontSize: 18,color: AppColors.darkCharcoal),
            ),
            const SizedBox(height: 20),

            _buildLangOption(context, "English", "en"),
            const SizedBox(height: 10),
            _buildLangOption(context, "हिन्दी", "hi"),
          ],
        ),
      ),
    );
  }

  Widget _buildLangOption(BuildContext context, String title, String code) {
    final currentCode = Localizations.localeOf(context).languageCode;
    final isSelected = currentCode == code;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTextStyle.raleWayMedium14.copyWith(
          fontWeight: FontWeight.w600,
          color: isSelected ? AppColors.primary : AppColors.darkCharcoal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () async {
        Navigator.pop(context);
        final locale = Locale(code);
        onLocaleChange(locale); // ✅ Fixed line
      },
    );
  }



}

