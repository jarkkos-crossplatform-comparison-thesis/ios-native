//
//  ListItemCell.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 04/12/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {
    weak var itemImageView: UIImageView?
    weak var itemDescriptionLabel: UILabel?
    
    var curLoadHelper: ImageLoadHelper? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        itemImageView = viewWithTag(1) as? UIImageView
        itemDescriptionLabel = viewWithTag(2) as? UILabel
    }
    
    func setItem(_ item: ListItem, imageLoader: ItemDataLoader) {
        self.itemDescriptionLabel?.text = item.description
        self.itemImageView?.image = nil
        
        curLoadHelper?.cancelled = true
        
        let helper = ImageLoadHelper(self.itemImageView)
        curLoadHelper = helper
        imageLoader.loadImage(of: item, callback: helper.setImageViewImage)
    }
}

class ImageLoadHelper {
    weak var imageView: UIImageView?
    var cancelled: Bool = false
    
    init(_ imageView: UIImageView?) {
        self.imageView = imageView
    }
    
    func setImageViewImage(image: UIImage) {
        if !cancelled, let view = imageView {
            view.image = image
        }
    }
}
