//
//  CategoryViewCell.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 18/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setLayer()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
   private func setLayer()  {
        self.selectionStyle = .none
        self.containerView.layer.shadowColor = UIColor.gray.cgColor
        self.containerView.layer.shadowOpacity = 0.3
        self.containerView.layer.shadowOffset = CGSize.zero
        self.containerView.layer.shadowRadius = 6
        self.backgroundColor = UIColor.white
    }
    
    func setData(_ category:String)  {
        self.labelCategory.text = category
    }
    
}
