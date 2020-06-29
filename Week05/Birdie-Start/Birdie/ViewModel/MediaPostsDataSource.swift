//
//  DataSource.swift
//  Birdie-Final
//
//  Created by Asif Ahmed Jesi on 29/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class MediaPostsDataSource: NSObject, UITableViewDataSource {

    var data: DynamicMediaPostRepresentable = DynamicMediaPostRepresentable([])

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data.value[indexPath.row].cellInstance(tableView, indexPath: indexPath)
    }

}
