//
//  MovieVideos.swift
//  Media
//
//  Created by 조규연 on 7/1/24.
//

import Foundation

struct MovieVideos: Decodable {
    let id: Int
    let results: [MovieVideosResult]
}

struct MovieVideosResult: Decodable {
    let key: String
}
