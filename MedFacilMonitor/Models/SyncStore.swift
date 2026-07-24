import Foundation
struct SyncStore: Codable, Identifiable, Hashable {
    let code: String
    let lastSentAtRaw: String?
    let lastReceivedAtRaw: String?
    let pendingRevisions: Int
    var id: String { code }
    enum CodingKeys: String, CodingKey {
        case code = "codigo"
        case lastSentAtRaw = "datahoraultimoenvio"
        case lastReceivedAtRaw = "datahoraultimorecebimento"
        case pendingRevisions = "revisoesaenviar"
    }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        if let s = try? c.decode(String.self, forKey: .code) { code=s }
        else if let i = try? c.decode(Int.self, forKey: .code) { code=String(i) }
        else { code="-" }
        lastSentAtRaw = try? c.decodeIfPresent(String.self, forKey: .lastSentAtRaw)
        lastReceivedAtRaw = try? c.decodeIfPresent(String.self, forKey: .lastReceivedAtRaw)
        if let i = try? c.decode(Int.self, forKey: .pendingRevisions) { pendingRevisions=i }
        else if let s = try? c.decode(String.self, forKey: .pendingRevisions), let i=Int(s) { pendingRevisions=i }
        else { pendingRevisions=0 }
    }
    var lastCommunicationAt: Date? { [lastSentAtRaw,lastReceivedAtRaw].compactMap(DateParser.parse).max() }
    func status(now: Date = Date()) -> StoreStatus {
        guard let lastCommunicationAt else { return .offline }
        if now.timeIntervalSince(lastCommunicationAt)/60 >= 15 { return .offline }
        if pendingRevisions > 1000 { return .warning }
        return .active
    }
}
