//
//  DeletedVideoResponse.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct DeletedVideoResponse: Codable {
    public let deleted: [String: String]?
    public let deletedCounts: [String: DeletedCount]?
    public let partial: Bool?

    enum CodingKeys: String, CodingKey {
        case deleted
        case deletedCounts = "deleted_counts"
        case partial
    }
}

public struct DeletedCount: Codable {
    public let original: Int?
    public let derived: Int?
}