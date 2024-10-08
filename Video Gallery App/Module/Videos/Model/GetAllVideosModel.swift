//
//  GetAllVideosModel.swift
//  Video Gallery App
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation
import AVFoundation

struct GetAllVideosModel: Identifiable {
    var id: String { publicID }
    var uploadDate: String
    let publicID: String
    let displayName: String
    let videoURLString: String
    
    var url: AVPlayer? {
        guard let url = URL(string: videoURLString) else { return nil }
        return AVPlayer(url: url)
    }
    
    var isNew: Bool {
        let dateFormatter = ISO8601DateFormatter()
        guard let uploadDate = dateFormatter.date(from: uploadDate) else {
            return false
        }
        let currentDate = Date()
        return uploadDate >= currentDate.addingTimeInterval(-2 * 60)
    }
}
