//
//  UserManager.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation
import UIKit

public final class UserManager {
    public init() {}
    
    @MainActor static let userManager = UserManager()
    
    public static func setHeaders(for request: inout URLRequest) {
        let credentials = "\(getApiKey()):\(getApiSecret())"
        guard let credentialsData = credentials.data(using: .utf8) else {
            fatalError("Failed to encode credentials")
        }
        let base64Credentials = credentialsData.base64EncodedString()
        request.addValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
    }
    
    public static func getApiKey() -> String {
        return "764292367668433"
    }
    
    public static func getApiSecret() -> String {
        return "7joFRwDGPx61FwsII7uEPqqamYE"
    }
}
