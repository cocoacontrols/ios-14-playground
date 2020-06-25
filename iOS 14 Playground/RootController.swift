//
//  RootController.swift
//  iOS 14 Playground
//
//  Created by Aaron Brethorst on 6/24/20.
//
// This view controller uses Apple sample code from https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views
//

import UIKit

class RootController: UIViewController, UICollectionViewDelegate {

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "iOS 14"
    }

    required init?(coder: NSCoder) { fatalError() }

    private class Item<T>: NSObject, Identifiable where T: UIViewController {
        internal init(title: String?, tapped: (() -> Void)? = nil) {
            self.title = title
            self.tapped = tapped
        }

        let title: String?
        let tapped: (() -> Void)?
        private let identifier = UUID()
    }

    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        configureDataSource()
    }

    private lazy var collectionView: UICollectionView! = {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            config.headerMode = .firstItemInSection
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }

        let collView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collView.delegate = self
        collView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collView
    }()

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.dataSource.itemIdentifier(for: indexPath)?.tapped?()
    }

    private func configureDataSource() {
        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title?.localizedUppercase
            cell.contentConfiguration = content

            cell.accessories = [.outlineDisclosure()]
        }

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        dataSource.apply(snapshot, animatingDifferences: false)

        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        let headerItem = Item(title: "Pickers, Menus, and Actions")
        sectionSnapshot.append([headerItem])

        let colorPickerItem = Item(title: "Color Picker") {
            self.navigationController?.pushViewController(ColorPickerController(), animated: true)
        }

        let datePickerItem = Item(title: "Date Picker") {
            self.navigationController?.pushViewController(DatePickerController(), animated: true)
        }

        let menusItem = Item(title: "Menus") {
            self.navigationController?.pushViewController(MenusViewController(), animated: true)
        }

        let items = [colorPickerItem, datePickerItem, menusItem]
        sectionSnapshot.append(items, to: headerItem)
        sectionSnapshot.expand([headerItem])
        dataSource.apply(sectionSnapshot, to: 0)
    }
}
