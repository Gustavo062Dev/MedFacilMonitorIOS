import SwiftUI
struct StoreCard: View {
 let store:SyncStore
 var status:StoreStatus { store.status() }
 var body: some View { VStack(spacing:12){ HStack{Image(systemName:status.icon).foregroundStyle(status.color); Spacer(); Text(status.badgeTitle).font(.caption2.bold()).foregroundStyle(AppTheme.background).padding(.horizontal,9).padding(.vertical,5).background(status.color,in:Capsule())}; Text(store.code).font(.system(size:34,weight:.black,design:.rounded)).foregroundStyle(.white).lineLimit(1).minimumScaleFactor(0.65); VStack(spacing:4){Text("\(Formatters.number(store.pendingRevisions)) revisões").font(.caption.weight(.semibold)).foregroundStyle(.white); Text(Formatters.relativeDate(store.lastCommunicationAt)).font(.caption2).foregroundStyle(AppTheme.textSecondary).lineLimit(1)} }.padding(15).frame(maxWidth:.infinity,minHeight:150).background(status.color.opacity(0.12),in:RoundedRectangle(cornerRadius:16)).overlay{RoundedRectangle(cornerRadius:16).stroke(status.color,lineWidth:1.5)} }
}
