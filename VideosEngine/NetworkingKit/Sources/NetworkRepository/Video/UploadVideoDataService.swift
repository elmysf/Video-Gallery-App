//
//  UploadVideoDataService.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Combine
import Foundation

public final class UploadVideoDataService {
    public init() {}
    
    private let uploadVideo = UploadContract()

    public func postVideo(videoURL: URL, uploadPreset: String, publicID: String) -> AnyPublisher<UploadVideoResponse, Error> {
        let url = URL(string: uploadVideo.endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = uploadVideo.type
        let boundary = "Boundary-\(UUID().uuidString)"
        
        guard FileManager.default.fileExists(atPath: videoURL.path) else {
            print("File does not exist at path: \(videoURL.path)")
            return Fail(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "File does not exist."])).eraseToAnyPublisher()
        }
        
        do {
            let videoData = try Data(contentsOf: videoURL)
            print("Video data loaded successfully, size: \(videoData.count) bytes")
            
            let mimeType: String
            switch videoURL.pathExtension.lowercased() {
            case "mov":
                mimeType = "video/quicktime"
            case "mp4":
                mimeType = "video/mp4"
            default:
                mimeType = "application/octet-stream"
            }
            
            var bodyData = Data()
            bodyData += "--\(boundary)\r\n".data(using: .utf8)!
            bodyData += "Content-Disposition: form-data; name=\"file\"; filename=\"\(videoURL.lastPathComponent)\"\r\n".data(using: .utf8)!
            bodyData += "Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!
            bodyData += videoData
            bodyData += "\r\n".data(using: .utf8)!
            
            bodyData += "--\(boundary)\r\n".data(using: .utf8)!
            bodyData += "Content-Disposition: form-data; name=\"upload_preset\"\r\n\r\n".data(using: .utf8)!
            bodyData += "\(uploadPreset)\r\n".data(using: .utf8)!
            
            bodyData += "--\(boundary)\r\n".data(using: .utf8)!
            bodyData += "Content-Disposition: form-data; name=\"public_id\"\r\n\r\n".data(using: .utf8)!
            bodyData += "\(publicID)\r\n".data(using: .utf8)!
            bodyData += "--\(boundary)--\r\n".data(using: .utf8)!
            
            if let bodyString = String(data: bodyData, encoding: .utf8) {
                print("Request Body:\n\(bodyString)")
            }
            
            request.httpBody = bodyData
            UserManager.setHeaders(for: &request)
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            return NetworkingManager.get(for: request)
            
        } catch {
            print("Error loading video data: \(error.localizedDescription)")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}