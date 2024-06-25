//
//  MovieImage.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import Foundation

struct MovieImage: Codable {
    let backdrops: [Backdrop]
    let id: Int
    let logos, posters: [Backdrop]
    
}

struct Backdrop: Codable, PosterData {
    let filePath: String

    var path: String? {
        return filePath
    }
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
