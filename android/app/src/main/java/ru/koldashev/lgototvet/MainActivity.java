package ru.koldashev.lgototvet;

import ru.koldashev.lgototvet.R;
import io.flutter.embedding.android.FlutterActivity;
import com.yandex.mobile.ads.common.InitializationListener;
import com.yandex.mobile.ads.common.MobileAds;
import com.yandex.mobile.ads.banner.AdSize;
import com.yandex.mobile.ads.banner.BannerAdEventListener;
import com.yandex.mobile.ads.banner.BannerAdView;
import com.yandex.mobile.ads.common.AdRequest;
import com.yandex.mobile.ads.common.AdRequestError;
import com.yandex.mobile.ads.common.ImpressionData;
import com.yandex.mobile.ads.interstitial.InterstitialAd;
import com.yandex.mobile.ads.interstitial.InterstitialAdEventListener;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;
import android.widget.LinearLayout;
import android.widget.FrameLayout;
import android.util.DisplayMetrics;
import android.view.*;
import android.content.Context;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {
    private static final String YANDEX_MOBILE_ADS_TAG = "YandexMobileAds";
    private InterstitialAd mInterstitialAd;
    private BannerAdView mBannerAdView;
    private View layout;

    private String CHANNEL = "ru.koldashev.lgototvet/ads";
    public final AdRequest adRequest = new AdRequest.Builder().build();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("showInterstitial")) {
                        mInterstitialAd.loadAd(adRequest);
                    }
                    if (call.method.equals("showBanner")) {
                        mBannerAdView.loadAd(adRequest);
                        layout.setVisibility(View.VISIBLE);
                    }
                    if (call.method.equals("hideBanner")) {
                        layout.setVisibility(View.GONE);
                    }

                });
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        LayoutInflater inflater = getLayoutInflater();
        layout = inflater.inflate(R.layout.banner_layout, (ViewGroup) ((ViewGroup) this.findViewById(android.R.id.content)).getChildAt(0));
        BannerAdView adView = (BannerAdView) findViewById(R.id.banner_ad_view);
        adView.invalidate();
        mBannerAdView = adView;
        mBannerAdView.setBlockId("R-M-989895-2");
        mBannerAdView.setAdSize(AdSize.BANNER_320x50);

        mInterstitialAd = new InterstitialAd(this);
        mInterstitialAd.setBlockId("R-M-989895-1");

        mInterstitialAd.setInterstitialAdEventListener(new InterstitialAdEventListener() {
            @Override
            public void onAdLoaded() {
                mInterstitialAd.show();
            };
            @Override
            public void onAdFailedToLoad(AdRequestError adRequestError) {
            }

            @Override
            public void onAdShown() {
            }

            @Override
            public void onAdDismissed() {
            }

            @Override
            public void onLeftApplication() {
            }

            @Override
            public void onReturnedToApplication() {
            }
        });
        mBannerAdView.setBannerAdEventListener(new BannerAdEventListener() {
            @Override
            public void onAdLoaded() {
            }

            @Override
            public void onAdFailedToLoad(@NonNull final AdRequestError error) {
            }

            @Override
            public void onLeftApplication() {
            }

            @Override
            public void onReturnedToApplication() {
            }
        });

        MobileAds.initialize(this, () -> {
        });
    }
}