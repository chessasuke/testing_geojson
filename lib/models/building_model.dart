import 'package:flutter/material.dart';

class Structure {
  Structure({
    this.coordinate,
    this.name,
    this.centroid,
  });

  /// Name of the building provided by dataCoordinate
  final String name;

  /// The first Offset provided by dataCoordinate for this building
  /// It's where the marker will appear
  final Offset coordinate;

  /// The centroid is calculated by taking the average of all
  /// coordinates of the polygon. This is not ideal, since polygons
  /// with a hole in the center for example will get the center wrong
  /// but it's enough for this use case (UTD CAMPUS MAP)
  final List<double> centroid;

  /// The timestamp of the last [BuildingEvent]
  DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  /// 2 possible status - infected(recently involved with a covid case),
  /// sanitized(recently involved in a covid case but already sanitized by Staff)
  /// The current status is determined by the last [BuildingEvent]
  bool _status;
  bool get status => _status;
}

class Street {
  final String name;
  final List coordinates;

  Street({this.name, this.coordinates});
}
