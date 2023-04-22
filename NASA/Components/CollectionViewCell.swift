//
//  CollectionViewCell.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var imageView:UIImageView!
    
    let lightGray = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    
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
    
    func configureCell() {
        
    }
    
    private func createViews(){
        
    }
    
    private func addSubviews(){
        
    }
    
    private func createConstraints() {
        
    }
    
}
