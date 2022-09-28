//
//  MovieDetail.swift
//  Recommend
//
//  Created by Ishank Soni on 21/09/22.
//

import UIKit


class MovieDetailView: UIViewController {
        
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var cast: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var selectedMovie: Movie?
    var movieDetailViewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedMovie?.title ?? "Movie Title"
        movieDetailViewModel = MovieDetailViewModel(movie: selectedMovie!)
        movieDetailViewModel.delegate = self
        movieDetailViewModel.fetchMovieDetail()
    }
}

extension MovieDetailView: MovieDetailDelegate {
    func didRecievedMovieDetail(_ movieDetailViewModel: MovieDetailViewModel, movie: MovieDetailData) {
        DispatchQueue.main.async {
            if let description = movie.description {
                self.movieDescription.text = "Description: \(String(describing: description))"
            }
            if let imageUrl = movie.imageURL {
                self.movieImage.loadFrom(URLAddress: imageUrl)
            }
            if let genres = movie.genres {
                self.genre.text = "Genres: \(String(describing: genres))"
            }
            if let tagline = movie.tagline {
                self.cast.text = "Tagline: \(String(describing: tagline))"
            }
            if let relaseDate = movie.releaseDate {
                self.releaseDate.text = "Released On: \(String(describing: relaseDate))"
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
