//
//  RegistrationViewController.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 26.08.2021.
//

import UIKit
import WebKit

class RegistrationViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: AuthManager.shared.authURL))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let fragment = webView.url?.fragment {
            let equalSignPosition = fragment.index(fragment.startIndex, offsetBy: 13)
            let andSignPosition = fragment.index(before: fragment.firstIndex(of: "&")!)
            
            let accessToken = fragment[equalSignPosition...andSignPosition]
            UserDefaults.standard.set(accessToken, forKey: "access_token")
            print(UserDefaults.standard.string(forKey: "access_token"))
        }
    }
}
