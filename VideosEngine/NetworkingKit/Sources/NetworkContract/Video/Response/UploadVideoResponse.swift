//
//  UploadVideoResponse.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct UploadVideoResponse: Codable {
    public let assetID: String?
    public let publicID: String?
    public let version: Int?
    public let versionID: String?
    public let signature: String?
    public let width: Int?
    public let height: Int?
    public let format: String?
    public let resourceType: String?
    public let createdAt: String?
    public let tags: [String]?
    public let pages: Int?
    public let bytes: Int?
    public let type: String?
    public let etag: String?
    public let placeholder: Bool?
    public let url: String?
    public let secureURL: String?
    public let playbackURL: String?
    public let assetFolder: String?
    public let displayName: String?
    public let existing: Bool?
    public let audio: AudioInfo?
    public let video: VideoInfo?
    public let isAudio: Bool?
    public let frameRate: Double?
    public let bitRate: Int?
    public let duration: Double?
    public let rotation: Int?
    public let originalFilename: String?
    public let nbFrames: Int?

    public enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case publicID = "public_id"
        case version
        case versionID = "version_id"
        case signature
        case width
        case height
        case format
        case resourceType = "resource_type"
        case createdAt = "created_at"
        case tags
        case pages
        case bytes
        case type
        case etag
        case placeholder
        case url
        case secureURL = "secure_url"
        case playbackURL = "playback_url"
        case assetFolder = "asset_folder"
        case displayName = "display_name"
        case existing
        case audio
        case video
        case isAudio = "is_audio"
        case frameRate = "frame_rate"
        case bitRate = "bit_rate"
        case duration
        case rotation
        case originalFilename = "original_filename"
        case nbFrames = "nb_frames"
    }
}

public struct AudioInfo: Codable {
    public let codec: String?
    public let bitRate: String?
    public let frequency: Int?
    public let channels: Int?
    public let channelLayout: String?

    public enum CodingKeys: String, CodingKey {
        case codec
        case bitRate = "bit_rate"
        case frequency
        case channels
        case channelLayout = "channel_layout"
    }
}

public struct VideoInfo: Codable {
    public let pixFormat: String?
    public let codec: String?
    public let level: Int?
    public let profile: String?
    public let bitRate: String?
    public let timeBase: String?

    public enum CodingKeys: String, CodingKey {
        case pixFormat = "pix_format"
        case codec
        case level
        case profile
        case bitRate = "bit_rate"
        case timeBase = "time_base"
    }
}
