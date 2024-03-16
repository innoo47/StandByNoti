import SwiftUI
import WidgetKit

// 모델
struct NotificationItem {
    var title: String
    var body: String
}

// 뷰모델
class NotificationWidgetViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    
    // 알림 로그를 가져와 뷰모델의 데이터를 업데이트하는 함수
    func fetchNotifications() {
        // 실제 알림 로그를 가져오는 로직을 구현
        // 여기에서는 임시 데이터를 사용하겠습니다.
        self.notifications = [
            NotificationItem(title: "새 메시지", body: "안녕하세요!"),
            NotificationItem(title: "미팅 알림", body: "오늘 오후 2시에 미팅이 있습니다."),
            NotificationItem(title: "앱 업데이트", body: "새로운 기능이 추가된 앱이 있습니다."),
        ]
    }
}

// 뷰
struct NotificationWidgetView: View {
    @ObservedObject var viewModel: NotificationWidgetViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("알림 로그")
                .font(.headline)
                .padding()
            ForEach(viewModel.notifications, id: \.title) { notification in
                VStack(alignment: .leading, spacing: 5) {
                    Text(notification.title)
                        .font(.subheadline)
                        .bold()
                    Text(notification.body)
                        .font(.body)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            // 뷰가 나타날 때 알림 로그를 가져옴
            viewModel.fetchNotifications()
        }
    }
}

struct NotificationWidget_Previews: PreviewProvider {
    static var previews: some View {
        NotificationWidgetView(viewModel: NotificationWidgetViewModel())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
