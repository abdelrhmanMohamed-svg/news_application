import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/core/utils/theme/app_colors.dart';
import 'package:news_application/core/views/widgets/article_item_list.dart';
import 'package:news_application/features/search/search_cubit/search_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
  _scrollController = ScrollController();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "News form all around the world",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.gray,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: BlocBuilder<SearchCubit, SearchState>(
                    bloc: searchCubit,
                    buildWhen: (previous, current) =>
                        current is SearchLoading ||
                        current is SearchLoaded ||
                        current is SearchError,
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return TextButton(
                          onPressed: null,
                          child: const Text("Searching..."),
                        );
                      }
                      return TextButton(
                        onPressed: () async {
                          final String keyWord = _searchController.text;
                          await searchCubit.searchNews(keyWord);
                          _searchController.clear();
                        },
                        child: const Text("Search"),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              BlocBuilder<SearchCubit, SearchState>(
                bloc: searchCubit,
                buildWhen: (previous, current) =>
                    current is SearchLoading ||
                    current is SearchLoaded ||
                    current is SearchError,
                builder: (context, state) {
                  if (state is SearchLoading) {
                    final fakeArticles = state.fakeArticles;
                    return Expanded(
                      child: Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final fakeArticle = fakeArticles[index];
                            return ArticleItemList(article: fakeArticle);
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: size.height * 0.02),
                          itemCount: fakeArticles.length,
                        ),
                      ),
                    );
                  } else if (state is SearchError) {
                    return Text(state.message);
                  } else if (state is SearchLoaded) {
                    final articles = state.articles;
                    return articles.isEmpty
                        ? Center(child: const Text("No articles found"))
                        : Expanded(
                            child: Skeletonizer(
                              enabled: false,
                              child: ListView.separated(
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  final article = articles[index];
                                  return ArticleItemList(article: article);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: size.height * 0.02),
                                itemCount: 5,
                              ),
                            ),
                          );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
