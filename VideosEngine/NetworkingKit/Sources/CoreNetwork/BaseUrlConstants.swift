//
//  BaseUrlConstants.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct BaseUrlConstants {
    public init() {}

    public static let cloudName: String = {
        guard let cloudName = ProcessInfo.processInfo.environment["CLOUD_NAME"] else {
            fatalError("CLOUD_NAME environment variable is not set")
        }
        return cloudName
    }()
    
    public static let baseURL: String = "https://api.cloudinary.com/v1_1/\(cloudName)/"
    public static let listVideo: String = baseURL + "resources/video"
    public static let uploadVideo: String = baseURL + "video/upload"
    public static let deletedVideo: String = baseURL + "resources/video/upload"
}