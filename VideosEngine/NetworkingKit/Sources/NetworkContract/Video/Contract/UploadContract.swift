//
//  UploadContract.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct UploadContract: BaseNetwork {
    public init () { }
    public var endpoint: String {
        BaseUrlConstants.uploadVideo
     }
    public var type: String{
         HTTPMethodType.post.rawValue
     }
 }