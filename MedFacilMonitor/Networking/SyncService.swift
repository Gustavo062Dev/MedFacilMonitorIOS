import Foundation

protocol SyncServiceProtocol {
    func fetchStores() async throws -> [SyncStore]
}

final class SyncService: SyncServiceProtocol {
    private let endpoint =
        "https://medfacilapi.somee.com/api/Sincronizacao"

    func fetchStores() async throws -> [SyncStore] {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.cachePolicy =
            .reloadIgnoringLocalAndRemoteCacheData

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        do {
            let (data, response) =
                try await URLSession.shared.data(
                    for: request
                )

            guard let httpResponse =
                response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(
                httpResponse.statusCode
            ) else {
                throw APIError.httpStatus(
                    httpResponse.statusCode
                )
            }

            do {
                return try JSONDecoder().decode(
                    [SyncStore].self,
                    from: data
                )
            } catch {
                throw APIError.decoding
            }

        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.network(error)
        }
    }
}