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
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: AuthManager.shared.authURL))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let fragment = webView.url?.fragment {
            let components = fragment.components(separatedBy: "&")
            
            let accessTokenString = components[0]
            let positionAfterEqualSign = accessTokenString.index(after: accessTokenString.firstIndex(of: "=")!)
            let accessToken = accessTokenString.suffix(from: positionAfterEqualSign)
            
            let expirationDate = Date(timeIntervalSinceNow: 86400)
            
            AuthManager.shared.accessToken = String(accessToken)
            
            UserDefaults.standard.set(accessToken, forKey: "access_token")
            UserDefaults.standard.set(expirationDate, forKey: "expires_in")
            
            self.navigationController?.pushViewController(MainTabBarController(), animated: true)
            self.navigationController?.viewControllers.removeFirst()
        }
    }
}
