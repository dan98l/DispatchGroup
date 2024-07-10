//
//  ViewController.swift
//  DispatchGroup
//
//  Created by Daniil MacBook Pro on 09.07.2024.
//

import UIKit

final class ImageViewController: UIViewController {
    
    @IBOutlet private weak var tiemLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var imageTable: UITableView!
    
    private let viewModel = ImageViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.startDownload()
        self.imageTable.dataSource = self
    }
}

extension ImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imageUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none
        cell.clean()
        cell.setStatus(viewModel.images[viewModel.imageUrls[indexPath.row]] ?? .wait)
        
        return cell
    }
}

extension ImageViewController: ImageViewModelDelegate {
    func updateTime(time: Double) {
        self.tiemLabel.text = "Time: \(NSString(format:"%.2f", time) as String)"
    }
    
    func updateStatus(status: DownloadStatus) {
        self.imageTable.reloadData()
    }
}
