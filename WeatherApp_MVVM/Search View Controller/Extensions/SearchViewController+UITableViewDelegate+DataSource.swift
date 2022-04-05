import Foundation
import UIKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filterredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TownsTableViewCell else { return TownsTableViewCell() }
        let city = self.viewModel.filterredData[indexPath.row]
        cell.configure(with: city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        self.dismiss(animated: true)
//        let geoLabel = self.jsonParsing.arrayCitiesEn[indexPath.row]
        
//        let newCityVC = NewCityViewController()
        let cityName = viewModel.filterredData[indexPath.row]
        guard let indexOfSearchCity = self.viewModel.initJSONCityArray.firstIndex(of: cityName) else { return }
        self.viewModel.townWasSelect(indexPath: indexPath)
        Manager.shared.latitude = String(viewModel.initJSONLatArray[indexOfSearchCity])
        Manager.shared.longtitude = String(viewModel.initJSONLonArray[indexOfSearchCity])
        self.currentViewModel.sendRequest()


//        newCityVC.manager.latitude = String(viewModel.initJSONLatArray[indexOfSearchCity])
//        newCityVC.manager.longtitude = String(viewModel.initJSONLonArray[indexOfSearchCity])
//        newCityVC.currentView.geoLabel.text = geoLabel
//        if let navController = self.navigationController {
//            navController.pushViewController(newCityVC, animated: true)
//        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.filterredData = []
        
        if searchText.isEmpty {
            viewModel.filterredData = self.viewModel.initJSONCityArray
        } else {
            viewModel.filterredData = self.viewModel.initJSONCityArray.filter { $0.contains(searchText)}
        }
        self.viewModel.jsonParsing.arrayCitiesEn = viewModel.filterredData
        self.tableViewTowns.reloadData()
        }
    }
