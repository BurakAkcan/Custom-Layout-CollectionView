import UIKit

enum CellModel {
    case simple(item: Lesson)
    case availableToDropAtEnd
}

class DragDropController: UIViewController {
    
    //MARK: - Outputs
    
    var  collectionView: UICollectionView!
    
    //MARK: - Properties

    private lazy var cellIdentifier = "cellIdentifier"
    private lazy var titleList: [String] = ["Pazartesi", "Salı" , "Çarşamba" , "Parşembe", "Cuma"]
    private lazy var sections = 5
    private lazy var itemsInSection = 8
    private lazy var numberOfElementsInRow = 5
    private lazy var lessonsDatas: [Lesson] = []
    private lazy var myTitle = "Ders Programı"

    private lazy var data: [[CellModel]] = {
        var count = -1
        return (0 ..< sections).map { _ in
            return (0 ..< itemsInSection).map { _ -> CellModel in
                count += 1
                return .simple(item: lessonsDatas[count])
            }
        }
    }()
    
    //MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getLessonDatas()
        registerCells()
        
    }
    
    //MARK: - Methods
    
    private
    func getLessonDatas() {
        guard let myData = DataManager.shared.getDatas() else { return }
        self.lessonsDatas = myData
        print(myData.count)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private
    func configureCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .white
        collectionView.dragInteractionEnabled = true
        collectionView.reorderingCadence = .fast
        collectionView.dropDelegate = self
        collectionView.dragDelegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private
    func registerCells() {
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        collectionView.register(HeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
    }
}

//MARK: - Extensions

extension DragDropController: UICollectionViewDelegateFlowLayout {
    //set cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(collectionView.frame.width/5)
        return .init(width: width , height: width)
    }

    //set cell margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView{
            sectionHeader.setHeaderView(titleList[indexPath.section])
            return sectionHeader
        }
        return UICollectionReusableView()
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width, height: view.frame.height * 0.05)
    }
}

extension DragDropController: UICollectionViewDelegate { }


extension DragDropController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        switch data[indexPath.section][indexPath.item] {
            case .simple(let item):
            
            
            cell.setCell(item)
            cell.backgroundColor = .black.withAlphaComponent(0.8)
            case .availableToDropAtEnd:
                cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        }
        return cell
    }
}

extension DragDropController: UICollectionViewDragDelegate {

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = data[indexPath.section][indexPath.row]
        return [dragItem]
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = data[indexPath.section][indexPath.row]
        return [dragItem]
    }


    func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
        var itemsToInsert = [IndexPath]()
        (0 ..< data.count).forEach {
            itemsToInsert.append(IndexPath(item: data[$0].count, section: $0))
            data[$0].append(.availableToDropAtEnd)
        }
        collectionView.insertItems(at: itemsToInsert)
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        var removeItems = [IndexPath]()
        for section in 0..<data.count {
            for item in  0..<data[section].count {
                switch data[section][item] {
                    case .availableToDropAtEnd:
                        removeItems.append(IndexPath(item: item, section: section))
                    case .simple:
                        break
                }
            }
        }
        removeItems.forEach { data[$0.section].remove(at: $0.item) }
        collectionView.deleteItems(at: removeItems)
    }
}

extension DragDropController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        switch coordinator.proposal.operation {
            case .move:
                reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            default:
                break
        }
    }

    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag, destinationIndexPath != nil {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }

    private
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        let items = coordinator.items
        if items.count == 1, let item = items.first,
            let sourceIndexPath = item.sourceIndexPath,
            let localObject = item.dragItem.localObject as? CellModel {

            collectionView.performBatchUpdates ({
                data[sourceIndexPath.section].remove(at: sourceIndexPath.item)
                data[destinationIndexPath.section].insert(localObject, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
        }
    }
}
