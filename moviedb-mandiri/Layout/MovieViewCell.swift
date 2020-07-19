//
//  MovieViewCell.swift
//  movieDB-ios
//
//  Created by Calvin Saragih on 25/05/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit
import Kingfisher
class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayer()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setLayer() {
        self.selectionStyle = .none
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 6
        self.backgroundColor = UIColor.white
    }
    
    func setView(movie:Movie){
        self.movieImageView.kf.setImage(with: URL(string: ApiService.BASE_POSTER_PATH + (movie.posterPath ?? "")))
        self.titleLabel.text = movie.title
        self.dateCreatedLabel.text = movie.releaseDate
        self.overviewLabel.text = movie.overview
    }
}
