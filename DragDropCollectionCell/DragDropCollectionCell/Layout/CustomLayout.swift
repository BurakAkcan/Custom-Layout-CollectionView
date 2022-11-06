//
//  customLayout.swift
//  DragCollectionCell
//
//  Created by Burak AKCAN on 4.11.2022.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns = 0
    
    var cache: [UICollectionViewLayoutAttributes] = []
    fileprivate var contentHeight: CGFloat = 0
    fileprivate let cellHeight: CGFloat = 200
    fileprivate var width: CGFloat {
        get {
            return collectionView!.bounds.width
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
                let frame = CGRect(x: xOffset[column] + 10 , y: yOffset[column], width: columnWidth - 20, height: cellHeight - 10)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + cellHeight
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
