//
//  Movie.swift
//  Recommend
//
//  Created by Ishank Soni on 20/09/22.
//

import Foundation

struct MovieList {
    var movies: [Movie]
    
    mutating func addMovie(movie: Movie){
        movies.append(movie)
    }
}

struct Movie {
    let id: Int
    let title: String
    let rating: String
    let imageUrl: String?
}
