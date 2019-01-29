//
//  ListItemsScreen.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 04/12/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import Foundation
import UIKit

class ListItemsViewController: UIViewController {
    private weak var tableView: UITableView? = nil
    
    var dataLoader: ItemDataLoader!
    private var listItems: [ListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = view.viewWithTag(1) as? UITableView
        tableView?.dataSource = self
        tableView?.delegate = self
        
        dataLoader.loadData(callback: handleSuccess, onError: handleError)
    }
    
    private func handleSuccess(data: [ListItem]) {
        listItems = data
        tableView?.reloadData()
    }
    
    private func handleError(message: String) {
        
    }
}

extension ListItemsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ListItemCell
        
        cell.setItem(item, imageLoader: dataLoader!)
        return cell
    }
}
