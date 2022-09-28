//
//  TableViewCell.swift
//  Recommend
//
//  Created by Ishank Soni on 19/09/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillCell(movie: Movie){
        self.title.text = movie.title
        self.rating.text = "Rating: \(movie.rating)"
        if let imageUrl = movie.imageUrl {
            self.movieImage.loadFrom(URLAddress: imageUrl)
        }
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
