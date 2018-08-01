//
//  SearchDataSource.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit


/// Create HeaderView for Recent Search items
class HeaderViewCreator:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var recentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        label.text = String.recent
        return label
    }()
    
    func setUp(){
        self.addSubview(recentLabel)
        NSLayoutConstraint.activate([
            recentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            recentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            recentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            recentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
            ])

    }
}




/// SearchDataSource That have recent Search items
class SearchDataSource :BasicDataSource<RecentTableViewCell,SuggestStorage> {
    
    typealias ConfigurationBlock = (RecentTableViewCell,SuggestStorage,IndexPath)->Void
    typealias SelectBlock = (SuggestStorage,IndexPath)->Void

    /// The configure block instance.
    private let configureBlock: ConfigurationBlock
    private var didSelect: SelectBlock = {_,_  in}

    public init(configureBlock:  @escaping ConfigurationBlock) {
        self.configureBlock = configureBlock
        super.init()
    }
    public func selectionHanlder(_ handler:@escaping SelectBlock){
        self.didSelect = handler
    }
    
    override func configureTableView(_ tableView: UITableView, configure cell: RecentTableViewCell, with item: SuggestStorage, at indexPath: IndexPath) {
        self.configureBlock(cell,item,indexPath)
    }
    
    override func selectionHanlder(_ tableView: UITableView, cellwith item: SuggestStorage, at indexPath: IndexPath) {
        didSelect(item,indexPath)
    }

    
    //MARK: HeaderViewCreator
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Header view appear only when there is data
        if items.count > 0 {
            return HeaderViewCreator(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (items.count > 0) ?  40 : 0.0  // Header view appear only when there is data
    }
    
}

