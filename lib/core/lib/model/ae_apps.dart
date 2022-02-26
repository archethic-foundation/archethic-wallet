enum AEApps { aeweb, aemail, aewallet, bin }

/// Represent the available authentication methods our app supports
class AEAppsUtil {
  AEApps? aeApp;

  AEAppsUtil(this.aeApp);

  String getDisplayName() {
    switch (aeApp) {
      case AEApps.aemail:
        return 'AEMail';
      case AEApps.aewallet:
        return 'AEWallet';
      case AEApps.aeweb:
        return 'AEWeb';
      case AEApps.bin:
        return 'Bin';
      default:
        return '';
    }
  }
}
