//
//  ImageCell.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 18.11.2020.
//

import UIKit
import PinLayout

protocol TableViewControllerPresenter: class {
    func showViewController(_ controller: UIViewController, animated: Bool, completion: (() -> ())?)
    
    func imageSelected(image: UIImage?)
}

class ImageCell: UITableViewCell {
    let photoButton = UIButton(type: .system)
    let imagePicker = UIImagePickerController()
    let photoView = UIImageView()
    
    weak var presenter: TableViewControllerPresenter?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    private func setup() {
        imagePicker.delegate = self
        photoButton.setImage(UIImage(named: "Camera"), for: .normal)
        photoButton.tintColor = UIColor(named: "PastelGreen")
        photoButton.backgroundColor = .white
        photoButton.layer.cornerRadius = 5
        photoButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        photoButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        photoButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        photoButton.layer.shadowOpacity = 0.8
        photoButton.layer.shadowRadius = 0.0
        photoButton.layer.masksToBounds = false
        photoButton.layer.cornerRadius = 5.0
        photoButton.addTarget(self, action: #selector(ImageCell.makePhoto(sender:)), for: .touchUpInside)
        
        photoView.backgroundColor = .systemGray5
        photoView.image = UIImage(named: "Food")

        
        [photoView, photoButton].forEach { contentView.addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoButton.adjustsImageSizeForAccessibilityContentSizeCategory = false
        photoView.adjustsImageSizeForAccessibilityContentSizeCategory = false
        photoView.pin
            .top()
            .left()
            .right()
            .aspectRatio(1)
        
        photoButton.pin
            .hCenter()
            .bottom(5)
            .height(50)
            .width(50)
    }

    func configure() {
        setNeedsLayout()
    }
    
    func getData() -> UIImage {
        return photoView.image ?? UIImage(named: "Food")!
    }
}

extension ImageCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func makePhoto(sender: UIButton) {
        self.photoButton.setTitleColor(UIColor.white, for: .normal)
        self.photoButton.isUserInteractionEnabled = true

        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }

        self.presenter?.showViewController(alert, animated: true, completion: nil)
    }

    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.presenter?.showViewController(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.presenter?.showViewController(alert, animated: true, completion: nil)
        }
    }

    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.presenter?.showViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoView.image = originalImage
        }
        
        self.presenter?.imageSelected(image: photoView.image)
    }
}
