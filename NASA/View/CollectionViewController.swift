//
//  CollectionViewController.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ImagesDataReceivedDelegate {
    
    private var imageManager = ImageManager()
    private var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAndConfigureViews()
        imageManager.delegate = self
    }
    
    func handleRequestError() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI (image: Image) {
        let imageViewModel = ImageViewModel(image: image)
    }
    

    private func createAndConfigureViews(){
        collectionView.backgroundColor = .orange
        
        alertController = UIAlertController(title: "Error", message: "There was an error with processing of NASA data.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        
    }
    
    
}
