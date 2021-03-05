//
//  Deeplinker.swift
//  WatchMyMind
//
//  Created by Suriya on 28/2/2564 BE.
//

import Foundation
import SwiftUI

class Deeplinker {
    enum Deeplink: Equatable {
        case home
        case description(reference: String)
    }
    func manage(url: URL) -> Deeplink? {
        guard url.scheme == URL.appScheme else { return nil }
        guard url.pathComponents.contains(URL.appDetailsPath) else { return .home }
        guard let query = url.query else { return nil }

        let components = query.split(separator: ",").flatMap { $0.split(separator: "=") }
        guard let idIndex = components.firstIndex(of: Substring(URL.appReferenceQueryName)) else { return nil }
        guard idIndex + 1 < components.count else { return nil }
        return .description(reference: String(components[idIndex.advanced(by: 1)]))
    }

   
}
struct DeeplinkKey: EnvironmentKey {
    static var defaultValue: Deeplinker.Deeplink? {
        return nil
    }
}

extension EnvironmentValues {
    var deeplink: Deeplinker.Deeplink? {
        get {
            self[DeeplinkKey]
        }
        set {
            self[DeeplinkKey] = newValue
        }
    }
}
