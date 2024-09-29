//
//  AllVideoDataService.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Combine
import SwiftUI

public final class AllVideoDataService {
    public init() {}
    
    let allVideo = VideoContract()
    
    public func getAllVideo() -> AnyPublisher<AllVideoResponse, Error> {
        let url = URL(string: allVideo.endpoint)
        var request = URLRequest(url: url!)
        request.httpMethod = allVideo.type
        UserManager.setHeaders(for: &request)
        return NetworkingManager
            .get(for: request)
    }
}