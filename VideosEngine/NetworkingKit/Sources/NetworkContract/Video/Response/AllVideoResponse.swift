//
//  AllVideoResponse.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct AllVideoResponse: Codable {
    public let resources: [Resource]
    public let nextCursor: String?

    enum CodingKeys: String, CodingKey {
        case resources
        case nextCursor = "next_cursor"
    }
}

public struct Resource: Codable {
    public let assetID: String
    public let publicID: String
    public let format: String
    public let version: Int
    public let resourceType: String
    public let type: String
    public let createdAt: String
    public let bytes: Int
    public let width: Int
    public let height: Int
    public let assetFolder: String?
    public let displayName: String
    public let url: String
    public let secureUrl: String

    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case publicID = "public_id"
        case format
        case version
        case resourceType = "resource_type"
        case type
        case createdAt = "created_at"
        case bytes
        case width
        case height
        case assetFolder = "asset_folder"
        case displayName = "display_name"
        case url
        case secureUrl = "secure_url"
    }
}

