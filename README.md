# Custom-Layout-CollectionView

## ✍️ About
This repository contains examples of custom layout collection view.

## 🤔 Why we need use custom layout ?
 Collection views can be used with default flow layout. The layout needs a protocol to be implemented in order to get the layout information. 
 The protocol is the UICollectionViewDelegateFlowLayout. The delegate of the collection view will also act as a delegate to the flow layout.
 This layout will help us in solving our daily work, but it will not be enough when we want to solve the problem in complex works.
 
 ## ✈️ Usage Custom Layout
  In Custom layout class we must override at least one property and three methods.
  - collectionViewContentSize: This property holds the information about the size of the collection view’s contents.
  - prepare(): This method calculate collection view’s size and the positions of its items.
  - layoutAttributesForElements(in:): This method returns layout attributes for all cells and supplementary views, which intersect the specified rectangle.
  - layoutAttributesForItem(at:): This method we need to override in this tutorial returns layout attributes for an item at a specific index path.
 
 ## Requirements
  You need to have Git, Swift and Xcode installed.
  
  ## Demo
  
  ### Basic Flow Layout
![BasicFlowLayout_AdobeExpress](https://user-images.githubusercontent.com/106486885/199509312-8b06c9ff-e8c1-413a-9d07-4a7539f366e4.gif)
  ### Carosel Layout
![CaroselLayout_AdobeExpress](https://user-images.githubusercontent.com/106486885/199509813-d171193f-9381-4c66-8570-639ded76d9ef.gif)
  ### Stretchy Header 
![Stretchy_Header_AdobeExpress](https://user-images.githubusercontent.com/106486885/199510214-c48b3e72-cbbe-4961-8037-fbbeac13fd24.gif)
  ### Mosaic Layout
![MosaicLayout_AdobeExpress](https://user-images.githubusercontent.com/106486885/199507767-38608009-4ea9-459f-9f23-b9af81eac3c0.gif)



