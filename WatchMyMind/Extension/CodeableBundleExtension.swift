//
//  CodeableBundleExtension.swift
//  WatchMyMind
//
//  Created by Suriya on 23/2/2564 BE.
//

import Foundation
extension Bundle{
    func decode<T: Codable> (_ file : String) -> T{
        //create the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle")
        }
        //create a property for the data
        guard  let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from bundle")
        }
        //create a decoder
        let decoder = JSONDecoder()
        //create a property for the decoder data
        guard let loaded = try? decoder.decode( T.self , from: data) else {
            fatalError("failed to decode \(file) from bundle")
        }
        //return the ready-to-use data
         return loaded
    }
}