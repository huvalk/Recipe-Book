//
//  GeneralCreationViewController.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 14.11.2020.
//

import UIKit

protocol GeneralDelegate: class {
    func saveGeneral(info: String)
}

class GeneralCreationViewController: UIViewController {
    let photoButton = UIButton(type: .system)
    let imagePicker = UIImagePickerController()
    let imageView = UIImageView()
    
    weak var delegate: GeneralDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .orange
        configureController()
    }
    
    private func configureController() {
        photoButton.setTitle("Photo", for: .normal)
        photoButton.setTitleColor(.systemPink, for: .normal)
        photoButton.addTarget(self, action: #selector(GeneralCreationViewController.makePhoto(sender:)), for: .touchUpInside)
        photoButton.backgroundColor = UIColor(named: "PastelGreen")
        setImageContraints()
        
        imagePicker.delegate = self
    }
    
    private func setImageContraints() {
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(photoButton)
        self.view.addSubview(imageView)
        
        photoButton.alpha = 1
        let photoButtonViewConstraints = [
            self.view.topAnchor.constraint(equalTo: photoButton.topAnchor, constant: 0),
            self.view.leadingAnchor.constraint(equalTo: photoButton.leadingAnchor, constant: 0),
            self.view.trailingAnchor.constraint(equalTo: photoButton.trailingAnchor, constant: 0),
            photoButton.heightAnchor.constraint(equalTo: photoButton.widthAnchor)
        ]
        
        let imageViewConstraints = [
            self.view.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0),
            self.view.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            self.view.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(photoButtonViewConstraints)
    }
}

extension GeneralCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        
        dismiss(animated: true, completion: nil)
    }
}
