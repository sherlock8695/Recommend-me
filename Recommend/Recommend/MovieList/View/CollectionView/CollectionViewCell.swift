//
//  CollectionViewCell.swift
//  Recommend
//
//  Created by Ishank Soni on 21/09/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    private let movieImageView : UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let movieTitle : UILabel =  {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints=false
        title.backgroundColor = .gray
        title.lineBreakMode = .byCharWrapping
        title.numberOfLines = 2
        return title
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitle)
        addConstraints()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupCell(movie: Movie){
        
        if let imageURL = movie.imageUrl {
            movieImageView.loadFrom(URLAddress: imageURL)
        }
        movieTitle.text = movie.title
    }
    
    private func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        constraints.append(movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(movieImageView.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor, constant:-50))
        constraints.append(movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor))
        constraints.append(movieTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor))
        constraints.append(movieTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor))
        NSLayoutConstraint.activate(constraints)
    }
}
