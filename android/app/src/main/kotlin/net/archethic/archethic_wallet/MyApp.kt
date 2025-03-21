package net.archethic.archethic_wallet

import android.app.Application
import io.maido.intercom.IntercomFlutterPlugin
import net.archethic.archethic_wallet.BuildConfig

class MyApp : Application() {
  override fun onCreate() {
    super.onCreate()

    // Value from dart-define values (see build.gradle)
    val appId = BuildConfig.INTERCOM_APP_ID
    val androidApiKey = BuildConfig.INTERCOM_ANDROID_KEY

    // Initialize the Intercom SDK here also as Android requires to initialize it in the onCreate of
    // the application.
    if (appId.isNotEmpty() && androidApiKey.isNotEmpty()) {
      IntercomFlutterPlugin.initSdk(this, appId = appId, androidApiKey = androidApiKey)
    }
  }
}