import 'dart:ui';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/components/main_appbar_basic.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/loading_placeholder.dart';
import 'package:aewallet/util/device_info.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
sealed class WebBrowserAvailability {
  const WebBrowserAvailability();
}

class WebBrowserAvailable extends WebBrowserAvailability {
  const WebBrowserAvailable();
}

class WebBrowserUnavailable extends WebBrowserAvailability {
  const WebBrowserUnavailable({required this.cause, this.details});

  static const unsupportedAndroidVersion =
      WebBrowserUnavailable(cause: 'unsupported_android_version');
  final String cause;
  final Object? details;
}

class WebBrowser extends ConsumerStatefulWidget {
  const WebBrowser({
    super.key,
    required this.uri,
    this.onLoadStop,
    required this.unavailableBuilder,
    this.checkAvailability,
  });

  final Uri uri;
  final void Function(
    InAppWebViewController controller,
    WebUri? url,
  )? onLoadStop;
  final Widget Function(WebBrowserUnavailable cause) unavailableBuilder;

  final Future<WebBrowserAvailability> Function()? checkAvailability;

  static WebBrowserAvailability get isPlatformSupported {
    if (!UniversalPlatform.isMobile) return const WebBrowserAvailable();

    final deviceInfo = DeviceInfo.state;

    return deviceInfo.maybeMap(
      orElse: () => const WebBrowserAvailable(),
      android: (androidInfo) => androidInfo.version >= 29
          ? const WebBrowserAvailable()
          : WebBrowserUnavailable.unsupportedAndroidVersion,
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebBrowserState();
}

class _WebBrowserState extends ConsumerState<WebBrowser> {
  InAppWebViewController? controller;
  bool _loaded = false;

  bool _canGoBack = false;
  bool _canGoForward = false;

  WebBrowserAvailability? _availability;

  @override
  void initState() {
    _checkAvailability().then(
      (value) {
        setState(
          () {
            _availability = value;

            if (value case WebBrowserUnavailable()) {
              _loaded = true;
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return PopScope(
      // System "back" action navigates back if possible
      canPop: !_canGoBack,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller?.goBack();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: WebBrowserAppBar(
          onClose: context.pop,
          onRefresh: () => controller?.reload(),
          title: localizations.onrampWithBanxaTitle,
        ),
        body: Column(
          children: [
            Expanded(
              child: LoadingPlaceholder(
                loaded: _loaded,
                child: switch (_availability) {
                  null => const SizedBox(),
                  final WebBrowserUnavailable unavailable =>
                    widget.unavailableBuilder(unavailable),
                  _ => InAppWebView(
                      initialSettings: InAppWebViewSettings(
                        disableHorizontalScroll: true,
                      ),
                      onPageCommitVisible: (controller, url) {
                        setState(() {
                          _loaded = true;
                        });
                      },
                      onWebViewCreated: (controller) async {
                        setState(() {
                          this.controller = controller;
                        });
                        await controller.loadUrl(
                          urlRequest: URLRequest(
                            url: WebUri.uri(widget.uri),
                          ),
                        );
                      },
                      onUpdateVisitedHistory: (controller, url, isReload) {
                        _updateNavigation(controller);
                      },
                      onDownloadStarting:
                          (controller, downloadStartRequest) async {
                        final uri = downloadStartRequest.url.uriValue;
                        if (!await canLaunchUrl(uri)) return null;

                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                        return DownloadStartResponse(handled: true);
                      },
                      onLoadStop: widget.onLoadStop,
                    )
                },
              ),
            ),
            WebBrowserNavigationButtons(
              goForward: _canGoForward ? controller?.goForward : null,
              goBack: _canGoBack ? controller?.goBack : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateNavigation(InAppWebViewController controller) async {
    final canGoBack = await controller.canGoBack();
    final canGoForward = await controller.canGoForward();
    setState(
      () {
        _canGoBack = canGoBack;
        _canGoForward = canGoForward;
      },
    );
  }

  Future<WebBrowserAvailability> _checkAvailability() async {
    if (WebBrowser.isPlatformSupported case final WebBrowserUnavailable cause) {
      return cause;
    }

    if (await widget.checkAvailability?.call()
        case final WebBrowserUnavailable cause) {
      return cause;
    }

    return const WebBrowserAvailable();
  }
}

class WebBrowserNavigationButtons extends StatelessWidget {
  const WebBrowserNavigationButtons({
    super.key,
    this.goForward,
    this.goBack,
  });

  factory WebBrowserNavigationButtons.backOnly({
    Key? key,
    VoidCallback? goBack,
  }) =>
      WebBrowserNavigationButtons(key: key, goBack: goBack);

  final VoidCallback? goForward;
  final VoidCallback? goBack;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 24,
          ),
          child: IconButton(
            onPressed: goBack,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 24,
          ),
          child: IconButton(
            onPressed: goForward,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}

class WebBrowserAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const WebBrowserAppBar({
    super.key,
    required this.title,
    required this.onClose,
    required this.onRefresh,
  });

  final String title;
  final VoidCallback onClose;
  final VoidCallback onRefresh;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return AppBar(
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      systemOverlayStyle: ArchethicTheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      leading: CloseButton(
        key: const Key('close'),
        color: ArchethicTheme.text,
        onPressed: onClose,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            aedappfm.Iconsax.refresh,
            size: 16,
            color: Colors.white,
          ),
          onPressed: onRefresh,
        ),
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected)
          const IconNetworkWarning(),
      ],
      title: Column(
        children: [
          MainAppBarBasic(
            header: title,
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ArchethicTheme.text),
    );
  }
}
