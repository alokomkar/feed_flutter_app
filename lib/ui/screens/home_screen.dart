import 'package:feed_flutter_app/ui/model/recipe.dart';
import 'package:feed_flutter_app/ui/utils/store.dart';
import 'package:feed_flutter_app/ui/widget/recipe_card.dart';
import 'package:flutter/material.dart';

//Equivalent of View
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

//Equivalent of binder for View
class HomeScreenState extends State<HomeScreen> {

  // New member of the class:
  List<Recipe> recipes = getRecipes();
  List<String> userFavorites = getFavoritesIDs();

  double _iconSize = 20.0;

  // New method:
  // Inactive widgets are going to call this method to
  // signalize the parent widget HomeScreen to refresh the list view.
  void _handleFavoritesListChanged(String recipeID) {
    // Set new state and refresh the widget:
    setState(() {
      if (userFavorites.contains(recipeID)) {
        userFavorites.remove(recipeID);
      } else {
        userFavorites.add(recipeID);
      }
    });
  }

  Padding _buildRecipesWithPadding(List<Recipe> recipeList) => Padding(
    // Padding before and after the list view:
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: _buildRecipes(recipeList),
  );

  // New method:
  Column _buildRecipes(List<Recipe> recipesList) => Column(
    children: <Widget>[
      Expanded(
        child: ListView.builder(
          itemCount: recipesList.length,
          itemBuilder: (BuildContext context, int index) => _buildListTileWithRecipe(index, recipesList),
        ),
      ),
    ],
  );

  RecipeCard _buildListTileWithRecipe( int index, List<Recipe> recipesList ) => new RecipeCard(
    recipe: recipesList[index],
    inFavorites: userFavorites.contains(recipesList[index].id),
    onFavoriteButtonPressed: _handleFavoritesListChanged,
  );

  AppBar _buildAppBarWithTabs() => AppBar(
    backgroundColor: Colors.white,
    elevation: 2.0,
    bottom: TabBar(
      labelColor: Theme.of(context).indicatorColor,
      tabs: [
        Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
        Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
        Tab(icon: Icon(Icons.favorite, size: _iconSize)),
        Tab(icon: Icon(Icons.settings, size: _iconSize)),
      ],
    ),
  );

  TabBarView _buildTabBarView() => TabBarView(
    // Replace placeholders:
    children: [
      // Display recipes of type food:
      _buildRecipesWithPadding(recipes
          .where((recipe) => recipe.type == RecipeType.food)
          .toList()),
      // Display recipes of type drink:
      _buildRecipesWithPadding(recipes
          .where((recipe) => recipe.type == RecipeType.drink)
          .toList()),
      // Display favorite recipes:
      _buildRecipesWithPadding(recipes
          .where((recipe) => userFavorites.contains(recipe.id))
          .toList()),
      Center(child: Icon(Icons.settings)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize( // New code
          // We set Size equal to passed height (50.0) and infinite width:
          preferredSize: Size.fromHeight(50.0), // New code
          child: _buildAppBarWithTabs(),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: _buildTabBarView(),
        ),
      ),
    );
  }

}