//
//  MovieList.swift
//  Recommend
//
//  Created by Ishank Soni on 20/09/22.
//

import Foundation



protocol MovieListDelegate: AnyObject {
    func didRecievedMovies(_ movieListViewModel: MovieListViewModel, movies: [Movie])
    func didFailWithError(error: Error)
}


class MovieListViewModel{
    
    weak var delegate: MovieListDelegate?
    var movieList: MovieList = MovieList(movies: [])
    
    let topMovieurl = "https://api.themoviedb.org/3/movie/top_rated?api_key=d3e73fb8ffd8d00322c3ac649c18e689"
    
    func fetchMovieList () {
        if let url = URL(string: topMovieurl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let moviesData = self.parseJSON(safeData) {
                        print(moviesData)
                        self.delegate?.didRecievedMovies(self, movies: moviesData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ listData: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieListResponseModel.self, from: listData)
            for item in decodedData.results {
                let movie = Movie(id: item.id, title: item.title, rating: String(format: "%.1f", item.voteAverage) , imageUrl: "https://image.tmdb.org/t/p/original\(String(item.posterPath))")
                movieList.addMovie(movie: movie)
            }
            return movieList.movies
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
