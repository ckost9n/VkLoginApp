//
//  ViewController.swift
//  VkLoginApp
//
//  Created by Konstantin on 13.10.2021.
//

import UIKit
import WebKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        cleanWebViewCookies()    // Откл. автоматический вхов в веб форму
//        TestUrlSession.shared.getPost()
        loadVKAuth()
        
    }
    
    func loadVKAuth() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7553465"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
//        let urlPath = "https://oauth.vk.com/authorize"
//        let patameters: Parameters = [
//            "client_id": "7553465",
//            "display": "mobile",
//            "redirect_uri": "https://oauth.vk.com/blank.html",
//            "scope": "https://oauth.vk.com/blank.html",
//            "redirect_uri": "262150",
//            "response_type": "token",
//            "v": "5.68"
//        ]
//
//
//        let request1 = AF.request(urlPath, parameters: patameters)
    }

}

// MARK: - WKNavigationDelegate

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"] else { return }
        print(token)
        Session.shared.token = token
        performSegue(withIdentifier: "home", sender: nil)
        
        decisionHandler(.cancel)
    }
    
    
    // MARK: - CleanWebView
    
    func cleanWebViewCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default()
            .fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default()
                    .removeData(ofTypes: record.dataTypes,
                                for: [record],
                                completionHandler: {}
                )
            }
        }
    }

}
