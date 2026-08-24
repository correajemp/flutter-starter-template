import 'dart:io';

import 'package:core/api/failures.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/extensions/string.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' hide generateNonce;

class AuthApi {
  const AuthApi();

  Future<Either<ApiFailure, UserCredential>> signInWithFacebook() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final result = await FacebookAuth.instance.login(
        loginTracking: Platform.isIOS ? LoginTracking.limited : LoginTracking.enabled,
        nonce: nonce,
      );
      if (result.status == LoginStatus.cancelled) {
        return const Left(UnknownFailure('Facebook sign-in cancelled by user.'));
      }
      if (result.status != LoginStatus.success) {
        return Left(UnknownFailure(result.message ?? 'Facebook sign-in failed. Please try again.'));
      }
      AuthCredential credential;
      if (Platform.isIOS) {
        final iosToken = result.accessToken;
        final idTokenString = iosToken?.tokenString;
        if (idTokenString == null) {
          return const Left(UnknownFailure('Failed to retrieve Facebook ID Token on iOS.'));
        }
        credential = OAuthProvider('facebook.com')
            .credential(idToken: idTokenString, rawNonce: rawNonce);
      } else {
        final androidToken = result.accessToken;
        if (androidToken == null) {
          return const Left(UnknownFailure('Failed to retrieve Facebook Access Token.'));
        }
        credential = FacebookAuthProvider.credential(androidToken.tokenString);
      }
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(UnknownFailure(e.message ?? 'Firebase rejected the Facebook credential.'));
    } catch (e) {
      return Left(UnknownFailure('Facebook sign-in is unavailable on this build.\n$e'));
    }
  }

  Future<Either<ApiFailure, UserCredential>> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        clientId: Platform.isIOS ? AppConstants.secretKeys.googleIosClientId : null,
        serverClientId: AppConstants.secretKeys.googleServerClientId,
      );
      final googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final authorization = await googleUser.authorizationClient.authorizeScopes([
        'email',
        'profile',
      ]);
      final credential = GoogleAuthProvider.credential(
        accessToken: authorization.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return Right(userCredential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return const Left(UnknownFailure('Google sign-in cancelled by user.'));
      }
      return Left(UnknownFailure(e.description ?? 'Google sign-in failed. Please try again.'));
    } on FirebaseAuthException catch (e) {
      return Left(UnknownFailure(e.message ?? 'Firebase rejected the Google credential.'));
    } catch (e) {
      return Left(UnknownFailure('Google sign-in is unavailable on this build.\n$e'));
    }
  }

  Future<Either<ApiFailure, UserCredential>> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );
      final oauthCredential = OAuthProvider('apple.com')
          .credential(idToken: credential.identityToken, accessToken: credential.authorizationCode);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(UnknownFailure(e.message ?? 'Firebase rejected the Apple credential.'));
    } catch (e) {
      return Left(UnknownFailure('Apple sign-in is unavailable on this build.\n$e'));
    }
  }

  Future<Either<ApiFailure, UserCredential>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(UnknownFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return const Left(UnknownFailure('The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        return const Left(UnknownFailure('The email address is not valid.'));
      }
      return Left(UnknownFailure(e.message ?? 'Sign up failed. Please try again.'));
    } catch (e) {
      return Left(UnknownFailure('Sign up is unavailable on this build.\n$e'));
    }
  }

  Future<Either<ApiFailure, UserCredential>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        return const Left(UnknownFailure('Invalid email or password.'));
      } else if (e.code == 'wrong-password') {
        return const Left(UnknownFailure('Invalid email or password.'));
      } else if (e.code == 'invalid-email') {
        return const Left(UnknownFailure('The email address is not valid.'));
      }
      return Left(UnknownFailure(e.message ?? 'Sign in failed. Please try again.'));
    } catch (e) {
      return Left(UnknownFailure('Sign in is unavailable on this build.\n$e'));
    }
  }

  Future<Either<ApiFailure, bool>> verifyUsername(String username) async {
    try {
      return const Right(true);
    } catch (e) {
      return Left(UnknownFailure('Failed to verify username.\n$e'));
    }
  }

  Future<Either<ApiFailure, bool>> verifyEmailCode(String code) async {
    try {
      if (code.trim().length != 6) {
        return const Left(UnknownFailure('Please enter a valid 6-digit verification code.'));
      }
      await Future<void>.delayed(const Duration(milliseconds: 800));
      return const Right(true);
    } catch (e) {
      return Left(UnknownFailure('Failed to verify email code.\n$e'));
    }
  }

  Future<void> signOut() async {
    try {
      await FacebookAuth.instance.logOut();
      await GoogleSignIn.instance.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
  }

  Future<void> delete() async {
    try {
      await FacebookAuth.instance.logOut();
      await GoogleSignIn.instance.signOut();
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (_) {}
  }
}

final authApiProvider = Provider<AuthApi>((ref) => const AuthApi());
