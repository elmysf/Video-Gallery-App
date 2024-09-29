//
//  DeleteDataService.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Combine
import SwiftUI

public final class DeleteDataService {
    public init() {}
    
    let deleteVideo = DeletedContract()
    
    public func deletedVideo(publicID: String) -> AnyPublisher<DeletedVideoResponse, Error> {
        let url = URL(string: deleteVideo.endpoint + "?public_ids=\(publicID)")
        var request = URLRequest(url: url!)
        request.httpMethod = deleteVideo.type
        UserManager.setHeaders(for: &request)
        return NetworkingManager
            .get(for: request)
    }
}