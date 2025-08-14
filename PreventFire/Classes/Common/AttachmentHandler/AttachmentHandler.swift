//
//  AttachmentHandler.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 12/17/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
import AVKit
import AssetsLibrary
import Photos
import MobileCoreServices

enum AttachmentType: String {
    case camera, video, photoLibrary
}

class AttachmentHandler: NSObject {
    
    // MARK: - Internal Properties
    
    static let shared = AttachmentHandler()
    fileprivate var currentVC: UIViewController?
    
    var imagePickedBlock: ((UIImage) -> Void)?
    var videoPickedBlock: ((NSURL) -> Void)?
    var filePickedBlock: ((URL) -> Void)?
    
    func showAttachmentActionSheet(viewController: UIViewController) {
            currentVC = viewController
            let actionSheet = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.authorisationStatus(attachmentTypeEnum: .camera, viewController: viewController)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.authorisationStatus(attachmentTypeEnum: .photoLibrary, viewController: viewController)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            viewController.present(actionSheet, animated: true)
        }

    
    func authorisationStatus(attachmentTypeEnum: AttachmentType, viewController: UIViewController) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = (attachmentTypeEnum == .camera) ? .camera : .photoLibrary
            currentVC?.present(picker, animated: true)
        }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            DispatchQueue.main.async {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .camera
                self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    private func showCameraPermissionPopup(attachmentTypeEnum: AttachmentType) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized: // The user has previously granted access to the camera.
            self.openCamera()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.openCamera()
                }
            }
            //denied - The user has previously denied access.
        //restricted - The user can't grant access due to restrictions.
        case .denied, .restricted:
            self.addAlertForSettings(attachmentTypeEnum: .camera)
            return
        }
    }
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            DispatchQueue.main.async {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .photoLibrary
                self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    private func showphotoLibraryPermissionPopup(attachmentTypeEnum: AttachmentType) {
       
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if attachmentTypeEnum == .photoLibrary {
                photoLibrary()
            }
            if attachmentTypeEnum == .video {
                videoLibrary()
            }
        case .denied, .restricted:
            self.addAlertForSettings(attachmentTypeEnum: .photoLibrary)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized {
                    self.photoLibrary()
                }
                if attachmentTypeEnum == AttachmentType.video {
                    self.videoLibrary()
                }
            })
        case .limited:
            break
        }
    }
    
    func videoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func documentPicker() {
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        currentVC?.present(importMenu, animated: true, completion: nil)
    }
}

// MARK: - Private Methods

extension AttachmentHandler {
    
    func addAlertForSettings(attachmentTypeEnum: AttachmentType) {
        let alertView = AlertView(title: LocalizedStrings.cameraService, message: LocalizedStrings.cameraAccessMessage, okButtonText: LocalizedStrings.gotoSettting, cancelButtonText: AlertMessage.Cancel) { (_, button) in
            if button == .other {
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        alertView.show(animated: true)
    }
    
}

// MARK: - UIImagePicker Delegate

extension AttachmentHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true, completion: nil)
        
        // To handle image
        if let image = info[.originalImage] as? UIImage {
            self.imagePickedBlock?(image)
        } else {
        }
        // To handle video
        if let videoUrl = info[.mediaURL] as? NSURL {
            //trying compression of video
            let data = NSData(contentsOf: videoUrl as URL)!
            print("File size before compression: \(Double(data.length / 1048576)) mb")
            self.videoPickedBlock?(videoUrl)
        } else {
        }
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UIDocumentPicker Delegate

extension AttachmentHandler: UIDocumentPickerDelegate, UIDocumentMenuDelegate {
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        currentVC?.present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.filePickedBlock?(url)
    }
    
    //    Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
}
