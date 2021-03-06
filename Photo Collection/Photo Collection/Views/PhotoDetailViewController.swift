//
//  PhotoDetailViewController.swift
//  Photo Collection
//
//  Created by Angel Buenrostro on 1/16/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    var photoController: PhotoController?
    var photo: Photo?
    var themeHelper: ThemeHelper?
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .photoLibrary
        pickerVC.allowsEditing = true
        pickerVC.delegate = self
        present(pickerVC, animated: true)
        
    }
    
    @IBAction func savePhoto(_ sender: UIBarButtonItem) {
        guard let photoController = photoController,
            let text = textField.text,
            let image = imageView.image,
            let imageData = image.pngData()
            else { return }
            if let photo = photo{
                photoController.Update(photo: photo, data: imageData, string: text)
            } else {
                
                photoController.Create(imageData: imageData, title: text)
                
            }
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTheme() {
        if themeHelper!.themePreference != nil {
        self.view.backgroundColor = (themeHelper!.themePreference == "Dark") ? .darkGray : .cyan
        } else {
            self.view.backgroundColor = UIColor.darkGray
        }
    }
    
    func updateViews(){
        setTheme()
        if photo != nil {
            textField.isUserInteractionEnabled = true
            imageView.image = UIImage(data: (photo?.imageData)!)
            textField.text = photo?.title
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = (info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
        textField.isUserInteractionEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
}

