//
//  MosaicLayout.swift
//  Basic-Flow-Layout
//
//  Created by Burak AKCAN on 2.11.2022.
//

import UIKit

import UIKit

protocol MosicLayoutDelgate {
    func collectionView(_ collectionView: UICollectionView, heightForItemIndexPath indexPath: IndexPath) -> CGFloat
}

class MosaicLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns = 0
    var cellPadding: CGFloat = 10
    var delegate: MosicLayoutDelgate!
    
    var cache: [UICollectionViewLayoutAttributes] = []
    fileprivate var contentHeight: CGFloat = 0
    fileprivate let cellHeight: CGFloat = 200
    fileprivate var width: CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return .init(width: width , height: contentHeight)
    }
    
    override func prepare() {
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            
            for column in 0..<numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView!, heightForItemIndexPath: indexPath)
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height )
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    
    
    
      

}

