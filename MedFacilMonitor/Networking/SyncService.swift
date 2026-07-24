import Foundation
protocol SyncServiceProtocol { func fetchStores() async throws -> [SyncStore] }
final class SyncService: SyncServiceProtocol {
    private let endpoint = "https://medfacilapi.somee.com/api/Sincronizacao"
    func fetchStores() async throws -> [SyncStore] {
        guard let url=URL(string:endpoint) else { throw APIError.invalidURL }
        var req=URLRequest(url:url); req.httpMethod="GET"; req.timeoutInterval=30; req.cachePolicy=.reloadIgnoringLocalAndRemoteCacheData; req.setValue("application/json", forHTTPHeaderField:"Accept")
        do {
            let (data,response)=try await URLSession.shared.data(for:req)
            guard let http=response as? HTTPURLResponse else { throw APIError.invalidResponse }
            guard (200...299).contains(http.statusCode) else { throw APIError.httpStatus(http.statusCode) }
            do { return try JSONDecoder().decode([SyncStore].self, from:data) } catch { throw APIError.decoding }
        } catch let e as APIError { throw e } catch { throw APIError.network(error) }
    }
}
