//
//  ImageCell.swift
//  AsyncImages
//
//  Created by Teacher on 09.11.2020.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet private var imageNameLabel: UILabel!
    @IBOutlet private var customImageView: UIImageView!

    var loadImage: ((Image, @escaping (UIImage) -> Void) -> Void)?

    private var currentImage: Image?

    override func awakeFromNib() {
        super.awakeFromNib()

        clear()
    }

    func set(image: Image) {
        currentImage = image
        imageNameLabel.text = image.name
        loadImage?(image) { loadedImage in
            guard self.currentImage == image else { return }
            self.customImageView.image = loadedImage
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        clear()
    }

    private func clear() {
        imageNameLabel.text = nil
        customImageView.image = nil
        currentImage = nil
    }
}
