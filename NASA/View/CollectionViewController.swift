//
//  CollectionViewController.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ImagesDataReceivedDelegate {
    
    private var imageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .orange
        
        imageManager.delegate = self
        
        
        createViews()
        addSubviews()
        createConstraints()
    }
    
    // throw ui modal alert
    func handleRequestError() {
        print("handler request error")
    }
    
    func updateUI (image: Image) {
        let imageViewModel = ImageViewModel(image: image)
    }
    
    
    private func createViews(){
        
    }
    
    private func addSubviews(){
        
    }
    
    private func createConstraints() {
        
    }
    
}
