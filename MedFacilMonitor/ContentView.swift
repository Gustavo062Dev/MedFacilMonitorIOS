import SwiftUI
struct ContentView: View {
 @StateObject private var viewModel=MonitorViewModel()
 var body: some View { NavigationStack{ZStack{AppTheme.background.ignoresSafeArea();if viewModel.isLoading{VStack(spacing:16){ProgressView().controlSize(.large).tint(AppTheme.success);Text("Carregando sincronizações...").foregroundStyle(.white)}}else{DashboardView(viewModel:viewModel)}}.toolbarBackground(AppTheme.background,for:.navigationBar).toolbarBackground(.visible,for:.navigationBar).toolbarColorScheme(.dark,for:.navigationBar).toolbar{ToolbarItem(placement:.principal){HStack{Image(systemName:"waveform.path.ecg").foregroundStyle(AppTheme.accent);Text("MedFácil Monitor").font(.headline).foregroundStyle(.white)}};ToolbarItem(placement:.topBarTrailing){Button{Task{await viewModel.refresh()}}label:{if viewModel.isRefreshing{ProgressView().tint(.white)}else{Image(systemName:"arrow.clockwise").foregroundStyle(.white)}}.disabled(viewModel.isRefreshing)}}}.preferredColorScheme(.dark).task{viewModel.start()} }
}
#Preview { ContentView() }
