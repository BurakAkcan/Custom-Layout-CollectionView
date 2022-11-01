//
//  ViewController.swift
//  Basic-Flow-Layout
//
//  Created by Burak AKCAN on 1.11.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var characterData: [Characters] = []
    private var column: CGFloat = 3
    
     init() {
        super.init(collectionViewLayout: CharacterFlowLayout())
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        registerCell()
        getCharacters()
        
      
    }
}


//MARK: - Extensions

private extension ViewController {
    func getCharacters() {
        guard let characterDatas = Manager.shared.loadDatas() else { return }
        self.characterData = characterDatas
    }
    
    func registerCell() {
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
    }
    
    func createRefreshControl() {
        let refreshCntrl = UIRefreshControl()
        refreshCntrl.addTarget(self, action: #selector(tapRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshCntrl
    }
    
   @objc func tapRefresh() {
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
}

extension ViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        let item = characterData[indexPath.item]
        cell.setCell(item)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    //set cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width/1)
        return .init(width: width - 20, height: width)
    }
    
    //set cell margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 4, bottom: 0, right: 4)
    }
    
  
    
   
}
