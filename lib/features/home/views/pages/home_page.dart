import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/routes/app_routes.dart';
import 'package:news_application/core/views/widgets/app_drawer.dart';
import 'package:news_application/core/views/widgets/custom_app_bar_icon.dart';
import 'package:news_application/features/home/home_cubit/home_cubit.dart';
import 'package:news_application/features/home/views/widgets/custom_carousal_slider_widget.dart';
import 'package:news_application/features/home/views/widgets/head_line_title_widget.dart';
import 'package:news_application/features/home/views/widgets/list_recommended_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      onDrawerChanged: (isOpened) async {
        if (!isOpened) {
          await Future.wait([
            homeCubit.fetchRecommendedNewsInitial(),
            homeCubit.fetchTopHeadlines(),
          ]);
        }
      },
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: CustomAppBarIcon(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          iconData: Icons.menu,
        ),
        actions: [
          CustomAppBarIcon(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.searchRoute),
            iconData: Icons.search,
            isPadding: true,
          ),
          CustomAppBarIcon(
            onTap: () {},
            iconData: Icons.notifications_none_outlined,
            isPadding: true,
          ),
          SizedBox(width: size.width * 0.02),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                bloc: homeCubit,
                buildWhen: (previous, current) =>
                    current is TopHeadlinesLoading ||
                    current is TopHeadlinesSuccess ||
                    current is TopHeadlinesError,
                builder: (context, state) {
                  if (state is TopHeadlinesLoading) {
                    final fakeArticles = state.fakeArticles;
                    return Skeletonizer(
                      enabled: true,
                      child: Column(
                        children: [
                          HeadLineTitleWidget(
                            title: "Breaking News",
                            onTap: () {},
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            height: size.height * 0.3,
                            width: size.width,
                            child: CustomCarousalSliderWidget(
                              articles: fakeArticles,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is TopHeadlinesError) {
                    return Center(child: Text(state.message));
                  } else if (state is TopHeadlinesSuccess) {
                    final articles = state.articles;
                    return Skeletonizer(
                      enabled: false,
                      child: Column(
                        children: [
                          HeadLineTitleWidget(
                            title: "Breaking News",
                            onTap: () {},
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            height: size.height * 0.3,
                            width: size.width,
                            child: CustomCarousalSliderWidget(
                              articles: articles,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),

              SizedBox(height: size.height * 0.02),

              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  buildWhen: (previous, current) =>
                      current is RecommendedNewsLoading ||
                      current is RecommendedNewsSuccess ||
                      current is RecommendedNewsError ||
                      current is RecommendedNewsLoadMore,
                  builder: (context, state) {
                    if (state is RecommendedNewsLoading) {
                      final fakeArticles = state.fakeArticles;

                      return Skeletonizer(
                        enabled: true,
                        child: Column(
                          children: [
                            HeadLineTitleWidget(
                              title: "Recommendation",
                              onTap: () {},
                            ),
                            SizedBox(height: size.height * 0.02),
                            Expanded(
                              child: ListRecommendedWidget(articles: fakeArticles),
                            ),
                          ],
                        ),
                      );
                    } else if (state is RecommendedNewsError) {
                      return Center(child: Text(state.message));
                    } else if (state is RecommendedNewsLoadMore) {
                      final articles = homeCubit.articlesList;
                      return Skeletonizer(
                        enabled: false,
                        child: Column(
                          children: [
                            HeadLineTitleWidget(
                              title: "Recommendation",
                              onTap: () {},
                            ),
                            SizedBox(height: size.height * 0.02),
                            Expanded(
                              child: ListRecommendedWidget(articles: articles),
                            ),
                          ],
                        ),
                      );
                    } else if (state is RecommendedNewsSuccess) {
                      final articles = homeCubit.articlesList;
                      return Skeletonizer(
                        enabled: false,
                        child: Column(
                          children: [
                            HeadLineTitleWidget(
                              title: "Recommendation",
                              onTap: () {},
                            ),
                            SizedBox(height: size.height * 0.02),
                            Expanded(
                              child: ListRecommendedWidget(articles: articles),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
