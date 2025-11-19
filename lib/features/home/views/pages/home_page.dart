import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/features/home/home_cubit/home_cubit.dart';
import 'package:news_application/features/home/models/top_headlines_response.dart';
import 'package:news_application/features/home/views/widgets/custom_carousal_slider_widget.dart';
import 'package:news_application/features/home/views/widgets/head_line_title_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("News App"), centerTitle: true),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        buildWhen: (previous, current) =>
            current is TopHeadlinesLoading ||
            current is TopHeadlinesSuccess ||
            current is TopHeadlinesError,
        builder: (context, state) {
          if (state is TopHeadlinesLoading) {
            final fakeArticles = state.fakeArticles;
            return SingleChildScrollView(
              child: Skeletonizer(
                enabled: true,
                child: Column(
                  children: [
                    HeadLineTitleWidget(title: "Breaking News", onTap: () {}),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: CustomCarousalSliderWidget(articles: fakeArticles),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is TopHeadlinesError) {
            return Center(child: Text(state.message));
          } else if (state is TopHeadlinesSuccess) {
            final articles = state.articles;
            return SingleChildScrollView(
              child: Skeletonizer(
                enabled: false,
                child: Column(
                  children: [
                    HeadLineTitleWidget(title: "Breaking News", onTap: () {}),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: CustomCarousalSliderWidget(articles: articles),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
