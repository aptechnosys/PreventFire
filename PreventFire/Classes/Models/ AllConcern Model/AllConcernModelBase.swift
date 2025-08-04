import Foundation
struct AllConcernModelBase : Codable {
	let status : Int?
	let resolved : [Resolved]?
	let unresolved : [Resolved]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case resolved = "resolved"
		case unresolved = "unresolved"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		resolved = try values.decodeIfPresent([Resolved].self, forKey: .resolved)
		unresolved = try values.decodeIfPresent([Resolved].self, forKey: .unresolved)
	}

}
