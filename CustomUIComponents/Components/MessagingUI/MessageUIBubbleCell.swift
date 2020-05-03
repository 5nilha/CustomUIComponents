//
//  MessageUIBubbleCell.swift
//  CustomUIComponents
//
//  Created by Fabio Quintanilha on 5/3/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import UIKit

class MessageUIBubbleCell: UITableViewCell {
    
    internal static let identifier = "MessageUIBubbleCell"
    
    
    private var avatarImageView: UIImageView? {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private var userName: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
