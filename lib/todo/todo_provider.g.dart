// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoStateHash() => r'09044d6ede9de30c650c5a8d35c2a09ba6ef0005';

/// See also [TodoState].
@ProviderFor(TodoState)
final todoStateProvider =
    AutoDisposeNotifierProvider<TodoState, List<Task>>.internal(
  TodoState.new,
  name: r'todoStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoState = AutoDisposeNotifier<List<Task>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions