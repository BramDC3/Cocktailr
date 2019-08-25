import 'package:cocktailr/src/blocs/cocktail_bloc.dart';
import 'package:cocktailr/src/constants/color_constants.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:cocktailr/src/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CocktailDetailScreen extends StatelessWidget {
  CocktailDetailScreen({@required this.cocktailId});
  final String cocktailId;

  @override
  Widget build(BuildContext context) {
    final cocktailBloc = Provider.of<CocktailBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder(
        stream: cocktailBloc.cocktails,
        builder:
            (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
          if (!snapshot.hasData) {
            return loadingSpinner();
          }

          return FutureBuilder(
            future: snapshot.data[cocktailId],
            builder: (context, AsyncSnapshot<Cocktail> cocktailSnapshot) {
              if (!cocktailSnapshot.hasData) {
                return loadingSpinner();
              }

              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Image.network(
                      cocktailSnapshot.data.image,
                      height: screenWidth,
                      width: screenWidth,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: screenWidth,
                      margin: EdgeInsets.only(top: screenWidth * 9.3 / 10),
                      padding: EdgeInsets.only(top: screenWidth * 0.75 / 10),
                      decoration: BoxDecoration(
                        color: ColorConstants.defaultBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(cocktailSnapshot.data.name),
                          Text(cocktailSnapshot.data.isAlcoholic
                              ? "Alcoholic"
                              : "Non-alcoholic"),
                          Text(cocktailSnapshot.data.category),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// class CocktailDetailScreen extends StatelessWidget {
//   final String cocktailId;

//   CocktailDetailScreen({@required this.cocktailId});

//   @override
//   Widget build(BuildContext context) {
//     final cocktailBloc = Provider.of<CocktailBloc>(context);
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Container(
//       child: Scaffold(
//         body: StreamBuilder(
//           stream: cocktailBloc.cocktails,
//           builder:
//               (context, AsyncSnapshot<Map<String, Future<Cocktail>>> snapshot) {
//             if (!snapshot.hasData) {
//               return loadingSpinner();
//             }

//             return FutureBuilder(
//               future: snapshot.data[cocktailId],
//               builder: (context, AsyncSnapshot<Cocktail> cocktailSnapshot) {
//                 if (!cocktailSnapshot.hasData) {
//                   return loadingSpinner();
//                 }

//                 return SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       _cocktailHeader(
//                         cocktailSnapshot.data,
//                         screenWidth,
//                       ),
//                       _cocktailBody(
//                         cocktailSnapshot.data,
//                         screenWidth,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _cocktailHeader(Cocktail cocktail, double width) => Stack(
//         children: <Widget>[
//           Container(height: width + width / 14),
//           _cocktailImage(cocktail, width),
//           _favoriteButton(width),
//         ],
//       );

//   Widget _cocktailImage(Cocktail cocktail, double width) => ClipRRect(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(52),
//         ),
//         child: Image.network(
//           cocktail.image,
//           width: width,
//           height: width,
//           fit: BoxFit.cover,
//         ),
//       );

//   Widget _favoriteButton(double width) => Positioned(
//         bottom: 0,
//         right: width / 16,
//         child: Container(
//           height: width / 6,
//           width: width / 6,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(90),
//             border: Border.all(
//               color: ColorConstants.defaultBackgroundColor,
//               width: 7,
//               style: BorderStyle.solid,
//             ),
//           ),
//           child: RawMaterialButton(
//             onPressed: () {},
//             shape: CircleBorder(),
//             fillColor: Color(0xFFFA7574),
//             highlightElevation: 4,
//             highlightColor: Colors.redAccent,
//             child: Icon(
//               Icons.favorite,
//               color: Colors.white,
//               size: width / 17,
//             ),
//           ),
//         ),
//       );

//   Widget _cocktailName(Cocktail cocktail, double width) {
//     Widget text;

//     if (!cocktail.name.contains(' '))
//       text = Text(
//         StringUtils.capitalizeWord(cocktail.name),
//         style: TextStyle(
//           fontSize: 36,
//           fontWeight: FontWeight.bold,
//         ),
//         textAlign: TextAlign.start,
//       );

//     List<String> words = cocktail.name.split(' ');
//     bool isEven = words.length % 2 == 0;
//     List<Text> texts = [];

//     for (int i = 0; i < words.length; i++) {
//       if (isEven) {
//         if (i < (words.length / 2).floor()) {
//           texts.add(
//             Text(
//               StringUtils.capitalizeWord(words[i]),
//               style: TextStyle(
//                 fontSize: 36,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           );
//         } else {
//           texts.add(
//             Text(
//               StringUtils.capitalizeWord(words[i]),
//               style: TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           );
//         }
//       } else {
//         if (i <= (words.length / 2).floor()) {
//           texts.add(
//             Text(
//               StringUtils.capitalizeWord(words[i]),
//               style: TextStyle(
//                 fontSize: 36,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           );
//         } else {
//           texts.add(
//             Text(
//               StringUtils.capitalizeWord(words[i]),
//               style: TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.start,
//             ),
//           );
//         }
//       }
//     }

//     text = Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: texts,
//     );

//     return Container(
//       padding: EdgeInsets.only(left: width / 10),
//       child: text,
//     );
//   }

//   Widget _cocktailAlcoholicLabel(Cocktail cocktail, double width) => Container(
//         padding: EdgeInsets.only(left: width / 10),
//         child: Text(
//           "Alcoholic",
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontSize: 18,
//           ),
//         ),
//       );

//   Widget _cocktailBody(Cocktail cocktail, double width) => Container(
//         padding: EdgeInsets.only(top: 8),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   _cocktailName(cocktail, width),
//                   SizedBox(height: 8),
//                   _cocktailAlcoholicLabel(cocktail, width),
//                 ],
//               ),
//             ),
//             _cocktailCategory(cocktail, width),
//           ],
//         ),
//       );

//   Widget _cocktailCategory(Cocktail cocktail, double width) => Container(
//         width: width / 8 + width / 6 + 13,
//         child: Center(
//           child: RotatedBox(
//             quarterTurns: 3,
//             child: Stack(
//               children: <Widget>[
//                 Text(
//                   cocktail.category,
//                   style: TextStyle(
//                     fontSize: 64,
//                     fontWeight: FontWeight.bold,
//                     foreground: Paint()
//                       ..style = PaintingStyle.stroke
//                       ..strokeWidth = 5
//                       ..color = ColorConstants.borderedTextBorderColor,
//                   ),
//                 ),
//                 Text(
//                   cocktail.category,
//                   style: TextStyle(
//                     fontSize: 64,
//                     fontWeight: FontWeight.bold,
//                     color: ColorConstants.defaultBackgroundColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
// }
