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
    
    private static var apiKey: String {
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API_KEY environment variable is not set")
        }
        return key
    }
    
    private static var apiSecret: String {
        guard let secret = ProcessInfo.processInfo.environment["API_SECRET"] else {
            fatalError("API_SECRET environment variable is not set")
        }
        return secret
    }
    
    public static func setHeaders(for request: inout URLRequest) {
            let credentials = "\(apiKey):\(apiSecret)"
            guard let credentialsData = credentials.data(using: .utf8) else {
                fatalError("Failed to encode credentials")
            }
            let base64Credentials = credentialsData.base64EncodedString()
            request.addValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        }
}
