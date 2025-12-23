/**
 * ec2_param_window.mm
 * Native Cocoa parameter window implementation (like spat5)
 */

#include "ec2_param_window.h"
#import <Cocoa/Cocoa.h>

@interface EC2ParamDataSource : NSObject <NSTableViewDataSource, NSTableViewDelegate>
{
    std::vector<ec2::ParameterInfo>* parameters;
    t_object* owner;
}
- (id)initWithParameters:(std::vector<ec2::ParameterInfo>*)params owner:(t_object*)obj;
@end

@implementation EC2ParamDataSource

- (id)initWithParameters:(std::vector<ec2::ParameterInfo>*)params owner:(t_object*)obj {
    self = [super init];
    if (self) {
        parameters = params;
        owner = obj;
    }
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return parameters ? parameters->size() : 0;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (!parameters || row >= parameters->size()) return nil;

    const ec2::ParameterInfo& param = (*parameters)[row];
    NSString* identifier = [tableColumn identifier];

    if ([identifier isEqualToString:@"category"]) {
        return [NSString stringWithUTF8String:param.category.c_str()];
    } else if ([identifier isEqualToString:@"name"]) {
        return [NSString stringWithUTF8String:param.name.c_str()];
    } else if ([identifier isEqualToString:@"value"]) {
        return [NSString stringWithFormat:@"%.3f", param.value];
    } else if ([identifier isEqualToString:@"range"]) {
        return [NSString stringWithFormat:@"[%.1f - %.1f]", param.min, param.max];
    } else if ([identifier isEqualToString:@"description"]) {
        return [NSString stringWithUTF8String:param.description.c_str()];
    }

    return nil;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)value forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (!parameters || row >= parameters->size()) return;

    NSString* identifier = [tableColumn identifier];

    // Only the value column is editable
    if ([identifier isEqualToString:@"value"]) {
        ec2::ParameterInfo& param = (*parameters)[row];

        // Parse the new value
        double newValue = [value doubleValue];

        // Clamp to min/max
        newValue = std::max(param.min, std::min(param.max, newValue));

        // Update the parameter in the vector
        param.value = newValue;

        // Send the message to the ec2~ object to apply the change
        if (owner) {
            // Create atom with new value
            t_atom argv;

            if (param.isInt) {
                atom_setlong(&argv, (long)newValue);
            } else {
                atom_setfloat(&argv, newValue);
            }

            // Get the symbol for the parameter name
            t_symbol* paramSym = gensym(param.name.c_str());

            // Send the message to the object
            object_method_typed(owner, paramSym, 1, &argv, nullptr);
        }
    }
}

@end

namespace ec2 {

ParameterWindow::ParameterWindow(t_object* owner)
    : mOwner(owner), mWindow(nil), mTableView(nil) {
}

ParameterWindow::~ParameterWindow() {
    closeWindow();
}

void ParameterWindow::openWindow() {
    if (mWindow) {
        [mWindow makeKeyAndOrderFront:nil];
        return;
    }

    // Create window
    NSRect frame = NSMakeRect(100, 100, 800, 600);
    NSUInteger styleMask = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                          NSWindowStyleMaskResizable | NSWindowStyleMaskMiniaturizable;

    mWindow = [[NSWindow alloc] initWithContentRect:frame
                                          styleMask:styleMask
                                            backing:NSBackingStoreBuffered
                                              defer:NO];

    [mWindow setTitle:@"ec2~ Parameters"];
    [mWindow setReleasedWhenClosed:NO];

    // Create scroll view
    NSScrollView* scrollView = [[NSScrollView alloc] initWithFrame:[[mWindow contentView] bounds]];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    // Create table view
    mTableView = [[NSTableView alloc] initWithFrame:[[scrollView contentView] bounds]];
    [mTableView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    // Add columns
    NSTableColumn* categoryCol = [[NSTableColumn alloc] initWithIdentifier:@"category"];
    [[categoryCol headerCell] setStringValue:@"Category"];
    [categoryCol setWidth:120];
    [mTableView addTableColumn:categoryCol];

    NSTableColumn* nameCol = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    [[nameCol headerCell] setStringValue:@"Parameter"];
    [nameCol setWidth:150];
    [mTableView addTableColumn:nameCol];

    NSTableColumn* valueCol = [[NSTableColumn alloc] initWithIdentifier:@"value"];
    [[valueCol headerCell] setStringValue:@"Value"];
    [valueCol setWidth:100];
    [valueCol setEditable:YES];  // Make value column editable
    [mTableView addTableColumn:valueCol];

    NSTableColumn* rangeCol = [[NSTableColumn alloc] initWithIdentifier:@"range"];
    [[rangeCol headerCell] setStringValue:@"Range"];
    [rangeCol setWidth:150];
    [mTableView addTableColumn:rangeCol];

    NSTableColumn* descCol = [[NSTableColumn alloc] initWithIdentifier:@"description"];
    [[descCol headerCell] setStringValue:@"Description"];
    [descCol setWidth:250];
    [mTableView addTableColumn:descCol];

    // Set data source (pass owner for parameter updates)
    EC2ParamDataSource* dataSource = [[EC2ParamDataSource alloc] initWithParameters:&mParameters owner:mOwner];
    [mTableView setDataSource:dataSource];
    [mTableView setDelegate:dataSource];

    [scrollView setDocumentView:mTableView];
    [mWindow setContentView:scrollView];

    [mWindow makeKeyAndOrderFront:nil];
}

void ParameterWindow::closeWindow() {
    if (mWindow) {
        [mWindow close];
        mWindow = nil;
        mTableView = nil;
    }
}

bool ParameterWindow::isVisible() const {
    return mWindow != nil && [mWindow isVisible];
}

void ParameterWindow::updateParameter(const std::string& name, double value) {
    for (auto& param : mParameters) {
        if (param.name == name) {
            param.value = value;
            if (mTableView) {
                [mTableView reloadData];
            }
            break;
        }
    }
}

void ParameterWindow::updateAllParameters(const std::vector<ParameterInfo>& params) {
    mParameters = params;
    if (mTableView) {
        [mTableView reloadData];
    }
}

} // namespace ec2
