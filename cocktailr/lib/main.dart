import 'package:cocktailr/src/root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/blocs/cocktail_bloc.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider(builder: (context) => CocktailBloc()),
        ],
        child: Root(),
      ),
    );
