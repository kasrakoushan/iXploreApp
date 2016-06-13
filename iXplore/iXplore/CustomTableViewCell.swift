//
//  CustomTableViewCell.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-08.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit
import MapKit

class CustomTableViewCell: UITableViewCell {
    
    // UI elements on the view
    var cellImage: UIImageView!
    var cellLabel: UILabel!
    var dateLabel: UILabel!
    var starImage: UIImageView!
    
    // table cell properties
    var title: String? = ""
    var imageURL: String? = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    
    // initializer that customizes the view
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let margin: CGFloat = 8
        let height: CGFloat = 80 //self.frame.height
        let width: CGFloat = self.frame.width
        
        // add image subview
        var frame = CGRectMake(margin, margin, height - 2*margin,
                               height - 2*margin)
        self.cellImage = UIImageView(frame: frame)
        self.addSubview(self.cellImage)
        
        // add title subview
        frame = CGRectMake(height + 2*margin, margin, width - height - 3*margin, height/2 - 2*margin)
        self.cellLabel = UILabel(frame: frame)
        self.cellLabel.font = UIFont(name: "Georgia-Italic", size: 20)
        self.addSubview(self.cellLabel)
        
        // add date subview
        frame = CGRectMake(height + 2*margin, 2*margin + height/2, width - height - 3*margin, height/2 - 2*margin)
        self.dateLabel = UILabel(frame: frame)
        self.dateLabel.font = UIFont(name: "Georgia", size: 15)
        self.dateLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(self.dateLabel)
        
        // add a star subview
        frame = CGRectMake(width, height/2, height/2, height/2)
        self.starImage = UIImageView(frame: frame)
        self.starImage.image = UIImage(named: "star_black.png")
        self.addSubview(self.starImage)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
