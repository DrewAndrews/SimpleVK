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
        authURL = URL(string: "https://oauth.vk.com/authorize?client_id=\(appId)&redirect_uri=\(redirectUri)&scope=friends,wall,photos,groups&response_type=token&v=5.51")!
    }
    
    func loadToken() -> String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    func removeToken() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "expires_in")
        accessToken = nil
    }
    
    func tokenIsValid() -> Bool {
        let today = Date()
        let expirationDate = UserDefaults.standard.object(forKey: "expires_in") as! Date
        if today.distance(to: expirationDate) < 0 {
            return false
        }
        return true
    }
}
