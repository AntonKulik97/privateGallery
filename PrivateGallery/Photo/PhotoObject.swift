
import Foundation

class PhotoObject: NSObject,Codable{
    var photo: String?
    var isFavorite: Bool?
    var comment: String?
    
    init(isFavorite: Bool, comment: String, photo: String) {
        self.photo = photo
        self.isFavorite = isFavorite
        self.comment = comment
    }
    
    public override init() {}

    public enum CodingKeys: String, CodingKey {
        case photo, isFavorite, comment
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.photo, forKey: .photo)
        try container.encode(self.isFavorite, forKey: .isFavorite)
        try container.encode(self.comment, forKey: .comment)
        
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.photo = try container.decodeIfPresent(String.self, forKey: .photo) ?? ""
        self.isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment) ?? "Коментарий"
        
    }
    
}
