import GoogleMobileAds
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.nativeAds, id: \.body) { nativeAd in
                        NativeAdView(nativeAd: nativeAd)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 400)
                            .background(Color.white)
                            .cornerRadius(4)
                            .shadow(color: Color.black.opacity((0.16)), radius: 4)
                    }
                }
                .padding(16)
            }
            .background(Color.black.opacity(0.05).ignoresSafeArea())
            .navigationBarTitle("Native Ads")
            .navigationBarItems(trailing:
                Button("Load") {
                    viewModel.loadAds()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published private(set) var nativeAds = [GADUnifiedNativeAd]()
        
        let adLoader = AdLoader()
        
        init() {
            adLoader.delegate = self
        }
        
        func loadAds() {
            adLoader.loadAds()
        }
    }
}

extension ContentView.ViewModel: AdLoaderDelegate {
    func didLoadNativeAd(nativeAd: GADUnifiedNativeAd) {
        nativeAds.append(nativeAd)
    }
}
