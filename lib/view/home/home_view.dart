// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orders/view/home/widgets/section_header.dart';

import '../../widgets/nothing_widget.dart';
import '../drawer/drawer.dart';
import 'component/buttons_shimmer.dart';
import 'component/category_buttons_listview.dart';
import 'component/home_appbar.dart';
import 'component/home_carousel.dart';
import 'component/item_card.dart';
import 'component/item_card_shimmer.dart';
import 'component/popular_brand_near_you_list_view.dart';
import 'component/popular_brands_card_shimmer.dart';
import 'component/special_offer_card.dart';
import 'controller/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => HomeCubit()
          ..getSlides()
          ..getStoreCategories()
          ..getPopularBrands()
          ..getPopularFood()
          ..getSpecialOffers(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetItemError ||
                state is GetStoreCategoriesError ||
                state is GetPopularBrandsError ||
                state is GetPopularFoodError ||
                state is LogoutErrorState ||
                state is GetStoreOfCategoryError ||
                state is GetStoreError ||
                state is GetStoreSubCategoriesByIdError ||
                state is GetSpecialOffersError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("change_password.some_error".tr()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = HomeCubit.get(context);
            return Scaffold(
              key: cubit.scaffoldKey,
              drawer: const NavigationDrawer(),
              appBar: homeAppBar(cubit),
              body: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  cubit.storeCategoriesModel == null
                      ? const ButtonsShimmer()
                      : cubit.storeCategoriesModel!.data!.isEmpty
                          ? NothingWidget(color: Colors.grey.shade300)
                          : CategoryButtonsListView(
                              storeCategoriesModel:
                                  cubit.storeCategoriesModel!),
                  cubit.slidesModel == null
                      ? const SliderShimmer()
                      : HomeCarousel(cubit: cubit),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SectionHeader(
                      showButton: false,
                      buttonText: '',
                      headerText: "home.popular_food".tr(),
                      onPressed: () {},
                    ),
                  ),
                  cubit.popularFoodModel == null
                      ? const ItemCardShimmer()
                      : ItemCard(cubit: cubit),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SectionHeader(
                      buttonText: '',
                      headerText: "home.brands".tr(),
                      onPressed: () {},
                      showButton: false,
                    ),
                  ),
                  cubit.popularBrandsModel == null
                      ? const PopularBrandsCardShimmer()
                      : cubit.popularBrandsModel!.data!.isEmpty
                          ? NothingWidget(color: Colors.grey.shade300)
                          : PopularBrandNearYouListView(cubit: cubit),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SectionHeader(
                      buttonText: '',
                      headerText: "home.special_offers".tr(),
                      showButton: false,
                      onPressed: () {},
                    ),
                  ),
                  cubit.specialOffersModel == null
                      ? const ItemCardShimmer()
                      : cubit.specialOffersModel!.data!.isEmpty
                          ? NothingWidget(color: Colors.grey.shade300)
                          : SpecialOfferCard(
                              specialOffersModel: cubit.specialOffersModel!),
                  const SizedBox(height: 20.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
