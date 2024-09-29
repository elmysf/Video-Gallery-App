//
//  DeletedContract.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct DeletedContract: BaseNetwork {
    public init () { }
    public var endpoint: String {
        BaseUrlConstants.deleteVideo
     }
    public var type: String{
         HTTPMethodType.delete.rawValue
     }
 }