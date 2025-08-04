//
//  ConcernRequestViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 1/31/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class ConcernRequestViewController: AbstractViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imageView: UIButton!
    @IBOutlet weak var imageMesssageLabel: UILabel!
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var buildingNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var peopleCountTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkBoxLabel: UILabel!
    @IBOutlet weak var disclaimerLabel: UILabel!
    
    // MARK: - Properties
    
    var didImageUploaded = false
    var locationManager: CLLocationManager!
    var gmsAddress: GMSAddress = GMSAddress()
    var checkBoxValue = "0"
    var imageId: String = ""
    let maxCharLimit = 600
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTransparentNavigationBar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - Configure UI

extension ConcernRequestViewController {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupButtons()
        setupLabels()
        setupNavigationBar()
        setupTextField()
        setupTextView()
        
    }
    
    func setupNavigationBar() {
        if isFromMenuView {
            addLeftMenuItem()
            setTransparentNavigationBar()
            setNavigationBarTitle(LocalizedStrings.fireSafetyConcerns)
            configureNavbarTitle(LocalizedStrings.fireSafetyConcerns)
            
        } else {
            setTransparentNavigationBar()
            setNavBarTitle(LocalizedStrings.fireSafetyConcerns)
            addbackButton()
        }
    }
    
    private func setupLabels() {
        self.imageMesssageLabel.configureLabel(title: LocalizedStrings.fireSafeIndiaFoundation, color: AppColor.Label.logoTitle, font: FontStyle(family: .poppins, type: .medium, size: .pt16), alignment: .center)
        self.checkBoxLabel.configureLabel(title: LocalizedStrings.checkBoxText, color: AppColor.primaryColor, font: .regular, size: .pt12, alignment: .center)
        self.disclaimerLabel.configureLabel(title: LocalizedStrings.disclaimerText, color: .red, font: .medium, size: .pt12, alignment: .center)
        
    }
    
    private func setupButtons() {
        submitButton.configureButtonWithTitle(title: LocalizedStrings.submit, titleColor: .white, backgroundColor: AppColor.Button.submitBackgroundColor!, font: FontStyle(family: .poppins, type: .medium, size: .pt16))
        categoryButton.configureButtonWithTitle(title: LocalizedStrings.selectSubCategory, titleColor: .white, backgroundColor: AppColor.primaryColor, font: FontStyle(family: .poppins, type: .light, size: .pt14))
        self.imageView.layer.cornerRadius = 5
        self.imageView.backgroundColor = AppColor.primaryColor
        // self.locationButton.isHidden = true
    }
    
    private func setupTextField() {
       // peopleCountTextField.configureTextField(text: LocalizedStrings.numberOfPeople, color: .white, font: FontStyle(family: .poppins, type: .light, size: .pt14), delegate: self)
        buildingNameTextField.configureTextField(text: LocalizedStrings.buildingNumber, color: .white, font: FontStyle(family: .poppins, type: .light, size: .pt14), delegate: self)
    }
    
    private func setupTextView() {
        locationTextField.font = UIFont.poppins(font: .light, size: .pt14)
        descriptionTextField.font = UIFont.poppins(font: .light, size: .pt14)
        locationTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
}

// MARK: - Action Handler

extension ConcernRequestViewController {
    
    @IBAction func submitButtonClick(_ sender: Any) {
        if validateInputField() {
            callAddRequestAPI()
        }
    }
    
    @IBAction func locationButtonClick(_ sender: Any) {
        
        if kGOOGLEMAPKEY == "" {
            kGOOGLEMAPKEY = "AIzaSyC631OGdyhCV_YsIzH0OA-fwvWLm3XWMrc"
        }
        GooglePlacesHandler.shared.provideAPIKey()

        if kGOOGLEMAPKEY != "" {
            let coordinates =  CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            showLoader()

            self.callGetAddressLocationAPI(from: coordinates) {address, error in
                dismissLoader()
                if error == false {
                    self.gmsAddress = address!
                    self.stroreLocation(address: address!)
                } else {
                    showAlert(message: AlertMessage.SomethingWentWrong, inViewController: self)
                }
            }
        } else {
            showAlert(message: AlertMessage.SomethingWentWrong, inViewController: self)
        }
        
    }
    
