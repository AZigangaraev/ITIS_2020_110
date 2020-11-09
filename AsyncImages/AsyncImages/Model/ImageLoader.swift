//
//  ImageLoader.swift
//  AsyncImages
//
//  Created by Teacher on 09.11.2020.
//

import UIKit

class ImageLoader {
    func loadImage(image: Image, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: 1...5)) {
            guard let image = UIImage(named: image.name) else { return }

            completion(image)
        }
    }
}
