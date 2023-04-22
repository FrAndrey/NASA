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
            if let imageURL = imageViewModel?.hyperlink {
                // SDWebImage library is used for image lazy loading
                // https://github.com/SDWebImage/SDWebImage
                // Once an image is loaded and displayed in UIImageView using sd_setImage
                // method of the SDWebImage, it is cached locally on the device.
                // Next time the same image is requested, it will be loaded from the cache
                imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "Placeholder"), options: [.continueInBackground, .progressiveLoad])
            }
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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: frame.width),
            imageView.heightAnchor.constraint(equalToConstant: frame.height * 0.6),

            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
