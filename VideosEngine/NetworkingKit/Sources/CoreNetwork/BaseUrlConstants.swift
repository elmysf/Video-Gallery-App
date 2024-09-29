//
//  BaseUrlConstants.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct BaseUrlConstants {
    public init() {}
    
    public static let baseURL: String = "https://api.cloudinary.com/v1_1/dk3lhojel/"
    public static let listVideo: String = baseURL + "resources/video"
    public static let uploadVideo: String = baseURL + "video/upload"
    public static let deleteVideo: String = baseURL + "resources/video/upload"
}
