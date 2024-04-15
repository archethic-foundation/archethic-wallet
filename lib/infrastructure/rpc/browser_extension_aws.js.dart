@JS('chrome')
library aws; // library name can be whatever you want

import 'package:js/js.dart';

@JS('runtime.connect')
external BrowserExtensionPort connect();

@JS('runtime.sendMessage')
external void sendMessage(dynamic message);

@JS('runtime.onMessage')
external BrowserExtensionEvent<
    void Function(
      dynamic message,
      BrowserExtensionMessageSender sender,
      Function(dynamic) sendResponse,
    )> get onMessage;

@JS('runtime.onMessageExternal')
external BrowserExtensionEvent<
    void Function(
      dynamic message,
      BrowserExtensionMessageSender sender,
      Function(dynamic) sendResponse,
    )> get onMessageExternal;

@JS('runtime.onConnectExternal')
external BrowserExtensionEvent<void Function(BrowserExtensionPort port)>
    get onConnectExternal;

@JS('extension')
external dynamic get browserExtension;

@JS('windows.update')
external void updateWindow(int windowId, dynamic updateInfo);

@JS('windows.WINDOW_ID_CURRENT')
external int get windowIdCurrent;

bool get isWebBrowserExtension => browserExtension != null;

/**
 * https://developer.chrome.com/docs/extensions/reference/api/runtime?type-Port#type-Port
 */
@JS('runtime.Port')
class BrowserExtensionPort {
  @JS('onMessage')
  external BrowserExtensionEvent<
      void Function(dynamic message, BrowserExtensionPort port)> get onMessage;

  @JS('onDisconnect')
  external BrowserExtensionEvent<void Function(BrowserExtensionPort port)>
      get onDisconnect;

  @JS('disconnect')
  external disconnect();

  @JS('postMessage')
  external postMessage(dynamic message);
}

/**
 * https://developer.chrome.com/docs/extensions/reference/api/events?type-Event#type-Event
 */
@JS()
class BrowserExtensionEvent<H extends Function> {
  @JS('addListener')
  external addListener(
    H callback,
  );

  @JS('removeListener')
  external removeListener(
    H callback,
  );
}

/**
 * https://developer.chrome.com/docs/extensions/reference/api/runtime?type-MessageSender#type-MessageSender
 */
@JS()
class BrowserExtensionMessageSender {
  @JS('origin')
  external String? get origin;

  @JS('tab')
  external BrowserExtensionTab? get tab;
}

/**
 * https://developer.chrome.com/docs/extensions/reference/api/tabs#type-Tab
 */
@JS()
class BrowserExtensionTab {
  @JS('id')
  external int? get id;
}
