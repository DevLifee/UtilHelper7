//
//  File.swift
//  
//
//  Created by DanHa on 30/03/2023.
//

import Foundation

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct SevenCoor: UIViewRepresentable {
    func makeCoordinator() -> SevenCoordiClss {
        SevenCoordiClss(self)
    }

    let url: URL?
    @Binding var nextScreenSeven: Bool
    var listData: [String: String] = [:]
    
    private let sevenos = SevenObs()
    var sevenobserver: NSKeyValueObservation? {
        sevenos.sevenins
    }

    // end check url

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true // true

        let source: String = listData[RemoKey.rm01ch.rawValue] ?? ""
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let userContentController: WKUserContentController = WKUserContentController()

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.userContentController = userContentController
        userContentController.addUserScript(script)

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = listData[RemoKey.rm02ch.rawValue] ?? ""
        webview.scrollView.isScrollEnabled = true

        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))

        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        sevenos.sevenins = uiView.observe(\WKWebView.url, options: .new) { view, _ in
            let url = view.url
            if let urlv = URL(string: "\(String(describing: url))") {
                if urlv.absoluteString.range(of: listData[RemoKey.seven2af.rawValue] ?? "") != nil {
                    self.nextScreenSeven = true
                } // if webView
            } // urlv
        } // observable
    } // updateUIView

    class SevenCoordiClss: NSObject, WKNavigationDelegate {
        var prentSeven: SevenCoor
        init(_ prentSeven: SevenCoor) {
            self.prentSeven = prentSeven
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        } // didStartProvisionalNavigation

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                decisionHandler(WKNavigationActionPolicy.cancel)
                return
            }
            decisionHandler(WKNavigationActionPolicy.allow)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(self.prentSeven.listData[RemoKey.seven1af.rawValue] ?? "", completionHandler: { _, _ in })
            if webView.url?.absoluteString.range(of: self.prentSeven.listData[RemoKey.seven2af.rawValue] ?? "") != nil {
                self.prentSeven.nextScreenSeven = true
            }
        } // didFinish
    } // Coordinator
}

@available(iOS 14.0, *)
private class SevenObs: ObservableObject {
    @Published var sevenins: NSKeyValueObservation?
}
