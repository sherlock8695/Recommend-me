//
//  MovieDetailResponseModel.swift
//  Recommend
//
//  Created by Ishank Soni on 21/09/22.
//

import Foundation

struct MovieDetailModel: Codable {
    let genres: [Genre]
    let id: Int
    let releaseDate: String
    let overview: String
    let status, tagline, title: String

    enum CodingKeys: String, CodingKey {
        case genres
        case id
        case overview
        case releaseDate = "release_date"
        case status, tagline, title
    }
    
}


// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

