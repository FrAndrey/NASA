//
//  CollectionViewCell.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var imageView:UIImageView!
    
    let lightGray = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    
    var imageViewModel: ImageViewModel! {
        didSet {
            titleLabel.text = imageViewModel.title
            descriptionLabel.text = imageViewModel.description
            // use SDWebImage libary for image, // imageViewModel.hyperlink
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = lightGray
        
        createViews()
        addSubviews()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = lightGray

        createViews()
        addSubviews()
        createConstraints()
    }
    
    private func createViews(){
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        descriptionLabel = UILabel(frame: CGRect.zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center

        imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Placeholder")
        imageView.contentMode = .scaleAspectFit
    }
    
    private func addSubviews(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
    }
    
    private func createConstraints() {
        
        let constraints = [
            // add constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
