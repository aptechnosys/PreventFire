import Foundation
struct Catinfo: Codable {
	let catId: String?
	let catName: String?
	let catFile: String?
	let success: Bool?

	enum CodingKeys: String, CodingKey {

		case catId = "cat_id"
		case catName = "cat_name"
		case catFile = "cat_file"
		case success = "success"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		catId = try values.decodeIfPresent(String.self, forKey: .catId)
		catName = try values.decodeIfPresent(String.self, forKey: .catName)
		catFile = try values.decodeIfPresent(String.self, forKey: .catFile)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
	}

}
