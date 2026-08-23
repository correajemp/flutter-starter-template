import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/extensions/theme.dart';
import 'package:flutter_starter_template/shared/widgets/app_shimmer.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final Color? color;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final String? cacheKey;
  final Map<String, String>? httpHeaders;
  final bool useOldImageOnUrlChange;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final FilterQuality filterQuality;
  final ImageWidgetBuilder? imageBuilder;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final BlendMode? colorBlendMode;

  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.cacheKey,
    this.httpHeaders,
    this.useOldImageOnUrlChange = false,
    this.fadeOutDuration,
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.filterQuality = FilterQuality.low,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final bool isValid =
        imageUrl != null &&
        imageUrl!.isNotEmpty &&
        (Uri.tryParse(imageUrl!)?.host.isNotEmpty ?? false);

    if (!isValid) {
      if (errorWidget != null) {
        return errorWidget!(context, imageUrl ?? '', Exception('Invalid or null image URL'));
      }
      return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        color: context.colors.surfaceContainer,
        child: Icon(
          Icons.broken_image,
          color: context.colors.onPrimary,
          size: (width != null && height != null) ? (width! < 40 || height! < 40 ? 18 : 24) : 24,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
      colorBlendMode: colorBlendMode,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      cacheKey: cacheKey,
      httpHeaders: httpHeaders,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      fadeOutDuration: fadeOutDuration,
      fadeOutCurve: fadeOutCurve,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      filterQuality: filterQuality,
      imageBuilder: imageBuilder,
      placeholder:
          placeholder ??
          (context, url) =>
              AppShimmer(width: width ?? double.infinity, height: height ?? double.infinity),
      progressIndicatorBuilder: progressIndicatorBuilder,
      errorWidget:
          errorWidget ??
          (context, url, error) => Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            color: context.colors.surfaceContainer,
            child: Icon(
              Icons.broken_image,
              color: context.colors.onPrimary,
              size: (width != null && height != null)
                  ? (width! < 40 || height! < 40 ? 18 : 24)
                  : 24,
            ),
          ),
    );
  }
}
