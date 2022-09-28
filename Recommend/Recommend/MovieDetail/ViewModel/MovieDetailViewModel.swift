//
//  MovieList.swift
//  Recommend
//
//  Created by Ishank Soni on 20/09/22.
//

import Foundation



protocol MovieDetailDelegate {
    func didRecievedMovieDetail(_ movieDetailViewModel: MovieDetailViewModel, movie: MovieDetailData)
    func didFailWithError(error: Error)
}


class MovieDetailViewModel{
    var movie: Movie
    var delegate: MovieDetailDelegate?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func detailMovieURL(movieID: Int?) -> String {
        if let id = movieID {
            return "https://api.themoviedb.org/3/movie/\(id)?api_key=d3e73fb8ffd8d00322c3ac649c18e689&language=en-US"
        }
        return ""
    }
    
    func fetchMovieDetail () {
        if let url = URL(string: detailMovieURL(movieID: movie.id)) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movieDetailData = self.parseJSON(safeData) {
                        print(movieDetailData)
                        self.delegate?.didRecievedMovieDetail(self, movie: movieDetailData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func genreToString(genres: [Genre]) -> String {
        var genreString = ""
        for genre in genres{
            genreString.append("\(genre.name), ")
        }
        return genreString
    }
    
    func parseJSON(_ detailData: Data) -> MovieDetailData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieDetailModel.self, from: detailData)
            let movieDetail = MovieDetailData(title: movie.title, imageURL: movie.imageUrl, genres: genreToString(genres: decodedData.genres), tagline: decodedData.tagline, releaseDate: decodedData.releaseDate, description: decodedData.overview)
            return movieDetail
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

