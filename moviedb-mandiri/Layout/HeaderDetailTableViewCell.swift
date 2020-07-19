//
//  HeaderDetailTableViewCell.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit

class HeaderDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var watchTrailerOnClick:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func initData(movie:Movie)  {
        titleLabel.text = movie.title
        movieImageView.kf.setImage(with: URL(string: ApiService.BASE_POSTER_PATH + (movie.posterPath ?? "")))
        overviewLabel.text = movie.overview
    }
    
    @IBAction func watchTrailer(_ sender: Any) {
        self.watchTrailerOnClick?()
    }
}
