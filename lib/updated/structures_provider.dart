import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing_geojson/data/buildingCenters.dart';
import 'package:testing_geojson/data/buildingName.dart';
import 'package:testing_geojson/data/centers4.dart';
import 'package:testing_geojson/data/coord3.dart';
import 'package:testing_geojson/data/name3.dart';
import 'package:testing_geojson/data/name4.dart';
import 'package:testing_geojson/models/building_model.dart';

import 'heatMap.dart';

/// 4d Structures - Buildings
final buildingProvider = Provider<List<Structure>>((ref) {
  final filter = ref.watch(filterProvider).state;
  List<Structure> buildings = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < namesBuild.length; i++) {
      if (namesBuild[i].toLowerCase().contains(filter.toLowerCase())) {
        buildings.add(Structure(
          name: namesBuild[i],
          centroid: buildingCenters[i],
        ));
      }
    }
  } else {
    for (int i = 0; i < namesBuild.length; i++) {
      buildings.add(Structure(
        name: namesBuild[i],
        centroid: buildingCenters[i],
      ));
    }
  }
  return buildings;
});

/// 4d Structures - non Buildings
final structure4dProvider = Provider<List<Structure>>((ref) {
  final filter = ref.watch(filterProvider).state;
  List<Structure> structures4D = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < names4D.length; i++) {
      if (names4D[i].toLowerCase().contains(filter.toLowerCase())) {
        structures4D.add(Structure(
          name: names4D[i],
          centroid: centers4D[i],
        ));
      } else
        print(names4D[i]);
    }
  } else {
    for (int i = 0; i < names4D.length; i++) {
      structures4D.add(Structure(
        name: names4D[i],
        centroid: centers4D[i],
      ));
    }
  }

  return structures4D;
});

/// 3d Structures
final streetsProvider = Provider<List<Street>>((ref) {
  final filter = ref.watch(filterProvider).state;
  List<Street> structures3D = [];

  if (filter != null && filter != '') {
    for (int i = 0; i < names3D.length; i++) {
      if (names3D[i].toLowerCase().contains(filter.toLowerCase())) {
        structures3D.add(Street(
          name: names3D[i],
          coordinates: coord3D[i][0],
        ));
      }
    }
  } else {
    for (int i = 0; i < names3D.length; i++) {
      structures3D.add(Street(
        name: names3D[i],
        coordinates: coord3D[i][0],
      ));
    }
  }

  return structures3D;
});
