//
//  MovieListView.swift
//  Recommend
//
//  Created by Ishank Soni on 19/09/22.
//

import UIKit

class MovieListView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var movieListViewModel: MovieListViewModel = MovieListViewModel()
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListViewModel.delegate = self
        self.title = "Recommend-me"
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        movieListViewModel.fetchMovieList()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.fillCell(movie: movies[indexPath.row])
        cell.backgroundColor = indexPath.row % 2 == 0 ? .white : .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailScreen()
    }
    
    func navigateToDetailScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailView") as! MovieDetailView
        if let selectedRow = tableview.indexPathForSelectedRow {
            nextViewController.selectedMovie = movies[selectedRow.row]
        }
        self.show(nextViewController, sender: nil)
    }
}

extension MovieListView: MovieListDelegate {
    func didRecievedMovies(_ movieListViewModel: MovieListViewModel, movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableview.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        print(URLAddress)
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    print("Loded image \(loadedImage)")
                }
            }
        }
    }
}
