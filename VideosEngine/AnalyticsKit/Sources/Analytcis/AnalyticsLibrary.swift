//
//  AnalyticsLibrary.swift
//  VideoEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//

public protocol AnalyticsLibrary {
    func logEvent(_ name: String, value: String)
}
