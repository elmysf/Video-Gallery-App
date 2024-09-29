//
//  VideoContract.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import Foundation

public struct VideoContract: BaseNetwork {
    public init () { }
    public var endpoint: String {
        BaseUrlConstants.listVideo
     }
    public var type: String{
         HTTPMethodType.get.rawValue
     }
 }