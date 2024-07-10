//
//  ImageViewModel.swift
//  DispatchGroup
//
//  Created by Daniil MacBook Pro on 09.07.2024.
//

import Foundation

protocol ImageViewModelDelegate {
    func updateStatus(status: DownloadStatus)
    func updateTime(time: Double)
}

final class ImageViewModel {
    
    static let shared = ImageViewModel()
    private let downloadManager = DownloadManager()
    var delegate: ImageViewModelDelegate?
    
    private(set) var images = [String: DownloadStatus]()
    private(set) var imageUrls = [
        "https",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https:",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu",
        "https://clck.ru/3Bo5A5",
        "https://clck.ru/3Bo5Do",
        "https://clck.ru/3Bo5Eu"

    ]
    
    func startDownload() {
        let date = Date.now
        let group = DispatchGroup()
        let queue = DispatchQueue(
            label: "ru.download-image.queue"
        )
        
        for image in imageUrls.enumerated() {
            
            images[image.element] = .start
            delegate?.updateStatus(status: .start)
            
            group.enter()
            queue.async(group: group) {
                self.downloadManager.downloadImage(urlString: image.element) { [weak self] data in
                    defer { group.leave() }
                    
                    if data != nil {
                        self?.images[image.element] = .finish
                    } else {
                        self?.images[image.element] = .error
                    }
                    
                    DispatchQueue.main.async {
                        self?.delegate?.updateStatus(status: .finish)
                    }
                }
            }
        }
        
        queue.async {
            group.notify(queue: .main, execute: {
                self.delegate?.updateTime(time: Date.now.timeIntervalSince1970 - date.timeIntervalSince1970)
            })
        }
    }
    
}
