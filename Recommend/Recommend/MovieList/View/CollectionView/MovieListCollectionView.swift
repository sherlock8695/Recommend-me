//
//  MovieListCollectionView.swift
//  Recommend
//
//  Created by Ishank Soni on 21/09/22.
//

import UIKit

class MovieListCollectionView: UIViewController {
    
    private var collectionView: UICollectionView?
    var movies: [Movie] = []
    var movieListViewModel: MovieListViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recommend-me"
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        movieListViewModel.delegate = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        movieListViewModel.fetchMovieList()
        // Do any additional setup after loading the view.
    }

}

extension MovieListCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setupCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetailScreen(selectedItem: indexPath.row)
    }
    
    func navigateToDetailScreen(selectedItem: Int) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailView") as! MovieDetailView
        nextViewController.selectedMovie = movies[selectedItem]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

extension MovieListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3) - 4, height:(view.frame.height/3) - 4)
    }
}

extension MovieListCollectionView: MovieListDelegate {
    func didRecievedMovies(_ movieListViewModel: MovieListViewModel, movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            if let collectionView = self.collectionView {
                collectionView.reloadData()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

