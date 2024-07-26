library zoncan.features.account.domain;

import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';


import '../domain/domain.dart';



part 'models/user_details_model.dart';
part 'repository/user_details_repository_impl.dart';
part 'datasource/local/user_details_table.dart';
part 'data.g.dart';
part 'data.mapper.dart';
