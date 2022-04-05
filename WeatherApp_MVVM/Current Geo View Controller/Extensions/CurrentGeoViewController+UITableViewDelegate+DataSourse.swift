import Foundation
import UIKit

extension CurrentGeoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.viewModel.weeklyOptions.value.main?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tabelViewCellId, for: indexPath) as? CurrentGeoTableViewCell else { fatalError() }
        
        guard let dates = self.viewModel.weeklyOptions.value.date else { return cell}
        let date = dates[indexPath.row]
        guard let temperatures = self.viewModel.weeklyOptions.value.temperature else { return cell }
        let temp = temperatures[indexPath.row]
        guard let weatherTexts = self.viewModel.weeklyOptions.value.main else { return cell }
        let main = weatherTexts[indexPath.row]
        
        cell.configure(dateText: date, degreeText: temp, weatherText: main)
        
        return cell
    }
    
    
}
