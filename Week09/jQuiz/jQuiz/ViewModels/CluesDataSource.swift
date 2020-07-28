//
//  ClueDataSource.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 28/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class CluesDataSource: NSObject, UITableViewDataSource {

    var data: DynamicClueRepresentable = DynamicClueRepresentable([])

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
