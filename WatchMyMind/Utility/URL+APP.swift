//
//  URL+APP.swift
//  WatchMyMind
//
//  Created by Suriya on 28/2/2564 BE.
//

import Foundation

extension URL {
    static let appScheme = "wmm"
    static let appHost = "www.google.com"
    static let appHomeUrl = "\(Self.appScheme)://\(Self.appHost)"
    static let appDetailsPath = "details"
    static let appReferenceQueryName = "reference"
    static let appDetailsUrlFormat = "\(Self.appHomeUrl)/\(Self.appDetailsPath)?\(Self.appReferenceQueryName)=%@"
}
