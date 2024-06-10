//
//  MovieCredit.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import Foundation

struct MovieCredit: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable {
    let name: String
    let profile_path: String?
    let character: String?
}

struct Crew: Codable {
    let name: String
}
