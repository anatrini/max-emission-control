#pragma once

#include "ext.h"
#include <string>
#include <map>
#include <vector>

#ifdef __OBJC__
@class NSWindow;
@class NSTableView;
#else
typedef struct objc_object NSWindow;
typedef struct objc_object NSTableView;
#endif

namespace ec2 {

struct ParameterInfo {
    std::string name;
    std::string category;
    double value;
    double min;
    double max;
    std::string description;
    bool isInt;
};

class ParameterWindow {
public:
    ParameterWindow(t_object* owner);
    ~ParameterWindow();

    void openWindow();
    void closeWindow();
    bool isVisible() const;

    void updateParameter(const std::string& name, double value);
    void updateAllParameters(const std::vector<ParameterInfo>& params);

private:
    t_object* mOwner;
    NSWindow* mWindow;
    NSTableView* mTableView;
    std::vector<ParameterInfo> mParameters;
};

} // namespace ec2
