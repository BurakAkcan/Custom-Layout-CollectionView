//
//  HeaderLayout.swift
//  Basic-Flow-Layout
//
//  Created by Burak AKCAN on 2.11.2022.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)! as [UICollectionViewLayoutAttributes]
        
        let offset = collectionView!.contentOffset
        if (offset.y < 0) {
            let deltaY = abs(offset.y)
            for attribute in layoutAttributes {
                if let elementKind = attribute.representedElementKind {
                    if elementKind == UICollectionView.elementKindSectionHeader {
                        var frame = attribute.frame
                        frame.size.height = max(0, headerReferenceSize.height + deltaY)
                        frame.origin.y = frame.minY - deltaY
                        attribute.frame = frame
                    }
                }
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    

}
