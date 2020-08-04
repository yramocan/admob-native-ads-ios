import GoogleMobileAds

protocol AdLoaderDelegate: AnyObject {
    func didLoadNativeAd(nativeAd: GADUnifiedNativeAd)
}

final class AdLoader: NSObject {
    let adLoader: GADAdLoader
    
    weak var delegate: AdLoaderDelegate?
    
    override init() {
        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
        multipleAdsOptions.numberOfAds = 5
        
        adLoader = GADAdLoader(
            adUnitID: "ca-app-pub-3940256099942544/3986624511",
            rootViewController: UIApplication.shared.windows.first?.rootViewController,
            adTypes: [.unifiedNative],
            options: [multipleAdsOptions]
        )
        
        super.init()
        
        adLoader.delegate = self
    }
    
    func loadAds() {
        DispatchQueue(label: "com.yuriramocan.admob", qos: .background).async { [weak self] in
            self?.adLoader.load(GADRequest())
        }
    }
}

extension AdLoader: GADAdLoaderDelegate, GADUnifiedNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print(error.localizedDescription)
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didLoadNativeAd(nativeAd: nativeAd)
        }
    }
}
