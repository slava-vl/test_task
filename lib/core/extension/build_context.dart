import 'package:flutter/material.dart';

import '../../feature/app/data/entity/app_core.dart';
import '../../feature/app/widget/app_core_scope.dart';
import '../storage/repository_storage.dart';
import '../widget/repository_scope.dart';

extension BuildContextX on BuildContext {
  IAppCore get appCore => AppCoreScope.of(this);

  IRepositoryStorage get repoStorage => RepositoryScope.of(this);
}
