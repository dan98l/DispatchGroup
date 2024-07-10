//
//  ImageTableViewCell.swift
//  DispatchGroup
//
//  Created by Daniil MacBook Pro on 09.07.2024.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {
    @IBOutlet private weak var checkImage: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    
    func clean() {
        checkImage.tintColor = .darkGray
        statusLabel.text = String()
    }
    
    func setStatus(_ status: DownloadStatus) {
        switch status {
        case .wait:
            statusLabel.text = "Status: Awaiting download"
            checkImage.tintColor = .darkGray
        case .finish:
            statusLabel.text = "Status: Finish"
            checkImage.tintColor = .systemGreen
        case .start:
            statusLabel.text = "Status: Download"
            checkImage.tintColor = .systemYellow
        case .error:
            statusLabel.text = "Status: Error"
            checkImage.tintColor = .systemRed
        }
    }
}
