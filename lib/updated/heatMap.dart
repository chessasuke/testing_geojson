import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testing_geojson/models/building_model.dart';
import 'package:testing_geojson/updated/custom_searchbar.dart';
import 'package:testing_geojson/updated/structures_provider.dart';
import 'package:testing_geojson/updated/updated_custom_map.dart';

final showBuildingMarkerProvider = StateProvider<bool>((ref) => false);
final showStructureMarkerProvider = StateProvider<bool>((ref) => false);
//final showLinesMarkerProvider = StateProvider<bool>((ref) => false);
final showSearchBarProvider = StateProvider<bool>((ref) => false);
final filterProvider = StateProvider<String>((ref) => '');

class Heatmap extends ConsumerWidget {
  static const double scaleLimit = 1.6487212707001282;

  List<Widget> buildList(
    Size screenSize,
    bool showBuildingsMarker,
    bool showStructuresMarker,
//    bool showLinesMarker,
    bool showSearchBar,
    List<Structure> buildings,
    List<Structure> structures4d,
    List<Street> streets,
  ) {
    List<Widget> list = [
      Container(
        width: screenSize.width,
        height: screenSize.height,
        child: RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            willChange: false,
            painter: UpdatedCustomMap(),
            child: const SizedBox(),
          ),
        ),
      )
    ];

    /// Toggle showing buildings markers
    if (showBuildingsMarker) {
      /// Skip first one since it's the UTD perimeter
      for (int i = 0; i < buildings.length; i++) {
        ///
        var offsetCorrected = [
          buildings[i].centroid.first + screenSize.width / 2 - 5,
          buildings[i].centroid.last + screenSize.height / 1.2 - 10
        ];
        list.add(Positioned(
            left: offsetCorrected.first,
            top: offsetCorrected.last,
            child: Tooltip(
              message: buildings[i].name,
              child: Icon(
                FontAwesomeIcons.solidBuilding,
                color: Colors.lightBlue.withOpacity(0.7),
                size: 10,
              ),
            )));
      }
    }

    /// Toggle showing structures markers
    if (showStructuresMarker) {
      for (int i = 0; i < structures4d.length; i++) {
        var offsetCorrected = [
          structures4d[i].centroid.first + screenSize.width / 2 - 5,
          structures4d[i].centroid.last + screenSize.height / 1.2 - 10
        ];
        list.add(Positioned(
            left: offsetCorrected.first,
            top: offsetCorrected.last,
            child: Tooltip(
              message: structures4d[i].name,
              child: Icon(
                FontAwesomeIcons.mapMarkerAlt,
                color: Colors.lightBlue.withOpacity(0.7),
                size: 10,
              ),
            )));
      }
    }

    /// Toggle showing structures markers
    if (showStructuresMarker) {
      for (int i = 0; i < streets.length; i++) {
        ///
        var offsetCorrected = [
          streets[i].coordinates.first + screenSize.width / 2,
          streets[i].coordinates.last + screenSize.height / 1.2
        ];
        list.add(Positioned(
            left: offsetCorrected.first,
            top: offsetCorrected.last,
            child: Tooltip(
              message: streets[i].name,
              child: Icon(
                FontAwesomeIcons.mapMarkerAlt,
                color: Colors.lightBlue.withOpacity(0.7),
                size: 10,
              ),
            )));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final showBuildingMarker = watch(showBuildingMarkerProvider).state;
    final showStructureMarker = watch(showStructureMarkerProvider).state;
//    final showLinesMarker = watch(showLinesMarkerProvider).state;
    final showSearchBar = watch(showSearchBarProvider).state;
    var filter = watch(filterProvider).state;

    final buildings = watch(buildingProvider);
    final structures4d = watch(structure4dProvider);
    final streets = watch(streetsProvider);

    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(children: [
          InteractiveViewer(
            maxScale: 3.5,
            minScale: 1,
            child: Stack(
                children: buildList(
              screenSize,
              showBuildingMarker,
              showStructureMarker,
//              showLinesMarker,
              showSearchBar,
              buildings,
              structures4d,
              streets,
            )),
          ),
          if (showSearchBar)
            CustomSearchBar(
              callback: (String value) {
                context.read(filterProvider).state = value;
                print('filter: $filter');
              },
            ),
          Positioned(
              top: screenSize.height / 2,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white),
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: showSearchBar
                              ? Theme.of(context).accentColor
                              : Colors.white,
                        ),
                        onPressed: () {
                          context.read(showSearchBarProvider).state =
                              !context.read(showSearchBarProvider).state;
                        }),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidBuilding,
                          color: showBuildingMarker
                              ? Theme.of(context).accentColor
                              : Colors.white,
                        ),
                        onPressed: () {
                          context.read(showBuildingMarkerProvider).state =
                              !context.read(showBuildingMarkerProvider).state;
                        }),
                    IconButton(
                        icon: Icon(FontAwesomeIcons.mapMarkerAlt,
                            color: showStructureMarker
                                ? Theme.of(context).accentColor
                                : Colors.white),
                        onPressed: () {
                          context.read(showStructureMarkerProvider).state =
                              !context.read(showStructureMarkerProvider).state;
                        }),
//                    IconButton(
//                        icon: Icon(FontAwesomeIcons.road,
//                            color: showLinesMarker
//                                ? Theme.of(context).accentColor
//                                : Colors.white),
//                        onPressed: () {
//                          context.read(showLinesMarkerProvider).state =
//                              !context.read(showLinesMarkerProvider).state;
//                        }),
                    IconButton(
                        icon: Icon(FontAwesomeIcons.infoCircle,
                            color: Colors.white),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 300, maxHeight: 300),
                                  child: SimpleDialog(
                                    backgroundColor:
                                        Theme.of(context).dialogBackgroundColor,
                                    elevation: 30,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(FontAwesomeIcons.infoCircle),
                                        SizedBox(width: 20),
                                        Text('Information'),
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                            'To be updated - TODO explain the purpose of the icons and the colors of the map'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }),
                  ],
                ),
              ))
        ]));
  }
}
