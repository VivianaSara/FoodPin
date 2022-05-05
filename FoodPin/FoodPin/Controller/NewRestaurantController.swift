//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 05.05.2022.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController {

    @IBOutlet private var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.becomeFirstResponder()
        }
    }

    @IBOutlet private var typeTextField: RoundedTextField!
    @IBOutlet private var addressTextField: RoundedTextField!
    @IBOutlet private var phoneTextField: RoundedTextField!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize the navigation bar appearance
        if let appearance = navigationController?.navigationBar.standardAppearance {
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!,
                                                       .font: customFont]
            }

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }

        self.addressTextField.delegate = self
        self.nameTextField.delegate = self
        self.phoneTextField.delegate = self
        self.typeTextField.delegate = self

        // Get the superview's layout
        let margins = photoImageView.superview!.layoutMarginsGuide

        // Disable auto resizing mask to use auto layout programmatically
        photoImageView.translatesAutoresizingMaskIntoConstraints = false

        // Pin the leading edge of the image view to the margin's leading edge
        photoImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true

        // Pin the trailing edge of the image view to the margin's trailing edge
        photoImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

        // Pin the top edge of the image view to the margin's top edge
        photoImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true

        // Pin the bottom edge of the image view to the margin's bottom edge
        photoImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        // Hiding keyboard when tap in any blanck areas
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source",
                                                                 preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })

            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default,
                                                   handler: { (_) in

                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })

            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)

            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }

            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }

    @IBAction func saveButtonTapped(sender: UIButton ) {
        if nameTextField.text == "" || typeTextField.text == "" || phoneTextField.text == "" ||
            descriptionTextView.text == "" || addressTextField.text == "" {
            let allFieldRequired = UIAlertController(title: "Oops",
                                                     message: "We can't proceed because one of the field is blank. Please note that  all fields are required",
                                                     preferredStyle: .alert)
            allFieldRequired.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(allFieldRequired, animated: true, completion: nil)
        } else {
            print("Name:  \(nameTextField.text ?? "")")
            print("Type:  \(typeTextField.text ?? "")")
            print("Location:  \(addressTextField.text ?? "")")
            print("Phone:  \(phoneTextField.text ?? "")")
            print("Description:  \(descriptionTextView.text ?? "")")

            // After thee restaurant is added close the view
            dismiss(animated: true, completion: nil)
        }
    }
}

extension NewRestaurantController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }

        return true
    }
}

extension NewRestaurantController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }

        dismiss(animated: true, completion: nil)
    }
}
