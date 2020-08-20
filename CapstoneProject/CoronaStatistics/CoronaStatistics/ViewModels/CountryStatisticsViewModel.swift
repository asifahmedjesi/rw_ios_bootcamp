//
//  CountryStatisticsViewModel.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 20/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CountryStatisticsViewModel
class CountryStatisticsViewModel: CountryStatisticsRepresentable {

    private let data: CountryStatistics
    
    init(data: CountryStatistics) {
        self.data = data
    }
    
    var country: String {
        return data.country ?? ""
    }
    
    var confirmed: Int {
        return data.confirmed ?? 0
    }
    
    var deaths: Int {
        return data.deaths ?? 0
    }
    
    var critical: Int {
        return data.critical ?? 0
    }
    
    var recovered: Int {
        return data.recovered ?? 0
    }

    var longitude: Double {
        return data.longitude ?? 0.0
    }

    var latitude: Double {
        return data.latitude ?? 0.0
    }
    
    var fatalityRate: Double {
        return (100.00 * Double(deaths)) / Double(confirmed)
    }
    
    var recoveredRate: Double {
        return (100.00 * Double(recovered)) / Double(confirmed)
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryStatisticsCell.identifier, for: indexPath) as! CountryStatisticsCell
        configure(for: cell)
        return cell
    }
}

extension CountryStatisticsViewModel {
    
    public func configure(for cell: CountryStatisticsCell) {
        cell.countryLabel.text = self.country
        cell.confirmedLabel.text = self.confirmed.withCommas()
        cell.deathLabel.text = self.deaths.withCommas()
        cell.recoveredLabel.text = self.recovered.withCommas()
        cell.selectionStyle = .none
    }
}

extension CountryStatistics {
    
    func convertToViewModel() -> CountryStatisticsViewModel {
        return CountryStatisticsViewModel(data: self)
    }
}
