import Foundation
import UIKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filterredData.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TownsTableViewCell else { return TownsTableViewCell() }
        guard let city = self.viewModel.filterredData.value?[indexPath.row] else { return TownsTableViewCell() }
        cell.viewModel.configure(with: city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true)
        guard let geoLabel = self.viewModel.filterredData.value?[indexPath.row] else { return }
        print(geoLabel)
        self.viewModel.townWasSelect(indexPath: indexPath)
        self.delegate?.sendNewRequest(geoLabel: geoLabel)
        self.searchBar.text?.removeAll()
        guard let text = searchBar.text else { return }
        viewModel.filterData(searchText: text, tableView: self.tableViewTowns)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.filterData(searchText: searchText, tableView: self.tableViewTowns)
       
    }
}
