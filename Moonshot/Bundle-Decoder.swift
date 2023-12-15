//
//  Bundle-Decoder.swift
//  Moonshot
//
//  Created by Kein Li on 12/14/23.
//

import Foundation


extension Bundle {
    func decode(_ file: String) -> [String: Astronaut] {
        
        // What this does is provide the path for this file in this bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        print(url)
        
        //Attempts to make a Data object out of the url
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        print(data)
//
        let decoder = JSONDecoder()
//
        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        print(loaded)
//
        return loaded
    }
}
