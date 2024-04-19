//
//  ViewController.swift
//  ImageGrid
//
//  Created by ajm2021 on 19/04/24.
//

import UIKit

class ViewController: UIViewController {
    private var dataModal: [DataModal] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure collection view layout
        // Fetch images from API
        collectionView.collectionViewLayout = createLayout()
        fetchImages()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .zero
        let itemWidth = (collectionView.frame.width - 20) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return layout
    }
    
    private func fetchImages() {
        Networking.shared.apiCall(completion: {[weak self] data in
            guard let this = self, let data = data else {
                return
            }
            this.dataModal = data
            DispatchQueue.main.async {
                this.collectionView.reloadData()
            }
        })
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: dataModal[indexPath.item])
        return cell
    }
}

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with dataModal: DataModal) {
        guard let domain = dataModal.thumbnail?.domain, let baseDomain = dataModal.thumbnail?.basePath, let key = dataModal.thumbnail?.key else {
            return
        }
        let imageURL = "\(domain)/\(baseDomain)/\(0)/\(key)"
        guard let url = URL(string: imageURL) else {
            return
        }
        imageView.image?.withTintColor(.gray)
        imageView.image = UIImage(systemName: "person.slash")
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            guard let this = self else {
                return
            }
            DispatchQueue.main.async {
                this.imageView.image = image
            }
        }
    }
}
