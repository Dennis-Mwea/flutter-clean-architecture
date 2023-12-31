import 'package:auto_route/annotations.dart';
import 'package:core/core/core_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/common/constants/app_strings.dart';
import 'package:presentation/src/di/locator.dart';
import 'package:presentation/src/features/articles/list/article_list_view_model.dart';

@RoutePage()
class ArticleListScreen extends CoreScreen<ArticleListViewModel> {
  @override
  Widget builder(BuildContext context, ArticleListViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.articleList)),
      body: _buildBody(context, viewModel),
      floatingActionButton: Visibility(
        visible: !viewModel.isBusy,
        child: FloatingActionButton(
          onPressed: () => viewModel.loadArticles(),
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ArticleListViewModel viewModel) {
    if (viewModel.isBusy) {
      return Center(child: CircularProgressIndicator());
    } else if (viewModel.hasError) {
      return Center(child: Text(viewModel.errorMsg));
    } else {
      return ListView.builder(
          itemCount: viewModel.articleList.length, itemBuilder: (context, index) => _buildListViewItem(context, viewModel, viewModel.articleList[index]));
    }
  }

  Widget _buildListViewItem(BuildContext context, ArticleListViewModel viewModel, ArticleModel model) {
    return ListTile(
      isThreeLine: true,
      subtitle: Text(model.date, textDirection: TextDirection.rtl),
      contentPadding: EdgeInsets.all(10),
      title: Text(model.title, style: TextStyle(fontSize: 18)),
      leading: CircleAvatar(backgroundImage: NetworkImage(model.imageUrl), radius: 40),
      onTap: () => viewModel.onArticleItemClicked(model.id),
    );
  }

  @override
  ArticleListViewModel viewModelBuilder(BuildContext context) => locator<ArticleListViewModel>();
}