    @IBAction func checkButtonClick(_ sender: Any) {
        if checkBoxValue == "0" {
            checkBoxValue = "0"
            self.checkButton.setImage(#imageLiteral(resourceName: "checked-checkbox-50"), for: .normal)
        } else {
            checkBoxValue = "1"
            self.checkButton.setImage(#imageLiteral(resourceName: "unchecked-checkbox-50"), for: .normal)
        }
    }
    
    @IBAction func profileButtonClick(_ sender: Any) {
        showCameraActionSheet()
    }
    
    @IBAction func categoryButtonClick(_ sender: Any) {
        pushtoCategoryView()
    }
}

// MARK: - UITextView Delegate

extension ConcernRequestViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if  textView == locationTextField {
            if textView.text == LocalizedStrings.locationOfYourComplaintMessage {
                textView.text = ""
                textView.textColor = AppColor.TextView.textColor
            }
        } else  if textView == descriptionTextField {
            if textView.text == LocalizedStrings.describeIssueMessage {
                textView.text = ""
                textView.textColor = AppColor.TextView.textColor
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if  textView == locationTextField {
            
            if textView.text == "" || textView.text == LocalizedStrings.locationOfYourComplaintMessage {
                textView.text = LocalizedStrings.locationOfYourComplaintMessage
                textView.textColor = AppColor.TextView.placeholderColor
                textView.resignFirstResponder()
            }
        }
        else  if textView == descriptionTextField {
            if textView.text == "" || textView.text == LocalizedStrings.describeIssueMessage {
                textView.text = LocalizedStrings.locationOfYourComplaintMessage
                textView.textColor = AppColor.TextView.placeholderColor
                textView.resignFirstResponder()
            }
        }
        
        
        
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newString = ((textView.text)! as NSString).replacingCharacters(in: range, with: text)
        if newString.count >= maxCharLimit {
            return false
        }
        return true
    }
    
}

// MARK: - Private Methods

extension ConcernRequestViewController {
    
    func showCameraActionSheet() {
        AttachmentHandler.shared.showAttachmentActionSheet(viewController: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            let chooseImage = image.resizeImage(targetSize: CGSize(width: 500, height: 600))
            self.imageView.setImage(chooseImage, for: .normal)
            self.didImageUploaded = true
            self.callUploadImageAPI(chooseImage, handle: { (error) in
            })
            
        }
    }
    
    private func validateInputField() -> Bool {
        
        var isValidate = true
        if self.didImageUploaded == false {
            showAlert(message: AlertMessage.uploadPictureValidation, inViewController: self)
            isValidate = false
            
        } else if (self.buildingNameTextField.text?.trim().isEmpty)! {
            showAlert(message: AlertMessage.buildingNumberDetails, inViewController: self)
            isValidate = false
         } else if (self.locationTextField.text?.elementsEqual(LocalizedStrings.locationOfYourComplaintMessage))! {
            showAlert(message: AlertMessage.locationValidation, inViewController: self)
            isValidate = false
        } else if (self.descriptionTextField.text?.elementsEqual(LocalizedStrings.describeIssueMessage))! {
            showAlert(message: AlertMessage.issueDescriptionValidation, inViewController: self)
            isValidate = false
        } else if self.categoryButton.titleLabel?.text == LocalizedStrings.selectSubCategory {
            showAlert(message: AlertMessage.subCategoryValidation, inViewController: self)
            isValidate = false
        } /* else if (self.peopleCountTextField.text?.trim().isEmpty)! {
            showAlert(message: AlertMessage.numnerOfEffectedPersonValidation, inViewController: self)
            isValidate = false
        } */
        return isValidate
    }
    
    func pushtoCategoryView() {
        let storyborad = UIStoryboard(name: StoryBoardName.serviceRequest.rawValue, bundle: nil)
        let categoryViewController = storyborad.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
        
        categoryViewController?.actionCompletionHandler { (message, error) in
            if error == false {
                self.categoryButton.setTitle(message.catName, for: .normal)
                self.descriptionTextField.text = message.catName
            } else {
                showAlert(message: "Error", inViewController: self)
            }
        }
        self.navigationController?.pushViewController(categoryViewController!, animated: true)
    }
    
    func stroreLocation(address: GMSAddress) {
        let addressLine = address.lines?[0] ?? ""
        let thoroughfare = address.thoroughfare ?? ""
        let postalCode = address.postalCode ?? ""
        let formattedAddress = addressLine + " " + thoroughfare + " " + postalCode
        self.locationTextField.text = formattedAddress
    }
    
}
// MARK: - WebServices

extension ConcernRequestViewController {
    
    private func callUploadImageAPI(_ image: UIImage, handle:@escaping (Bool) -> Void) {
        
        showLoader()
        
        let imagedata = image.jpegData(compressionQuality: 1)
        
        let baseURL = APPURL.baseUrl()
        let url =  String(format: "%@%@", baseURL, APIEndpoint.uploadComplaintImage)
        
        let parameter: NSDictionary = ["ImgKey": imagedata as Any]
        
        let otherImages: [NSDictionary] = [["ImgKey": "photo", "ImgData": image]]
        
        ServiceRequestClient.uploadImageWithParameters(url: URL(string: url)!, parameters: parameter, otherImages: otherImages) { (dict, error, status) in
            print(dict as Any)
            dismissLoader()
            self.didImageUploaded = true
            print(dict as Any)
            self.imageId = dict!["photo"] as! String
        }
    }
    
    private func callAddRequestAPI() {
        self.addRequest()
    }
    
    func addRequest() {
        
        let coordinates =  CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let userId = SessionData.userId
        let photourl = self.imageId
        let requestModel = RequestModel(locationlat: coordinates.latitude.description,
                                        locationlong: coordinates.longitude.description,
                                        address: self.gmsAddress.lines?[0] ?? "",
                                        city: self.gmsAddress.locality,
                                        state: self.gmsAddress.subLocality,
                                        message: self.descriptionTextField.text,
                                        status: "0",
                                        uid: userId,
                                        buildingname: self.buildingNameTextField.text,
                                        category: self.categoryButton.titleLabel?.text,
                                        peopleaffected: "",
                                        showchkbox: self.checkBoxValue,
                                        photo: photourl,
                                        request_type: "addenquiery")
        
        
        let baseURL = "http://www.firetechcorporation.com/fireadmin/api/"
        let url =  String(format: "%@", baseURL)
        let urlwithPercent = url.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let urlPath = urlwithPercent
        let methodType = "POST" //as you want
        let params: [String: String] = requestModel.convertToDictionary(data: requestModel.serialize()) as! [String: String]
        
        showLoader()
        ServiceRequestClient.serviceRequest(url:urlPath!, method:methodType, controller:self, parameters:params) {
            response in
            switch response.result {
            case .success(let value):
                print(value)
                do {
                    if let data = response.data,
                       let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                       let dict = json.object(forKey: "message") as? NSDictionary,
                       let message = dict.object(forKey: "message") as? String {
                        showAlert(title: AlertMessage.success, message: message, inViewController: self)
                        self.navigationController?.popViewController(animated: true)
                        dismissLoader()
                    }
                } catch {
                    print("Failed to load: \(error.localizedDescription)")
                    dismissLoader()
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                showAlert(message: "No response", inViewController: self)
                dismissLoader()
            }
        }
    }
    
    func callGetAddressLocationAPI(from locationCoordinate: CLLocationCoordinate2D, completionHandler: @escaping (GMSAddress?, Bool) -> Void) {
        GooglePlacesHandler.shared.googleMapsiOSSDKReverseGeocoding(from: locationCoordinate) { (gmsReverseGeocodeResponse, error) in
            if error != nil {
                completionHandler(nil, true)
            } else {
                guard let gmsReverseGeocodeResponse = gmsReverseGeocodeResponse else {
                    return
                }
                let gmsAddress: GMSAddress = gmsReverseGeocodeResponse.firstResult()!
                completionHandler(gmsAddress, false)
            }
        }
    }
    
}
