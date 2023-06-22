//
//  StoreItemTableViewDiffableDataSource.swift
//  iTunesSearch
//
//  Created by Paige Stephenson on 6/22/23.
//

import Foundation
import UIKit

@MainActor

//This is a concrete subclass of UITableViewDiffableDataSource - it is no longer generic
class StoreItemTableViewDiffableDataSource: UITableViewDiffableDataSource<String, StoreItem> {
    
//    The following method provides titles for section headers
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snapshot().sectionIdentifiers[section]
    }
}
