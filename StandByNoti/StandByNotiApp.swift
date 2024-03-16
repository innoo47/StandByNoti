//
//  StandByNotiApp.swift
//  StandByNoti
//
//  Created by 박인호 on 3/16/24.
//

import SwiftUI
import WidgetKit

@main
struct StandByNotiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct NotificationWidget: Widget {
    let kind: String = "NotificationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NotificationWidgetView(viewModel: NotificationWidgetViewModel())
        }
        .configurationDisplayName("알림 위젯")
        .description("이 위젯은 알림 로그를 표시합니다.")
        .supportedFamilies([.systemSmall])
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), notifications: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), notifications: NotificationWidgetViewModel().notifications)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(date: Date(), notifications: NotificationWidgetViewModel().notifications)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let notifications: [NotificationItem]
}
