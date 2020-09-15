#import "TaskListPlugin.h"
#if __has_include(<task_list/task_list-Swift.h>)
#import <task_list/task_list-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "task_list-Swift.h"
#endif

@implementation TaskListPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTaskListPlugin registerWithRegistrar:registrar];
}
@end
