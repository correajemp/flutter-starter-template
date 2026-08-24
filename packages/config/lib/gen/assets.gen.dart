// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/.gitkeep
  String get aGitkeep =>
      'packages/flutter_starter_template/assets/animations/.gitkeep';

  /// List of all assets
  List<String> get values => [aGitkeep];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/.gitkeep
  String get aGitkeep =>
      'packages/flutter_starter_template/assets/fonts/.gitkeep';

  /// List of all assets
  List<String> get values => [aGitkeep];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/.gitkeep
  String get aGitkeep =>
      'packages/flutter_starter_template/assets/icons/.gitkeep';

  /// List of all assets
  List<String> get values => [aGitkeep];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [appLogo];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en =>
      'packages/flutter_starter_template/assets/translations/en.json';

  /// File path: assets/translations/fil.json
  String get fil =>
      'packages/flutter_starter_template/assets/translations/fil.json';

  /// List of all assets
  List<String> get values => [en, fil];
}

class $AssetsVideosGen {
  const $AssetsVideosGen();

  /// File path: assets/videos/.gitkeep
  String get aGitkeep =>
      'packages/flutter_starter_template/assets/videos/.gitkeep';

  /// List of all assets
  List<String> get values => [aGitkeep];
}

abstract final class Assets {
  static const String package = 'flutter_starter_template';

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
  static const $AssetsVideosGen videos = $AssetsVideosGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  static const String package = 'flutter_starter_template';

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => 'packages/flutter_starter_template/$_assetName';
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
