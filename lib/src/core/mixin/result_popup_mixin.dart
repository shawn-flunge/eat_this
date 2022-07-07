import 'dart:math' as math;
import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/data/models/category.dart';
import 'package:eat_this/src/data/models/restaurant.dart';
import 'package:eat_this/src/domain/controllers/place_controller.dart';
import 'package:eat_this/src/presentation/roulette.dart';
import 'package:flutter/material.dart';

mixin ResultPopUpMixin{

  Future<Restaurant?> basic(Restaurant selectedRestaurant, PlaceController placeController) async{

    final Restaurant? destination = await showDialog<Restaurant>(
        context: homeScreenScaffoldKey.currentContext!,
        builder: (BuildContext dialogueContext){

          return Dialog(
            child: SizedBox(
              height: 200,
              child: StatefulBuilder(
                builder: (builderContext, setStateDialogue){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        selectedRestaurant.placeName,
                        style: const TextStyle(
                            fontSize: 24
                        ),
                      ),
                      Text(
                        selectedRestaurant.roadAddress + ' (${selectedRestaurant.distance}m)',
                      ),
                      Text(
                        selectedRestaurant.placeCategory.fullName,
                      ),
                      Text(
                        selectedRestaurant.placeName,
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              setStateDialogue(() {
                                final int random = math.Random().nextInt(placeController.restaurants.length);
                                selectedRestaurant = placeController.restaurants[random];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black)
                              ),
                              child: const Icon(
                                Icons.refresh,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              Navigator.pop(builderContext, selectedRestaurant);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                              decoration: const BoxDecoration(
                                  color: Colors.black
                              ),
                              child: const Text(
                                '선택',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          );
        }
    );
    return destination;
  }

  Future<Restaurant?> category(List<RouletteContent> contents, List<Category> categories, int selectedIndex) async{
    late AnimationController rouletteController;
    final Restaurant? destination = await showDialog<Restaurant>(
        context: homeScreenScaffoldKey.currentContext!,
        builder: (context){
          return AlertDialog(

            content: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: RouletteWidget(
                      contents: contents,
                      onCreated: (controller){
                        rouletteController = controller;
                      },
                      hand: Container(width: 40, height: 10, color: Colors.black,),
                      onFinish: (index){
                        selectedIndex = index;
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          rouletteController.reset();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black)
                          ),
                          child: const Icon(
                            Icons.refresh,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          List<Restaurant> restaurants = [];
                          categories[selectedIndex].kakaoSearchResponseDtos.map((e) => restaurants.add(e)).toList();

                          if(categories[selectedIndex].subSteps.isNotEmpty){
                            categories[selectedIndex].subSteps.map((e){
                              restaurants.addAll(e.kakaoSearchResponseDtos);
                            }).toList();
                          }
                          Navigator.pop(homeScreenScaffoldKey.currentContext!, restaurants[math.Random().nextInt(restaurants.length)]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                          decoration: const BoxDecoration(
                              color: Colors.black
                          ),
                          child: const Text(
                            '선택',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          );
        }
    );

    return destination;
  }

}