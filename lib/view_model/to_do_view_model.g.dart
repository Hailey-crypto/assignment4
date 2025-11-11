// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ToDoViewModel)
const toDoViewModelProvider = ToDoViewModelProvider._();

final class ToDoViewModelProvider
    extends $NotifierProvider<ToDoViewModel, List<ToDoModel>> {
  const ToDoViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toDoViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toDoViewModelHash();

  @$internal
  @override
  ToDoViewModel create() => ToDoViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ToDoModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ToDoModel>>(value),
    );
  }
}

String _$toDoViewModelHash() => r'246bc3ef2f411626d12362ae3de7e441d623d0b7';

abstract class _$ToDoViewModel extends $Notifier<List<ToDoModel>> {
  List<ToDoModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<ToDoModel>, List<ToDoModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ToDoModel>, List<ToDoModel>>,
              List<ToDoModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
