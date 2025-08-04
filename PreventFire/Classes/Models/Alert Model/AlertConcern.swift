import Foundation
struct AlertConcern: Codable {
	let enquiryId: String?
	let enquiryName: String?
	let email: String?
	let profilephoto: String?
	let profilename: String?
	let message: String?
	let address: String?
	let lat: String?
	let long: String?
	let bldgname: String?
	let peopleaffected: String?
	let photo: String?
    let mapimage: String?
    let status: String?
	let titleofnoti: String?

	enum CodingKeys: String, CodingKey {

		case enquiryId = "enquiry_id"
		case enquiryName = "enquiry_name"
		case email = "email"
		case profilephoto = "profilephoto"
		case profilename = "profilename"
		case message = "message"
		case address = "address"
		case lat = "lat"
		case long = "long"
		case bldgname = "bldgname"
		case peopleaffected = "peopleaffected"
		case photo = "photo"
		case mapimage = "mapimage"
		case status = "status"
		case titleofnoti = "titleofnoti"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		enquiryId = try values.decodeIfPresent(String.self, forKey: .enquiryId)
		enquiryName = try values.decodeIfPresent(String.self, forKey: .enquiryName)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		profilephoto = try values.decodeIfPresent(String.self, forKey: .profilephoto)
		profilename = try values.decodeIfPresent(String.self, forKey: .profilename)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		long = try values.decodeIfPresent(String.self, forKey: .long)
		bldgname = try values.decodeIfPresent(String.self, forKey: .bldgname)
		peopleaffected = try values.decodeIfPresent(String.self, forKey: .peopleaffected)
		photo = try values.decodeIfPresent(String.self, forKey: .photo)
		mapimage = try values.decodeIfPresent(String.self, forKey: .mapimage)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		titleofnoti = try values.decodeIfPresent(String.self, forKey: .titleofnoti)
	}

}
