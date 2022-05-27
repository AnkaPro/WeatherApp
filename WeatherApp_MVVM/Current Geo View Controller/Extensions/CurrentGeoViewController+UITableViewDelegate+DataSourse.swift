import Foundation
import UIKit

extension CurrentGeoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.weeklyOptions.value.main?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tabelViewCellId, for: indexPath) as? CurrentGeoTableViewCell else { return UITableViewCell() }
        
        let configurator = CollectionCellConfigure(temperature: nil, date: nil, main: nil)
        
        if let dates = self.viewModel.weeklyOptions.value.date {
            configurator.date = dates[indexPath.row]
        }
        if let temperatures = self.viewModel.weeklyOptions.value.temperature {
            configurator.temperature = temperatures[indexPath.row]
        }
        
        if let weatherTexts = self.viewModel.weeklyOptions.value.main {
            configurator.main = weatherTexts[indexPath.row]
        }
        
        cell.viewModel.configure(config: configurator)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
