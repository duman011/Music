//
//  GenreArtistsVC.swift
//  Music
//
//  Created by Yaşar Duman on 13.11.2023.
//

import UIKit

class GenreArtistsVC: UICollectionViewController {
    
    //MARK: - Variables
    let viewModel: GenreArtistsVM?
    
    
    //MARK: - Initializers
    init(genreId: String, manager: DeezerAPIManager) {
        self.viewModel = GenreArtistsVM(genreId: genreId, manager: manager)
        
        let layout = UICollectionViewFlowLayout()
     
        super.init(collectionViewLayout: layout)
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.reuseID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        title = "Discover"
        navigationItem.backButtonTitle = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Geri butonunu göster ve başlığı ayarla
       
  
    }
    
    @objc func backButtonPressed() {
        print("tapped back button")
        let homeVC = HomeVC()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)

    }
    
    
    //MARK: - Helper Functions
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let response = viewModel?.data {
            if let playlists = response.data {
                return playlists.count
            }
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.reuseID, for: indexPath) as! MusicCollectionViewCell
        
        if let response = viewModel?.data {
            if let playlists = response.data {
                let playlist = playlists[indexPath.row]
                
                if let imageURL = playlist.pictureXl {
                    cell.imageView.kf.setImage(with: URL(string: imageURL)!)
                }
                
                if let title = playlist.name {
                    cell.label.text = title
                }
            }
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            if let response = viewModel.data {
                if let playlists = response.data {
                    let playlist = playlists[indexPath.row]
                    
                    if let playlistURL = playlist.tracklist {
                        navigationController?.pushViewController(PlaylistVC(playlistURL: playlistURL, manager: viewModel.manager), animated: true)
                    }
                }
            }
        }
    }
}

extension GenreArtistsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 60) / 3, height: (view.frame.width - 60) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(leading: 20, trailing: 20)
    }
}

extension GenreArtistsVC : GenreArtistsVMDelegate {
    func updateUI() {
        collectionView.reloadData()
    }
}