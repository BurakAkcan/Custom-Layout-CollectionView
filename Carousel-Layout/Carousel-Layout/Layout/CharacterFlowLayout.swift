//
//  CharacterFlowLayout.swift
//  Basic-Flow-Layout
//
//  Created by Burak AKCAN on 1.11.2022.
//

import UIKit

class CharacterFlowLayout: UICollectionViewFlowLayout {
    
    let standartItemAlpha: CGFloat = 0.5
    let standartItemScale: CGFloat = 0.5
    
    override func prepare() {
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAttributes(itemAttributesCopy)
            attributesCopy.append(itemAttributesCopy)
        }
    
        
        return attributesCopy
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        let collectionCenter = collectionView!.frame.size.height/2
        let offset = collectionView!.contentOffset.y
        let normalizedCenter = attributes.center.y - offset
        
        let maxDistance = self.itemSize.height + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        
        let ratio = (maxDistance - distance)/maxDistance
        let alpha = ratio * (1 - self.standartItemAlpha) + self.standartItemAlpha
        let scale = ratio * (1 - self.standartItemScale) + self.standartItemScale
        
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let layoutAttributes = self.layoutAttributesForElements(in: collectionView!.bounds)
        let center = collectionView!.bounds.size.height/2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.y + center
        let closest = layoutAttributes?.sorted(by: {
            abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin)
        }).first ?? UICollectionViewLayoutAttributes()
        let targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - center))
        return targetContentOffset
        
    }

}
