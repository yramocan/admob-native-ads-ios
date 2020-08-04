import GoogleMobileAds
import SwiftUI

struct NativeAdView: UIViewRepresentable {
    let nativeAd: GADUnifiedNativeAd
    
    func makeUIView(context: Context) -> some GADUnifiedNativeAdView {
        let nibView = Bundle.main.loadNibNamed("UIKitNativeAdView", owner: nil, options: nil)?.first
        
        guard let nativeAdView = nibView as? GADUnifiedNativeAdView else {
            return GADUnifiedNativeAdView()
        }

        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil
        
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        
        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil
        
        nativeAdView.nativeAd = nativeAd
        
        return nativeAdView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        return
    }
}
