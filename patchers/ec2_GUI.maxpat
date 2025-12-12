{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 1,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 62.0, 118.0, 1000.0, 830.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Ableton Sans Medium",
                    "fontsize": 9.5,
                    "id": "obj-125",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 18.0, 338.0, 122.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 17.0, 371.0, 126.5, 18.0 ],
                    "text": "Channel weights (3)",
                    "textcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "fontface": 3,
                    "fontsize": 14.0,
                    "id": "obj-124",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1188.0, 696.0, 185.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 200.0, 128.0, 22.0 ],
                    "text": "Spatial Allocation",
                    "textcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-123",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 7.0, 595.0, 150.0, 33.0 ],
                    "text": "TODO: exclude spiral and pendulum if not selected"
                }
            },
            {
                "box": {
                    "id": "obj-121",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 186.0, 497.0, 78.0, 22.0 ],
                    "text": "/trajshape $1"
                }
            },
            {
                "box": {
                    "id": "obj-118",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 455.5, 614.0, 120.0, 22.0 ],
                    "presentation_linecount": 2,
                    "text": "/pendulum_decay $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-119",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 455.5, 556.0, 53.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 349.0, 340.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.1 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[24]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Pendulum",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[25]"
                }
            },
            {
                "box": {
                    "id": "obj-116",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 358.5, 614.0, 94.0, 22.0 ],
                    "presentation_linecount": 2,
                    "text": "/spiral_factor $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-117",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 359.0, 556.0, 53.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 286.0, 340.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[23]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Spiral",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[24]"
                }
            },
            {
                "box": {
                    "id": "obj-114",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 455.0, 525.0, 75.0, 22.0 ],
                    "text": "/trajdepth $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-115",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 455.0, 467.0, 54.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 233.0, 340.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[21]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Trajdepth",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[23]"
                }
            },
            {
                "box": {
                    "id": "obj-113",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 359.5, 524.0, 66.0, 22.0 ],
                    "text": "/trajrate $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "id": "obj-111",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 359.5, 467.0, 52.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 166.0, 340.0, 52.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_exponent": 3.0,
                            "parameter_longname": "live.dial[22]",
                            "parameter_mmax": 100.0,
                            "parameter_mmin": 0.01,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Trajrate",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[22]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "fontface": 1,
                    "fontsize": 12.0,
                    "id": "obj-110",
                    "maxclass": "live.menu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 186.0, 471.0, 100.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 250.0, 128.0, 18.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "tricolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_enum": [ "sine", "saw", "triangle", "random", "spiral", "pendulum" ],
                            "parameter_longname": "live.menu[1]",
                            "parameter_mmax": 5,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.menu",
                            "parameter_type": 2
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "tricolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.menu[1]"
                }
            },
            {
                "box": {
                    "id": "obj-108",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 455.0, 426.0, 77.0, 22.0 ],
                    "presentation_linecount": 2,
                    "text": "/pitchmax $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-109",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 455.0, 369.0, 54.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 359.5, 283.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_exponent": 3.0,
                            "parameter_initial": [ 20000 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[20]",
                            "parameter_mmax": 22000.0,
                            "parameter_mmin": 20.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Pitchmax",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[21]"
                }
            },
            {
                "box": {
                    "id": "obj-106",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 365.0, 426.0, 73.0, 22.0 ],
                    "presentation_linecount": 2,
                    "text": "/pitchmin $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-107",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 365.0, 369.0, 54.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 296.5, 283.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_exponent": 3.0,
                            "parameter_initial": [ 20.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[19]",
                            "parameter_mmax": 22000.0,
                            "parameter_mmin": 20.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Pitchmin",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[20]"
                }
            },
            {
                "box": {
                    "id": "obj-102",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.5, 427.0, 84.0, 22.0 ],
                    "text": "/spatialcorr $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-103",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 265.5, 369.0, 54.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 233.0, 283.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[18]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Spatialcorr (3)",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[19]"
                }
            },
            {
                "box": {
                    "id": "obj-100",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 140.5, 427.0, 106.0, 22.0 ],
                    "text": "/randomspread $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-101",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 140.5, 369.0, 68.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 161.0, 283.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[17]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Rspread (3)",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[18]"
                }
            },
            {
                "box": {
                    "id": "obj-95",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 7.0, 542.0, 100.0, 22.0 ],
                    "text": "prepend /weights"
                }
            },
            {
                "box": {
                    "id": "obj-94",
                    "ignoreclick": 1,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 7.0, 429.0, 50.0, 22.0 ],
                    "text": "size $1"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.125, 0.125, 0.125, 0.0 ],
                    "candycane": 16,
                    "contdata": 1,
                    "id": "obj-93",
                    "maxclass": "multislider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 7.0, 461.0, 137.0, 68.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 274.0, 128.0, 92.0 ],
                    "setminmax": [ 0.0, 1.0 ],
                    "setstyle": 1,
                    "size": 16,
                    "spacing": 1
                }
            },
            {
                "box": {
                    "id": "obj-91",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 455.0, 324.0, 84.0, 22.0 ],
                    "text": "/spatialcorr $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-89",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 455.0, 266.0, 54.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 349.0, 230.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[16]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Spatialcorr (2)",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[17]"
                }
            },
            {
                "box": {
                    "id": "obj-87",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 339.0, 324.0, 106.0, 22.0 ],
                    "text": "/randomspread $1"
                }
            },
            {
                "box": {
                    "id": "obj-85",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 7,
                    "outlettype": [ "", "", "", "", "", "", "" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 1,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 422.0, 180.0, 541.0, 602.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-36",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 370.0, 522.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-35",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 322.0, 522.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-34",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 281.0, 522.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-33",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 236.0, 522.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-32",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 196.0, 522.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-31",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 153.0, 522.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-30",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 113.0, 522.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "int", "int" ],
                                    "patching_rect": [ 220.5, 169.0, 29.5, 22.0 ],
                                    "text": "t i i"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-26",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 180.0, 366.0, 123.0, 22.0 ],
                                    "text": "active 1, ignoreclick 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "int" ],
                                    "patching_rect": [ 231.0, 253.0, 29.5, 22.0 ],
                                    "text": "t b i"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 220.5, 129.0, 29.5, 22.0 ],
                                    "text": "+ 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-15",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 269.0, 418.0, 123.0, 22.0 ],
                                    "text": "active 0, ignoreclick 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "int" ],
                                    "patching_rect": [ 103.0, 326.0, 29.5, 22.0 ],
                                    "text": "t b i"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 7,
                                    "outlettype": [ "", "", "", "", "", "", "" ],
                                    "patching_rect": [ 113.0, 452.0, 175.0, 22.0 ],
                                    "text": "gate 7"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 103.0, 289.0, 25.0, 22.0 ],
                                    "text": "iter"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "int" ],
                                    "patching_rect": [ 210.0, 86.0, 29.5, 22.0 ],
                                    "text": "t b i"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 103.0, 253.0, 85.0, 22.0 ],
                                    "text": "list.filter"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-4",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 103.0, 151.0, 75.0, 22.0 ],
                                    "text": "1 2 3 4 5 6 7"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 210.0, 31.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-10", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-10", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-30", 0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-31", 0 ],
                                    "source": [ "obj-12", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "source": [ "obj-12", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-33", 0 ],
                                    "source": [ "obj-12", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-34", 0 ],
                                    "source": [ "obj-12", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-35", 0 ],
                                    "source": [ "obj-12", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-36", 0 ],
                                    "source": [ "obj-12", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 0 ],
                                    "source": [ "obj-13", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "source": [ "obj-13", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 1 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-29", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 0 ],
                                    "source": [ "obj-24", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 1 ],
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-29", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 1 ],
                                    "source": [ "obj-29", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-11", 0 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 7.0, 369.0, 114.0, 22.0 ],
                    "text": "p set-active-params"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-28",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 339.0, 266.0, 54.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 286.0, 230.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[15]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Rspread (2)",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[16]"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 233.5, 324.0, 59.0, 22.0 ],
                    "text": "/rrstep $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-24",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 233.5, 266.0, 62.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 233.0, 230.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[14]",
                            "parameter_mmax": 16.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 4,
                            "parameter_shortname": "RRstep",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[15]"
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 140.5, 324.0, 80.0, 22.0 ],
                    "text": "/fixedchan $1"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-12",
                    "ignoreclick": 1,
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 140.5, 266.0, 55.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 167.0, 230.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Fixedchan",
                            "parameter_mmax": 16.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 4,
                            "parameter_shortname": "Fixedchan",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[14]"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.92549, 0.364706, 0.341176, 1.0 ],
                    "bgcolor2": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.92549, 0.364706, 0.341176, 1.0 ],
                    "bgfillcolor_color1": [ 0.92549, 0.364706, 0.341176, 1.0 ],
                    "bgfillcolor_color2": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "gradient",
                    "gradient": 1,
                    "id": "obj-10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 45.0, 324.0, 80.0, 22.0 ],
                    "text": "allocmode $1"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "fontface": 1,
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "live.menu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 7.0, 266.0, 100.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 230.0, 128.0, 18.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "tricolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_enum": [ "fixed", "round-robin", "random", "weighted", "load-balance", "pitchmap", "trajectory" ],
                            "parameter_longname": "live.menu",
                            "parameter_mmax": 6,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.menu",
                            "parameter_type": 2
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "tricolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.menu"
                }
            },
            {
                "box": {
                    "id": "obj-84",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 589.0, 796.0, 99.0, 22.0 ],
                    "text": "s #0-ec2-params"
                }
            },
            {
                "box": {
                    "id": "obj-83",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 820.0, 204.0, 111.0, 22.0 ],
                    "text": "/scanrange_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-82",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 705.5, 204.0, 103.0, 22.0 ],
                    "text": "/scanstart_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-81",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1218.0, 137.0, 113.0, 22.0 ],
                    "text": "/scanspeed_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-80",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1137.0, 137.0, 75.0, 22.0 ],
                    "text": "/pan_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-79",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1015.0, 137.0, 111.0, 22.0 ],
                    "text": "/resonance_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-66",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 912.5, 137.0, 98.0, 22.0 ],
                    "text": "/filterfreq_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-59",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 797.0, 137.0, 103.0, 22.0 ],
                    "text": "/envelope_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-58",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 706.0, 137.0, 78.0, 22.0 ],
                    "text": "/amp_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-57",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1243.0, 42.5, 102.0, 22.0 ],
                    "text": "/playback_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-56",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1137.0, 42.5, 98.0, 22.0 ],
                    "text": "/duration_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-54",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1029.0, 42.5, 97.0, 22.0 ],
                    "text": "/streams_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 900.0, 42.5, 123.0, 22.0 ],
                    "text": "/intermittency_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-52",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 809.0, 42.5, 86.0, 22.0 ],
                    "text": "/async_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 706.0, 42.5, 102.0, 22.0 ],
                    "text": "/grainrate_dev $1"
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 176.0, 188.0, 49.0, 22.0 ],
                    "text": "/pan $1"
                }
            },
            {
                "box": {
                    "id": "obj-47",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 431.0, 188.0, 85.0, 22.0 ],
                    "text": "/scanrange $1"
                }
            },
            {
                "box": {
                    "id": "obj-46",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 347.0, 188.0, 77.0, 22.0 ],
                    "text": "/scanstart $1"
                }
            },
            {
                "box": {
                    "id": "obj-45",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 253.0, 188.0, 87.0, 22.0 ],
                    "text": "/scanspeed $1"
                }
            },
            {
                "box": {
                    "id": "obj-44",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 89.0, 188.0, 85.0, 22.0 ],
                    "text": "/resonance $1"
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 7.0, 188.0, 72.0, 22.0 ],
                    "text": "/filterfreq $1"
                }
            },
            {
                "box": {
                    "id": "obj-40",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 580.0, 75.0, 77.0, 22.0 ],
                    "text": "/envelope $1"
                }
            },
            {
                "box": {
                    "id": "obj-39",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 510.0, 107.0, 52.0, 22.0 ],
                    "text": "/amp $1"
                }
            },
            {
                "box": {
                    "id": "obj-37",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 424.0, 71.0, 76.0, 22.0 ],
                    "text": "/playback $1"
                }
            },
            {
                "box": {
                    "id": "obj-35",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 347.0, 71.0, 72.0, 22.0 ],
                    "text": "/duration $1"
                }
            },
            {
                "box": {
                    "id": "obj-20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 265.0, 71.0, 71.0, 22.0 ],
                    "text": "/streams $1"
                }
            },
            {
                "box": {
                    "id": "obj-15",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 164.0, 71.0, 97.0, 22.0 ],
                    "text": "/intermittency $1"
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 95.0, 71.0, 60.0, 22.0 ],
                    "text": "/async $1"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 7.0, 71.0, 76.0, 22.0 ],
                    "text": "/grainrate $1"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-78",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1218.0, 98.0, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 242.0, 173.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[13]",
                            "parameter_mmax": 16.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[13]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-77",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 820.0, 170.0, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 358.0, 173.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[12]",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[12]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-76",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 705.5, 170.0, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 295.0, 173.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[11]",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[11]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-75",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1137.0, 98.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 169.5, 173.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[10]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[10]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-74",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1015.0, 98.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 84.5, 173.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[9]",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[9]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-73",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 912.5, 98.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.0, 173.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_exponent": 3.0,
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[8]",
                            "parameter_mmax": 11000.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[8]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-72",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 797.0, 98.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 422.5, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[7]",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[7]"
                }
            },
            {
                "box": {
                    "id": "obj-71",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 706.0, 95.0, 39.0, 22.0 ],
                    "text": "dbtoa"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-70",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 706.0, 75.0, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 358.0, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ -90.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[6]",
                            "parameter_mmax": -6.0,
                            "parameter_mmin": -90.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[6]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-69",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1243.0, 11.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 294.5, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[5]",
                            "parameter_mmax": 16.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[5]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-68",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1137.0, 11.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 238.5, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[4]",
                            "parameter_mmax": 500.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[4]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-67",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1029.0, 11.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 169.5, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[3]",
                            "parameter_mmax": 10.0,
                            "parameter_modmode": 4,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[3]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-65",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 900.0, 11.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 114.0, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[2]",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[2]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-64",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 809.0, 11.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 61.5, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[1]",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox[1]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.5764705882352941, 0.5764705882352941, 0.5764705882352941, 0.5019607843137255 ],
                    "activeslidercolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "appearance": 2,
                    "id": "obj-63",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 706.0, 12.5, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.0, 89.0, 44.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox",
                            "parameter_mmax": 250.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.numbox"
                }
            },
            {
                "box": {
                    "id": "obj-61",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 510.0, 75.0, 39.0, 22.0 ],
                    "text": "dbtoa"
                }
            },
            {
                "box": {
                    "fontface": 3,
                    "fontsize": 14.0,
                    "id": "obj-38",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1202.0, 746.0, 185.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 10.0, 164.0, 22.0 ],
                    "text": "Synthesis & Deviation",
                    "textcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-31",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 431.0, 131.0, 62.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 349.0, 121.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[13]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "ScanRange",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[13]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-30",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 347.0, 131.0, 62.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 286.0, 121.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.5 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[12]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "ScanStart",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[12]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-29",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 253.0, 131.0, 53.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 121.0, 48.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[11]",
                            "parameter_mmax": 32.0,
                            "parameter_mmin": -32.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "ScanSpeed",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[11]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-26",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 176.0, 131.0, 65.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 162.0, 121.0, 59.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[10]",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": -1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Pan (Stereo)",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[10]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-23",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 89.0, 131.0, 53.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 80.0, 121.0, 53.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[9]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Resonance",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[9]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-22",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 7.0, 131.0, 41.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 121.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_exponent": 3.0,
                            "parameter_initial": [ 1000.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[8]",
                            "parameter_mmax": 22000.0,
                            "parameter_mmin": 20.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "FilterFreq",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[8]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-19",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 580.0, 9.0, 41.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 424.0, 36.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.5 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[7]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Envelope",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[7]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-18",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 510.0, 9.0, 52.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 359.0, 36.0, 45.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[6]",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": -60.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Amplitude",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[6]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-17",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 424.0, 9.0, 41.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 296.0, 36.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[5]",
                            "parameter_mmax": 32.0,
                            "parameter_mmin": -32.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Playback",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[5]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-16",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 347.0, 9.0, 41.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 36.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[4]",
                            "parameter_mmax": 1000.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 4,
                            "parameter_shortname": "Duration",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[4]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-4",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 265.0, 9.0, 41.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 171.0, 36.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 1.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[3]",
                            "parameter_mmax": 20.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 4,
                            "parameter_shortname": "Streams",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[3]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-3",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 164.0, 9.0, 62.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 105.0, 36.0, 62.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[2]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Intermittency",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[2]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-2",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 95.0, 9.0, 41.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 63.0, 36.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial[1]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Async",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial[1]"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
                    "activeneedlecolor": [ 0.57636836783545, 0.576368229540612, 0.576368265679262, 1.0 ],
                    "fontface": 1,
                    "id": "obj-1",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 7.0, 9.0, 41.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 17.0, 36.0, 41.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": "themecolor.live_lcd_control_fg"
                        },
                        "activeneedlecolor": {
                            "expression": "themecolor.live_control_zombie"
                        },
                        "textcolor": {
                            "expression": "themecolor.live_lcd_bg"
                        },
                        "valueof": {
                            "parameter_exponent": 3.0,
                            "parameter_initial": [ 20 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.dial",
                            "parameter_mmax": 500.0,
                            "parameter_mmin": 0.1,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Grainrate",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "textcolor": [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ],
                    "varname": "live.dial"
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "bgcolor": [ 0.618934978328545, 0.744701397656435, 0.953750108255376, 1.0 ],
                    "id": "obj-36",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1238.0, 675.0, 128.0, 128.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 5.0, 5.0, 476.0, 187.0 ],
                    "proportion": 0.5,
                    "saved_attribute_attributes": {
                        "bgfillcolor": {
                            "expression": "themecolor.live_lcd_control_fg_alt"
                        }
                    }
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "bgcolor": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "id": "obj-60",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1253.0, 690.0, 128.0, 128.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 5.0, 194.0, 476.0, 201.0 ],
                    "proportion": 0.5
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-9", 0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 150.0, 459.0, 171.0, 459.0, 171.0, 644.1015625, 598.5, 644.1015625 ],
                    "source": [ "obj-100", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-100", 0 ],
                    "source": [ "obj-101", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 275.0, 459.0, 345.0, 459.0, 345.0, 645.1640625, 598.5, 645.1640625 ],
                    "source": [ "obj-102", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-102", 0 ],
                    "source": [ "obj-103", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 374.5, 462.0, 345.0, 462.0, 345.0, 643.09375, 598.5, 643.09375 ],
                    "source": [ "obj-106", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-106", 0 ],
                    "source": [ "obj-107", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 464.5, 459.0, 598.5, 459.0 ],
                    "source": [ "obj-108", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-108", 0 ],
                    "source": [ "obj-109", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-121", 0 ],
                    "source": [ "obj-110", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-113", 0 ],
                    "source": [ "obj-111", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 369.0, 549.0, 345.0, 549.0, 345.0, 645.65625, 598.5, 645.65625 ],
                    "source": [ "obj-113", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 464.5, 549.0, 519.0, 549.0, 519.0, 600.0, 598.5, 600.0 ],
                    "source": [ "obj-114", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-114", 0 ],
                    "source": [ "obj-115", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 368.0, 643.26171875, 598.5, 643.26171875 ],
                    "source": [ "obj-116", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-116", 0 ],
                    "source": [ "obj-117", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 465.0, 643.12109375, 598.5, 643.12109375 ],
                    "source": [ "obj-118", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-118", 0 ],
                    "source": [ "obj-119", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-21", 0 ],
                    "source": [ "obj-12", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 195.5, 643.6796875, 598.5, 643.6796875 ],
                    "source": [ "obj-121", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 104.5, 117.0, 504.0, 117.0, 504.0, 174.0, 598.5, 174.0 ],
                    "source": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 173.5, 117.0, 504.0, 117.0, 504.0, 174.0, 598.5, 174.0 ],
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "source": [ "obj-16", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "source": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-61", 0 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-40", 0 ],
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-14", 0 ],
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 274.5, 117.0, 504.0, 117.0, 504.0, 174.0, 598.5, 174.0 ],
                    "source": [ "obj-20", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 150.0, 357.0, 252.0, 357.0, 252.0, 459.0, 345.0, 459.0, 345.0, 644.1015625, 598.5, 644.1015625 ],
                    "source": [ "obj-21", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-43", 0 ],
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-44", 0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "source": [ "obj-24", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-49", 0 ],
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 243.0, 414.0, 261.0, 414.0, 261.0, 459.0, 345.0, 459.0, 345.0, 644.34375, 598.5, 644.34375 ],
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-87", 0 ],
                    "source": [ "obj-28", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-45", 0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-46", 0 ],
                    "source": [ "obj-30", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-47", 0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 356.5, 117.0, 504.0, 117.0, 504.0, 174.0, 598.5, 174.0 ],
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 433.5, 117.0, 504.0, 117.0, 504.0, 174.0, 598.5, 174.0 ],
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 519.5, 174.0, 598.5, 174.0 ],
                    "source": [ "obj-39", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-20", 0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 589.5, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-40", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 16.5, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-43", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 98.5, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-44", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 262.5, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-45", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 356.5, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-46", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 440.5, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-47", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 185.5, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-49", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 715.5, 66.0, 669.0, 66.0, 669.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-51", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 818.5, 84.0, 762.0, 84.0, 762.0, 123.0, 573.0, 123.0, 573.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-52", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 909.5, 84.0, 762.0, 84.0, 762.0, 123.0, 573.0, 123.0, 573.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-53", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 1038.5, 84.0, 762.0, 84.0, 762.0, 123.0, 573.0, 123.0, 573.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-54", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 1146.5, 84.0, 762.0, 84.0, 762.0, 123.0, 573.0, 123.0, 573.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-56", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 1252.5, 84.0, 762.0, 84.0, 762.0, 123.0, 573.0, 123.0, 573.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-57", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 715.5, 162.0, 598.5, 162.0 ],
                    "source": [ "obj-58", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 806.5, 189.0, 598.5, 189.0 ],
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-39", 0 ],
                    "source": [ "obj-61", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-51", 0 ],
                    "source": [ "obj-63", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 0 ],
                    "source": [ "obj-64", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-53", 0 ],
                    "source": [ "obj-65", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 922.0, 189.0, 942.0, 189.0, 942.0, 237.0, 636.0, 237.0, 636.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-66", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-54", 0 ],
                    "source": [ "obj-67", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-56", 0 ],
                    "source": [ "obj-68", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-57", 0 ],
                    "source": [ "obj-69", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-10", 0 ],
                    "order": 0,
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-85", 0 ],
                    "order": 1,
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-71", 0 ],
                    "source": [ "obj-70", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-58", 0 ],
                    "source": [ "obj-71", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-59", 0 ],
                    "source": [ "obj-72", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-66", 0 ],
                    "source": [ "obj-73", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-79", 0 ],
                    "source": [ "obj-74", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-80", 0 ],
                    "source": [ "obj-75", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-82", 0 ],
                    "source": [ "obj-76", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-83", 0 ],
                    "source": [ "obj-77", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-81", 0 ],
                    "source": [ "obj-78", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 1024.5, 237.0, 636.0, 237.0, 636.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-79", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 1146.5, 237.0, 636.0, 237.0, 636.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-80", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 1227.5, 237.0, 636.0, 237.0, 636.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-81", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 715.0, 228.0, 636.0, 228.0, 636.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-82", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 829.5, 237.0, 636.0, 237.0, 636.0, 222.0, 598.5, 222.0 ],
                    "source": [ "obj-83", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-101", 0 ],
                    "midpoints": [ 64.0, 402.0, 135.0, 402.0, 135.0, 366.0, 150.0, 366.0 ],
                    "order": 1,
                    "source": [ "obj-85", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-103", 0 ],
                    "midpoints": [ 64.0, 402.0, 135.0, 402.0, 135.0, 366.0, 275.0, 366.0 ],
                    "order": 0,
                    "source": [ "obj-85", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-107", 0 ],
                    "midpoints": [ 95.66666666666667, 417.0, 219.0, 417.0, 219.0, 366.0, 374.5, 366.0 ],
                    "order": 1,
                    "source": [ "obj-85", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-109", 0 ],
                    "midpoints": [ 95.66666666666667, 417.0, 219.0, 417.0, 219.0, 366.0, 464.5, 366.0 ],
                    "order": 0,
                    "source": [ "obj-85", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-110", 0 ],
                    "midpoints": [ 111.5, 447.0, 135.0, 447.0, 135.0, 456.0, 156.0, 456.0, 156.0, 468.0, 195.5, 468.0 ],
                    "order": 4,
                    "source": [ "obj-85", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-111", 0 ],
                    "midpoints": [ 111.5, 447.0, 135.0, 447.0, 135.0, 456.0, 156.0, 456.0, 156.0, 462.0, 369.0, 462.0 ],
                    "order": 3,
                    "source": [ "obj-85", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-115", 0 ],
                    "midpoints": [ 111.5, 447.0, 135.0, 447.0, 135.0, 456.0, 156.0, 456.0, 156.0, 462.0, 464.5, 462.0 ],
                    "order": 1,
                    "source": [ "obj-85", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-117", 0 ],
                    "midpoints": [ 111.5, 447.0, 135.0, 447.0, 135.0, 456.0, 156.0, 456.0, 156.0, 552.0, 368.5, 552.0 ],
                    "order": 2,
                    "source": [ "obj-85", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-119", 0 ],
                    "midpoints": [ 111.5, 447.0, 135.0, 447.0, 135.0, 456.0, 156.0, 456.0, 156.0, 552.0, 465.0, 552.0 ],
                    "order": 0,
                    "source": [ "obj-85", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-12", 0 ],
                    "midpoints": [ 16.5, 393.0, 3.0, 393.0, 3.0, 294.0, 126.0, 294.0, 126.0, 261.0, 150.0, 261.0 ],
                    "source": [ "obj-85", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "midpoints": [ 32.333333333333336, 402.0, 126.0, 402.0, 126.0, 252.0, 243.0, 252.0 ],
                    "source": [ "obj-85", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "midpoints": [ 48.16666666666667, 402.0, 126.0, 402.0, 126.0, 252.0, 348.5, 252.0 ],
                    "order": 1,
                    "source": [ "obj-85", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-89", 0 ],
                    "midpoints": [ 48.16666666666667, 402.0, 126.0, 402.0, 126.0, 252.0, 464.5, 252.0 ],
                    "order": 0,
                    "source": [ "obj-85", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-94", 0 ],
                    "midpoints": [ 64.0, 414.0, 16.5, 414.0 ],
                    "order": 2,
                    "source": [ "obj-85", 3 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 348.5, 366.0, 598.5, 366.0 ],
                    "source": [ "obj-87", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-91", 0 ],
                    "source": [ "obj-89", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.9529411764705882, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 16.5, 117.0, 504.0, 117.0, 504.0, 174.0, 598.5, 174.0 ],
                    "source": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 464.5, 357.0, 598.5, 357.0 ],
                    "source": [ "obj-91", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-95", 0 ],
                    "source": [ "obj-93", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-93", 0 ],
                    "source": [ "obj-94", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.6196078431372549, 0.7450980392156863, 0.7843137254901961, 1.0 ],
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 16.5, 582.0, 345.0, 582.0, 345.0, 644.7890625, 598.5, 644.7890625 ],
                    "source": [ "obj-95", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-1": [ "live.dial", "Grainrate", 0 ],
            "obj-101": [ "live.dial[17]", "Rspread (3)", 0 ],
            "obj-103": [ "live.dial[18]", "Spatialcorr (3)", 0 ],
            "obj-107": [ "live.dial[19]", "Pitchmin", 0 ],
            "obj-109": [ "live.dial[20]", "Pitchmax", 0 ],
            "obj-110": [ "live.menu[1]", "live.menu", 0 ],
            "obj-111": [ "live.dial[22]", "Trajrate", 0 ],
            "obj-115": [ "live.dial[21]", "Trajdepth", 0 ],
            "obj-117": [ "live.dial[23]", "Spiral", 0 ],
            "obj-119": [ "live.dial[24]", "Pendulum", 0 ],
            "obj-12": [ "Fixedchan", "Fixedchan", 0 ],
            "obj-16": [ "live.dial[4]", "Duration", 0 ],
            "obj-17": [ "live.dial[5]", "Playback", 0 ],
            "obj-18": [ "live.dial[6]", "Amplitude", 0 ],
            "obj-19": [ "live.dial[7]", "Envelope", 0 ],
            "obj-2": [ "live.dial[1]", "Async", 0 ],
            "obj-22": [ "live.dial[8]", "FilterFreq", 0 ],
            "obj-23": [ "live.dial[9]", "Resonance", 0 ],
            "obj-24": [ "live.dial[14]", "RRstep", 0 ],
            "obj-26": [ "live.dial[10]", "Pan (Stereo)", 0 ],
            "obj-28": [ "live.dial[15]", "Rspread (2)", 0 ],
            "obj-29": [ "live.dial[11]", "ScanSpeed", 0 ],
            "obj-3": [ "live.dial[2]", "Intermittency", 0 ],
            "obj-30": [ "live.dial[12]", "ScanStart", 0 ],
            "obj-31": [ "live.dial[13]", "ScanRange", 0 ],
            "obj-4": [ "live.dial[3]", "Streams", 0 ],
            "obj-63": [ "live.numbox", "live.numbox", 0 ],
            "obj-64": [ "live.numbox[1]", "live.numbox", 0 ],
            "obj-65": [ "live.numbox[2]", "live.numbox", 0 ],
            "obj-67": [ "live.numbox[3]", "live.numbox", 0 ],
            "obj-68": [ "live.numbox[4]", "live.numbox", 0 ],
            "obj-69": [ "live.numbox[5]", "live.numbox", 0 ],
            "obj-7": [ "live.menu", "live.menu", 0 ],
            "obj-70": [ "live.numbox[6]", "live.numbox", 0 ],
            "obj-72": [ "live.numbox[7]", "live.numbox", 0 ],
            "obj-73": [ "live.numbox[8]", "live.numbox", 0 ],
            "obj-74": [ "live.numbox[9]", "live.numbox", 0 ],
            "obj-75": [ "live.numbox[10]", "live.numbox", 0 ],
            "obj-76": [ "live.numbox[11]", "live.numbox", 0 ],
            "obj-77": [ "live.numbox[12]", "live.numbox", 0 ],
            "obj-78": [ "live.numbox[13]", "live.numbox", 0 ],
            "obj-89": [ "live.dial[16]", "Spatialcorr (2)", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0,
        "styles": [
            {
                "name": "rnbomonokai",
                "default": {
                    "accentcolor": [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ],
                    "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "bgfillcolor": {
                        "angle": 270.0,
                        "autogradient": 0.0,
                        "color": [ 0.0, 0.0, 0.0, 1.0 ],
                        "color1": [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
                        "color2": [ 0.263682, 0.004541, 0.038797, 1.0 ],
                        "proportion": 0.39,
                        "type": "color"
                    },
                    "clearcolor": [ 0.976470588235294, 0.96078431372549, 0.917647058823529, 1.0 ],
                    "color": [ 0.611764705882353, 0.125490196078431, 0.776470588235294, 1.0 ],
                    "editing_bgcolor": [ 0.976470588235294, 0.96078431372549, 0.917647058823529, 1.0 ],
                    "elementcolor": [ 0.749019607843137, 0.83921568627451, 1.0, 1.0 ],
                    "fontname": [ "Lato" ],
                    "locked_bgcolor": [ 0.976470588235294, 0.96078431372549, 0.917647058823529, 1.0 ],
                    "stripecolor": [ 0.796078431372549, 0.207843137254902, 1.0, 1.0 ],
                    "textcolor": [ 0.129412, 0.129412, 0.129412, 1.0 ]
                },
                "parentstyle": "",
                "multi": 0
            }
        ]
    }
}