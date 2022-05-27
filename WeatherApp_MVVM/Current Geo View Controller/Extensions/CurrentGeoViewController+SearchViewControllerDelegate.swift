

import Foundation

extension CurrentGeoViewController: SearchViewControllerDelegate {
    func sendNewRequest(geoLabel: String) {
        self.viewModel.sendRequest()
        self.viewModel.textForGeoLabel.value = geoLabel
    }
}
