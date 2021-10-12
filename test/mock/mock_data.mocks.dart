// Mocks generated by Mockito 5.0.15 from annotations
// in flutter_survey/test/mock/mock_data.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:flutter_survey/api/exception/network_exceptions.dart' as _i4;
import 'package:flutter_survey/api/repository/oauth_repository.dart' as _i5;
import 'package:flutter_survey/models/oauth_token.dart' as _i2;
import 'package:flutter_survey/usecase/base/base_use_case.dart' as _i3;
import 'package:flutter_survey/usecase/login_use_case.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeOAuthToken_0 extends _i1.Fake implements _i2.OAuthToken {}

class _FakeResult_1<T> extends _i1.Fake implements _i3.Result<T> {}

class _FakeNetworkExceptions_2 extends _i1.Fake
    implements _i4.NetworkExceptions {}

/// A class which mocks [OAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOAuthRepository extends _i1.Mock implements _i5.OAuthRepository {
  MockOAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.OAuthToken> login({String? email, String? password}) => (super
      .noSuchMethod(
          Invocation.method(#login, [], {#email: email, #password: password}),
          returnValue: Future<_i2.OAuthToken>.value(_FakeOAuthToken_0())) as _i6
      .Future<_i2.OAuthToken>);

  @override
  String toString() => super.toString();
}

/// A class which mocks [LoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUseCase extends _i1.Mock implements _i7.LoginUseCase {
  MockLoginUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.Result<void>> call(_i7.LoginInput? input) =>
      (super.noSuchMethod(Invocation.method(#call, [input]),
              returnValue:
                  Future<_i3.Result<void>>.value(_FakeResult_1<void>()))
          as _i6.Future<_i3.Result<void>>);

  @override
  String toString() => super.toString();
}

/// A class which mocks [UseCaseException].
///
/// See the documentation for Mockito's code generation for more information.
class MockUseCaseException extends _i1.Mock implements _i3.UseCaseException {
  MockUseCaseException() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.NetworkExceptions get networkExceptions =>
      (super.noSuchMethod(Invocation.getter(#networkExceptions),
          returnValue: _FakeNetworkExceptions_2()) as _i4.NetworkExceptions);

  @override
  String toString() => super.toString();
}