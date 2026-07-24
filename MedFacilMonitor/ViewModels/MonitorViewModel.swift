import Foundation
import Combine
@MainActor
final class MonitorViewModel: ObservableObject {
    @Published private(set) var stores:[SyncStore]=[]
    @Published private(set) var isLoading=false
    @Published private(set) var isRefreshing=false
    @Published private(set) var lastUpdatedAt:Date?
    @Published var errorMessage:String?
    @Published var searchText=""
    @Published var selectedFilter:StoreStatus = .all
    private let service:SyncServiceProtocol
    private var refreshTask:Task<Void,Never>?
    init(service:SyncServiceProtocol=SyncService()){ self.service=service }
    deinit { refreshTask?.cancel() }
    var filteredStores:[SyncStore] { stores.filter { s in (searchText.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty || s.code.localizedCaseInsensitiveContains(searchText)) && (selectedFilter == .all || s.status() == selectedFilter) } }
    var activeCount:Int { stores.filter{$0.status()==.active}.count }
    var warningCount:Int { stores.filter{$0.status()==.warning}.count }
    var offlineCount:Int { stores.filter{$0.status()==.offline}.count }
    func start(){ guard refreshTask==nil else{return}; refreshTask=Task{[weak self] in guard let self else{return}; await self.refresh(showLoading:true); while !Task.isCancelled { try? await Task.sleep(for:.seconds(30)); if Task.isCancelled{break}; await self.refresh() } } }
    func refresh(showLoading:Bool=false) async {
        guard !isRefreshing else{return}; isRefreshing=true; if showLoading && stores.isEmpty { isLoading=true }; errorMessage=nil
        defer { isRefreshing=false; isLoading=false }
        do { let result=try await service.fetchStores(); stores=result.sorted{ (Int($0.code) ?? .max) < (Int($1.code) ?? .max) }; lastUpdatedAt=Date() } catch { errorMessage=error.localizedDescription }
    }
}
