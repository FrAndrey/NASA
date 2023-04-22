//
//  CollectionViewController.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate,  ImagesDataReceivedDelegate {
    
    private let collectionCellIdentifier = "collectionCellIdentifier"
    private var previousUserInput = String()
    
    private var imageViewModels = [ImageViewModel]()
    
    private var imageManager = ImageManager()
    private var alertController: UIAlertController!
    
    private let searchBar = UISearchBar()
    private var clearButton: UIBarButtonItem!
    
    private var currentPage = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAndConfigureViews()
        imageManager.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 450, height: 450)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! CollectionViewCell
        
        let imageViewModel = imageViewModels[indexPath.item]
        collectionCell.imageViewModel = imageViewModel
        
        return collectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let collectionCell = cell as? CollectionViewCell else { return }
        let imageViewModel = imageViewModels[indexPath.item]
        
        // Once an image is loaded and displayed in UIImageView using sd_setImage
        // method of SDWebImage, it is cached locally on the device.
        // Next time the same image is requested, it will be loaded from the cache.
        if let imageUrl = URL(string: imageViewModel.hyperlink) {
            collectionCell.imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Placeholder"))
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let userInput = searchBar.text {
            
            // if a user input is the same as what is currently shown
            // - hide a keyboard and return
            if previousUserInput.lowercased() == userInput.lowercased() {
                print("was before")
                searchBar.resignFirstResponder()
                return
            }
            previousUserInput = userInput
            imageViewModels.removeAll()
            collectionView.reloadData()
            
            imageManager.fetchImagesMetaData(userInput: userInput, page: currentPage)
        }

        // Hide the keyboard
        searchBar.resignFirstResponder()
    }
    
    func handleRequestError() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI (image: Image) {
        let imageViewModel = ImageViewModel(image: image)
        
        imageViewModels.append(imageViewModel)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    

    private func createAndConfigureViews(){
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        collectionView.backgroundColor = .orange

        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.hidesSearchBarWhenScrolling = true
        
        alertController = UIAlertController(title: "Error", message: "There was an error with processing of NASA data.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        
    }
    
    
}
