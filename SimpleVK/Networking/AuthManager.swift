//
//  AuthManager.swift
//  SimpleVK
//
//  Created by Andrey Rusinovich on 26.08.2021.
//

import Foundation
import Alamofire

class AuthManager {
    static let shared = AuthManager()
    
    var accessToken: String?
    
    private var appId: String
    private var redirectUri: String
    private (set) var authURL: URL
    
    init() {
        appId = "7935997"
        redirectUri = "https://oauth.vk.com/blank.html"
        authURL = URL(string: "https://oauth.vk.com/authorize?client_id=\(appId)&redirect_uri=\(redirectUri)&scope=friends&response_type=token&v=5.52")!
    }
    
    func loadToken() -> String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
}
