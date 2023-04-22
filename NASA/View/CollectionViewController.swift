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
        let availableWidth = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        let itemWidth = availableWidth - 35
        
        let aspectRatio: CGFloat = 1.25
        let itemHeight = itemWidth * aspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
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
    
    // hide the search bar when a user taps outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    // make API request with the next page
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let distanceFromBottom = calculateDistanceFromBottom()
        
        if distanceFromBottom < 0, !decelerate {
            loadNextPage()
        }
    }
    
    // make API request with the next page
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let distanceFromBottom = calculateDistanceFromBottom()
        
        if distanceFromBottom < 0 {
            loadNextPage()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        
        if let userInput = searchBar.text {
            navigationItem.rightBarButtonItem = nil
            
            // if a user input is the same as what is currently shown
            // - hide a keyboard and return
            if previousUserInput.lowercased() == userInput.lowercased() {
                searchBar.resignFirstResponder()
                addClearButtonToNavBar()
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        
        if navigationItem.rightBarButtonItem == nil && imageViewModels.count != 0 {
            navigationItem.rightBarButtonItem = clearButton
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
    }
    
    func handleRequestError() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI (image: Image) {
        let imageViewModel = ImageViewModel(image: image)
        imageViewModels.append(imageViewModel)
        
        DispatchQueue.main.async {
            // since collection is not null, clear button can be displayed
            self.addClearButtonToNavBar()
            self.collectionView.reloadData()
        }
    }
    
    @objc func dismissKeyboard() {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    @objc func clearData() {
        imageViewModels.removeAll()
        navigationItem.rightBarButtonItem = nil
        searchBar.text = ""
        previousUserInput = ""
        currentPage = 1
        collectionView.reloadData()
    }
    
    // loadNextPage might be called when a user scrolled down and pushed the "Clear" button
    // the searchbar text check needed in this case
    private func loadNextPage() {
        // NASA API have limit of 100 pages
        if currentPage == 100 || searchBar.text == nil || searchBar.text == "" {
            return
        }
        
        currentPage += 1
        imageManager.fetchImagesMetaData(userInput: previousUserInput, page: currentPage)
    }
    
    private func calculateDistanceFromBottom() -> CGFloat{
        let contentHeight = collectionView.contentSize.height
        let offsetY = collectionView.contentOffset.y
        
        return contentHeight - offsetY - collectionView.frame.height
    }
    
    private func addClearButtonToNavBar() {
        if self.navigationItem.rightBarButtonItem == nil {
            self.navigationItem.rightBarButtonItem = self.clearButton
        }
    }

    private func createAndConfigureViews(){
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.hidesSearchBarWhenScrolling = true
        
        alertController = UIAlertController(title: "Error", message: "There was an error with processing of NASA data.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearData))
        clearButton.tintColor = .blue
        clearButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
        clearButton.setBackgroundImage(UIImage(named: "clear_button_bg"), for: .normal, barMetrics: .default)
        
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        collectionView.addGestureRecognizer(tap)
    }
}
