//
//  ViewController.swift
//  Basic-Flow-Layout
//
//  Created by Burak AKCAN on 1.11.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var characterData: [Characters] = []
    
    init() {
        super.init(collectionViewLayout: MosaicLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        registerCell()
        getCharacters()
        
        let layout = collectionViewLayout as! MosaicLayout
        layout.numberOfColumns = 2
        layout.delegate = self
        addButtons()
        
    }
    
    func addButtons() {
        let rightButton = UIBarButtonItem(title: "Custom Layout", style: .done, target: self, action: #selector(tapCustomLayout))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(title: "Mosaic Layout", style: .done, target: self, action: #selector(tapMosaicLayout))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    @objc func tapCustomLayout() {
        let layout = CustomLayout()
        layout.numberOfColumns = 2
        collectionView.setCollectionViewLayout(layout, animated: true)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc func tapMosaicLayout() {
        let layout = MosaicLayout()
        layout.numberOfColumns = 2
        layout.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: true)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
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

extension ViewController: MosicLayoutDelgate {
    func collectionView(_ collectionView: UICollectionView, heightForItemIndexPath indexPath: IndexPath) -> CGFloat {
        let random = Int.random(in: 1...5)
        return CGFloat(random * 100)
    }
    
    
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    //set cell size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = Int(collectionView.frame.width/2)
//        return .init(width: width - 20, height: width)
//    }
//
//    //set cell margin
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        .init(top: 0, left: 4, bottom: 0, right: 4)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        5
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
//}
