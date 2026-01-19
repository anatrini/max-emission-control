{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 60.0, 118.0, 530.0, 395.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontface": 3,
                    "fontsize": 16.0,
                    "id": "obj-383",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 2.0, -203.0, 154.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 2.0, 7.0, 154.0, 24.0 ],
                    "text": "EmissionControl2",
                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                    "activebgoncolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                    "activetextcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                    "activetextoncolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                    "fontname": "Arial Bold",
                    "fontsize": 16.0,
                    "id": "obj-380",
                    "maxclass": "live.text",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 46.0, -154.0, 65.0, 26.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 56.0, 65.0, 26.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activebgoncolor": {
                            "expression": ""
                        },
                        "activetextcolor": {
                            "expression": ""
                        },
                        "activetextoncolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_enum": [ "val1", "val2" ],
                            "parameter_longname": "live.text",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.text",
                            "parameter_type": 2
                        }
                    },
                    "text": "OPEN",
                    "varname": "live.text"
                }
            },
            {
                "box": {
                    "id": "obj-376",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 225.0, 107.0, 853.0, 841.0 ],
                        "openinpresentation": 1,
                        "visible": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-78",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 59.0, 119.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-21",
                                                    "index": 4,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 480.0, 409.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-20",
                                                    "index": 3,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 339.0, 409.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-19",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 480.0, 364.0, 85.0, 22.0 ],
                                                    "text": "/scanrange $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-18",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 339.0, 364.0, 77.0, 22.0 ],
                                                    "text": "/scanstart $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-16",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 197.25, 364.0, 41.0, 22.0 ],
                                                    "text": "set $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-15",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 62.0, 364.0, 41.0, 22.0 ],
                                                    "text": "set $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-12",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 197.25, 466.0, 85.0, 20.0 ],
                                                    "text": "set scanrange"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-11",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 62.0, 466.0, 85.0, 20.0 ],
                                                    "text": "set scanstart "
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-9",
                                                    "index": 2,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 197.25, 409.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "bang", "float" ],
                                                    "patching_rect": [ 230.0, 278.0, 29.5, 22.0 ],
                                                    "text": "t b f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 197.25, 329.0, 29.5, 22.0 ],
                                                    "text": "- 0."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 197.25, 231.0, 29.5, 22.0 ],
                                                    "text": "/ 1."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-5",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 62.0, 409.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 62.0, 231.0, 29.5, 22.0 ],
                                                    "text": "/ 1."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 3,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 339.0, 53.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-2",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 197.0, 53.0, 30.0, 30.0 ]
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
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 62.0, 53.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-4", 0 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-5", 0 ],
                                                    "source": [ "obj-15", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-9", 0 ],
                                                    "source": [ "obj-16", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-20", 0 ],
                                                    "source": [ "obj-18", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-21", 0 ],
                                                    "source": [ "obj-19", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-6", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-4", 1 ],
                                                    "order": 1,
                                                    "source": [ "obj-3", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-6", 1 ],
                                                    "order": 0,
                                                    "source": [ "obj-3", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-15", 0 ],
                                                    "order": 2,
                                                    "source": [ "obj-4", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-18", 0 ],
                                                    "order": 0,
                                                    "source": [ "obj-4", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-8", 0 ],
                                                    "order": 1,
                                                    "source": [ "obj-4", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-7", 0 ],
                                                    "source": [ "obj-6", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-16", 0 ],
                                                    "order": 1,
                                                    "source": [ "obj-7", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "order": 0,
                                                    "source": [ "obj-7", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-7", 1 ],
                                                    "source": [ "obj-8", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-7", 0 ],
                                                    "source": [ "obj-8", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 117.69912451505661, 2419.4692212343216, 113.00175096988676, 22.0 ],
                                    "text": "p set-scan-ops"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-60",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 468.141630589962, 2510.619671046734, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 423.5575140416622, 631.0, 202.9912089407444, 24.0 ],
                                    "text": "Load Buffer",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-38",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "", "float" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 59.0, 119.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-12",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "float", "float" ],
                                                    "patching_rect": [ 216.75, 210.0, 29.5, 22.0 ],
                                                    "text": "t f f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-17",
                                                    "index": 3,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 689.0, 420.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-15",
                                                    "index": 2,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 484.0, 420.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-16",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 484.0, 375.0, 41.0, 22.0 ],
                                                    "text": "set $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-14",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 242.33333333333331, 420.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-13",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 242.33333333333331, 375.0, 41.0, 22.0 ],
                                                    "text": "set $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-10",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 484.0, 268.0, 108.0, 22.0 ],
                                                    "text": "* 1."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-9",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "bang", "float" ],
                                                    "patching_rect": [ 633.0, 135.0, 29.5, 22.0 ],
                                                    "text": "t b f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 633.0, 221.0, 29.5, 22.0 ],
                                                    "text": "+ 0."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "float" ],
                                                    "patching_rect": [ 242.33333333333331, 268.0, 108.0, 22.0 ],
                                                    "text": "* 1."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 553.0, 45.00011347566215, 73.0, 20.0 ],
                                                    "text": "scanrange"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 347.0, 45.00011347566215, 73.0, 20.0 ],
                                                    "text": "scanstart"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 3,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 633.0, 40.00011347566215, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-2",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 426.0, 40.00011347566215, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-1",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 10,
                                                    "outlettype": [ "float", "list", "float", "float", "float", "float", "float", "", "int", "" ],
                                                    "patching_rect": [ 161.0, 177.0, 141.0, 22.0 ],
                                                    "text": "info~ emission"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-28",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "replace" ],
                                                    "patching_rect": [ 50.0, 100.0, 55.0, 22.0 ],
                                                    "text": "t replace"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-27",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "float", "bang" ],
                                                    "patching_rect": [ 50.0, 138.93805623054504, 130.0, 22.0 ],
                                                    "text": "buffer~ emission 100 2"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-36",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 50.00000024155426, 40.00011347566215, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "source": [ "obj-1", 6 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-16", 0 ],
                                                    "source": [ "obj-10", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-10", 1 ],
                                                    "order": 0,
                                                    "source": [ "obj-12", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-17", 0 ],
                                                    "source": [ "obj-12", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-7", 1 ],
                                                    "order": 1,
                                                    "source": [ "obj-12", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-14", 0 ],
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-15", 0 ],
                                                    "source": [ "obj-16", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-7", 0 ],
                                                    "order": 1,
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-8", 0 ],
                                                    "order": 0,
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-1", 0 ],
                                                    "source": [ "obj-27", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-27", 0 ],
                                                    "source": [ "obj-28", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-9", 0 ],
                                                    "source": [ "obj-3", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-28", 0 ],
                                                    "source": [ "obj-36", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-13", 0 ],
                                                    "source": [ "obj-7", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-10", 0 ],
                                                    "source": [ "obj-8", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-8", 1 ],
                                                    "source": [ "obj-9", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-8", 0 ],
                                                    "source": [ "obj-9", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 22.5, 2270.7966428995132, 104.0, 22.0 ],
                                    "text": "p buffer-wave-ops"
                                }
                            },
                            {
                                "box": {
                                    "activebgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "activebgoncolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "activetextcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "activetextoncolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontname": "Arial Bold",
                                    "fontsize": 16.0,
                                    "id": "obj-380",
                                    "maxclass": "live.text",
                                    "mode": 0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 22.5, 2235.398409962654, 65.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.137168675661087, 630.1681405603886, 403.7256626486778, 25.66371887922287 ],
                                    "saved_attribute_attributes": {
                                        "activebgcolor": {
                                            "expression": ""
                                        },
                                        "activebgoncolor": {
                                            "expression": ""
                                        },
                                        "activetextcolor": {
                                            "expression": ""
                                        },
                                        "activetextoncolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_enum": [ "val1", "val2" ],
                                            "parameter_longname": "live.text[1]",
                                            "parameter_mmax": 1,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "live.text",
                                            "parameter_type": 2
                                        }
                                    },
                                    "text": "LOAD",
                                    "varname": "live.text"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 3,
                                    "fontsize": 16.0,
                                    "id": "obj-24",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 608.0, 930.0, 90.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 630.973502099514, 449.55755829811096, 606.026497900486, 24.0 ],
                                    "text": "LFOs",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "fontface": 3,
                                    "fontsize": 16.0,
                                    "id": "obj-23",
                                    "linecount": 4,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 593.0, 915.0, 90.0, 78.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.274337351322174, 449.55755829811096, 614.0, 24.0 ],
                                    "text": "Spatial Allocation Parameters",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "fontface": 3,
                                    "fontsize": 16.0,
                                    "id": "obj-22",
                                    "linecount": 4,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 593.0, 915.0, 89.0, 78.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 630.973502099514, 4.0, 606.026497900486, 24.0 ],
                                    "text": "Modulation Parameters",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "fontface": 3,
                                    "fontsize": 16.0,
                                    "id": "obj-21",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 578.0, 900.0, 89.0, 60.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.274337351322174, 4.0, 614.0, 24.0 ],
                                    "text": "Synthesis Parameters",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.125, 0.125, 0.125, 0.0 ],
                                    "buffername": "emission",
                                    "gridcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 0.0 ],
                                    "id": "obj-10",
                                    "labels": 0,
                                    "maxclass": "waveform~",
                                    "numinlets": 5,
                                    "numoutlets": 6,
                                    "outlettype": [ "float", "float", "float", "float", "list", "" ],
                                    "patching_rect": [ 22.5, 2328.0, 256.0, 64.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 671.0, 1224.0, 154.0 ],
                                    "ruler": 0,
                                    "selectioncolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "setmode": 2,
                                    "vticks": 0,
                                    "waveformcolor": [ 0.19215686274509805, 0.3411764705882353, 0.4235294117647059, 0.5513502710686923 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-7",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 442.0, 698.0, 33.0, 22.0 ],
                                    "text": "front"
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
                                    "patching_rect": [ 472.0, 648.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-242",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 453.0973815917969, 2496.46037787199, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 600.0, 109.0, 24.0 ],
                                    "text": "Decay",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_pendulumdecay_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-215",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 397.34516471624374, 2463.7170124053955, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 600.0, 109.0, 24.0 ],
                                    "text": "Factor",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_spiralfactor_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-214",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 392.92038559913635, 2496.46037787199, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 510.0, 109.0, 24.0 ],
                                    "text": "Trajectory",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_trajshape_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-213",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 327.43365466594696, 2463.7170124053955, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 570.0, 109.0, 24.0 ],
                                    "text": "Depth",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_trajdepth_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-212",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 314.1593173146248, 2496.46037787199, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 540.0, 109.0, 24.0 ],
                                    "text": "Rate",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_trajrate_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-210",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 231.8584257364273, 2446.9028517603874, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 540.0, 109.0, 24.0 ],
                                    "text": "PitchMax",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_pitchmax_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-209",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 226.54869079589844, 2463.7170124053955, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 510.0, 109.0, 24.0 ],
                                    "text": "PitchMin",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_pitchmin_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-208",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 212.38939762115479, 2496.46037787199, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 570.0, 109.0, 24.0 ],
                                    "text": "Weights",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_weights_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-206",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 266.37170284986496, 2528.3187875151634, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 540.0, 109.0, 24.0 ],
                                    "text": "Correlation",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_correlation_weighted_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-207",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 246.90267473459244, 2561.9471088051796, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 510.0, 109.0, 24.0 ],
                                    "text": "Spread",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_randspread_weighted_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-205",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 144.24779921770096, 2528.3187875151634, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 540.0, 109.0, 24.0 ],
                                    "text": "Correlation",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_correlation_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-204",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 124.77877110242844, 2561.9471088051796, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 510.0, 109.0, 24.0 ],
                                    "text": "Spread",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_randomspread_label"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-203",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 11.504425704479218, 2561.9471088051796, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 510.0, 109.0, 24.0 ],
                                    "text": "Round Step",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_rrstep_label"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-202",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 169.0, 154.0, 686.0, 501.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-56",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 452.0, 101.0, 29.5, 22.0 ],
                                                    "text": "0"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-54",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "bang", "" ],
                                                    "patching_rect": [ 399.0, 59.0, 72.0, 22.0 ],
                                                    "text": "sel 6"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-51",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 399.0, 7.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-48",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 115.0, 338.0, 71.0, 22.0 ],
                                                    "text": "fromsymbol"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-41",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 115.0, 214.0, 215.0, 22.0 ],
                                                    "text": "if ($i1 == 4) || ($i1 == 5) then $i1 else 0"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-36",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 115.0, 373.0, 85.0, 22.0 ],
                                                    "text": "prepend script"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-35",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 115.0, 300.0, 25.0, 22.0 ],
                                                    "text": "iter"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "coll_data": {
                                                        "count": 3,
                                                        "data": [
                                                            {
                                                                "key": 0,
                                                                "value": [ "hide spatial_spiralfactor", "hide spatial_spiralfactor_numbox", "hide spatial_spiralfactor_label", "hide spatial_pendulumdecay", "hide spatial_pendulumdecay_numbox", "hide spatial_pendulumdecay_label" ]
                                                            },
                                                            {
                                                                "key": 4,
                                                                "value": [ "show spatial_spiralfactor", "show spatial_spiralfactor_numbox", "show spatial_spiralfactor_label", "hide spatial_pendulumdecay", "hide spatial_pendulumdecay_numbox", "hide spatial_pendulumdecay_label" ]
                                                            },
                                                            {
                                                                "key": 5,
                                                                "value": [ "hide spatial_spiralfactor", "hide spatial_spiralfactor_numbox", "hide spatial_spiralfactor_label", "show spatial_pendulumdecay", "show spatial_pendulumdecay_numbox", "show spatial_pendulumdecay_label" ]
                                                            }
                                                        ]
                                                    },
                                                    "id": "obj-20",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [ "", "", "", "" ],
                                                    "patching_rect": [ 115.0, 261.0, 95.0, 22.0 ],
                                                    "saved_object_attributes": {
                                                        "embed": 1,
                                                        "precision": 6
                                                    },
                                                    "text": "coll ui-geo-show"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-19",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 399.0, 154.0, 29.5, 22.0 ],
                                                    "text": "i"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-18",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 115.0, 437.0, 30.0, 30.0 ]
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
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 115.0, 7.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 1 ],
                                                    "order": 0,
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-41", 0 ],
                                                    "order": 1,
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-41", 0 ],
                                                    "source": [ "obj-19", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-35", 0 ],
                                                    "source": [ "obj-20", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-48", 0 ],
                                                    "source": [ "obj-35", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-18", 0 ],
                                                    "source": [ "obj-36", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-20", 0 ],
                                                    "source": [ "obj-41", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-36", 0 ],
                                                    "source": [ "obj-48", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-54", 0 ],
                                                    "source": [ "obj-51", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "source": [ "obj-54", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-56", 0 ],
                                                    "source": [ "obj-54", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-41", 0 ],
                                                    "source": [ "obj-56", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 94.0, 722.0, 85.0, 22.0 ],
                                    "text": "p set-geo-look"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-201",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 333.0, 175.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-26",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 194.0, 541.0, 85.0, 22.0 ],
                                                    "text": "prepend script"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-23",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 194.0, 592.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-21",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "hide" ],
                                                    "patching_rect": [ 70.0, 313.0, 44.0, 22.0 ],
                                                    "text": "t l hide"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-19",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 194.0, 495.0, 43.0, 22.0 ],
                                                    "text": "list.rev"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-17",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 194.0, 442.0, 53.0, 22.0 ],
                                                    "text": "pack s s"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-15",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 270.0, 392.0, 25.0, 22.0 ],
                                                    "text": "iter"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "coll_data": {
                                                        "count": 6,
                                                        "data": [
                                                            {
                                                                "key": 0,
                                                                "value": [ "spatial_fixedchan", "spatial_fixedchan_numbox", "spatial_fixedchan_label" ]
                                                            },
                                                            {
                                                                "key": 1,
                                                                "value": [ "spatial_rrstep", "spatial_rrstep_numbox", "spatial_rrstep_label" ]
                                                            },
                                                            {
                                                                "key": 2,
                                                                "value": [ "spatial_randomspread", "spatial_randomspread_numbox", "spatial_correlation", "spatial_correlation_numbox", "spatial_randomspread_label", "spatial_correlation_label" ]
                                                            },
                                                            {
                                                                "key": 3,
                                                                "value": [ "spatial_randspread_weighted", "spatial_randspread_weighted_numbox", "spatial_correlation_weighted", "spatial_correlation_weighted_numbox", "spatial_weights", "spatial_randspread_weighted_label", "spatial_correlation_weighted_label", "spatial_weights_label" ]
                                                            },
                                                            {
                                                                "key": 5,
                                                                "value": [ "spatial_pitchmin", "spatial_pitchmin_numbox", "spatial_pitchmax", "spatial_pitchmax_numbox", "spatial_pitchmin_label", "spatial_pitchmax_label" ]
                                                            },
                                                            {
                                                                "key": 6,
                                                                "value": [ "spatial_trajrate", "spatial_trajrate_numbox", "spatial_trajrate_label", "spatial_trajdepth", "spatial_trajdepth_numbox", "spatial_trajdepth_label", "spatial_trajshape", "spatial_trajshape_label" ]
                                                            }
                                                        ]
                                                    },
                                                    "id": "obj-6",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [ "", "", "", "" ],
                                                    "patching_rect": [ 270.0, 344.0, 128.0, 22.0 ],
                                                    "saved_object_attributes": {
                                                        "embed": 1,
                                                        "precision": 6
                                                    },
                                                    "text": "coll ui-scripting-names"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-29",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "int", "int" ],
                                                    "patching_rect": [ 187.0, 190.0, 29.5, 22.0 ],
                                                    "text": "t i i"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-24",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "int", "show" ],
                                                    "patching_rect": [ 198.0, 274.0, 49.0, 22.0 ],
                                                    "text": "t i show"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-11",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 70.0, 358.0, 25.0, 22.0 ],
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
                                                    "patching_rect": [ 177.0, 107.0, 29.5, 22.0 ],
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
                                                    "patching_rect": [ 70.0, 274.0, 85.0, 22.0 ],
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
                                                    "patching_rect": [ 70.0, 190.0, 75.0, 22.0 ],
                                                    "text": "0 1 2 3 4 5 6"
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
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 176.75, 39.0, 30.0, 30.0 ]
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
                                                    "destination": [ "obj-29", 0 ],
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
                                                    "destination": [ "obj-6", 0 ],
                                                    "source": [ "obj-11", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-17", 0 ],
                                                    "source": [ "obj-15", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "source": [ "obj-17", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-26", 0 ],
                                                    "source": [ "obj-19", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-11", 0 ],
                                                    "source": [ "obj-21", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-17", 1 ],
                                                    "source": [ "obj-21", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-17", 1 ],
                                                    "source": [ "obj-24", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-6", 0 ],
                                                    "source": [ "obj-24", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-23", 0 ],
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
                                                    "destination": [ "obj-21", 0 ],
                                                    "source": [ "obj-5", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-15", 0 ],
                                                    "source": [ "obj-6", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 292.0, 722.0, 99.0, 22.0 ],
                                    "text": "p set-spatial-look"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-187",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 423.8938394188881, 2532.743566632271, 110.0, 60.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 481.0, 206.0, 24.0 ],
                                    "text": "Spatial Allocation Mode",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-185",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ -3.539823293685913, 2546.9028598070145, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 518.0, 510.0, 109.0, 24.0 ],
                                    "text": "Channel",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2,
                                    "varname": "spatial_fixedchan_label"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-155",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 292.0, 759.0, 67.0, 22.0 ],
                                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                                    "text": "thispatcher"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-160",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 603.0, 576.0, 30.0, 20.0 ],
                                    "text": "3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-161",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 503.0, 606.0, 139.0, 22.0 ],
                                    "text": "/spatialcorr_weighted $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-162",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 503.0, 573.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 540.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_correlation_weighted_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-172",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 93.0, 573.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 540.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_correlation_weighted"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-173",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 603.0, 487.0, 30.0, 20.0 ],
                                    "text": "3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-174",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 503.0, 520.0, 144.0, 22.0 ],
                                    "text": "/randspread_weighted $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-175",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 503.0, 484.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 510.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_randspread_weighted_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-181",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 93.0, 484.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 510.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_randspread_weighted"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-154",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1234.0, 120.0, 73.0, 22.0 ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0,
                                        "parameter_mappable": 0
                                    },
                                    "text": "pattrstorage",
                                    "varname": "u532008869"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-149",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 1234.0, 163.0, 56.0, 22.0 ],
                                    "restore": {
                                        "amplitude": [ 0.9024683084413203 ],
                                        "amplitude_depth": [ 0.0 ],
                                        "amplitude_dev": [ 0.0 ],
                                        "amplitude_lfo": [ 0 ],
                                        "async": [ 0.11374022409635348 ],
                                        "async_depth": [ 0.0 ],
                                        "async_dev": [ 0.0 ],
                                        "async_lfo": [ 0 ],
                                        "duration": [ 482 ],
                                        "duration_depth": [ 0.0025380710659898 ],
                                        "duration_dev": [ 0 ],
                                        "duration_lfo": [ 0 ],
                                        "envelope": [ 0.22081218274111689 ],
                                        "envelope_depth": [ 0.0 ],
                                        "envelope_dev": [ 0.0 ],
                                        "envelope_lfo": [ 0 ],
                                        "filterfreq": [ 0.0 ],
                                        "filterfreq_depth": [ 0.0 ],
                                        "filterfreq_dev": [ 0 ],
                                        "filterfreq_lfo": [ 0 ],
                                        "grainrate": [ 0.1878172588832487 ],
                                        "grainrate_depth": [ 0.12944162436548223 ],
                                        "grainrate_dev": [ 0.0 ],
                                        "grainrate_lfo": [ 0 ],
                                        "intermittency": [ 0.26700374382136244 ],
                                        "intermittency_depth": [ 0.0 ],
                                        "intermittency_dev": [ 0.0 ],
                                        "intermittency_lfo": [ 0 ],
                                        "lfo1_polarity": [ 1 ],
                                        "lfo1_rate": [ 0.0 ],
                                        "lfo1_shape": [ 0 ],
                                        "lfo2_polarity": [ 0 ],
                                        "lfo2_rate": [ 0.0 ],
                                        "lfo2_shape": [ 0 ],
                                        "lfo3_polarity": [ 0 ],
                                        "lfo3_rate": [ 0.0 ],
                                        "lfo3_shape": [ 0 ],
                                        "lfo4_polarity": [ 0 ],
                                        "lfo4_rate": [ 0.0 ],
                                        "lfo4_shape": [ 0 ],
                                        "lfo5_polarity": [ 0 ],
                                        "lfo5_rate": [ 0.0 ],
                                        "lfo5_shape": [ 0 ],
                                        "lfo6_polarity": [ 0 ],
                                        "lfo6_rate": [ 0.0 ],
                                        "lfo6_shape": [ 0 ],
                                        "live.text": [ 0.0 ],
                                        "pan": [ 0.8781725888324873 ],
                                        "pan_depth": [ 0.0 ],
                                        "pan_dev": [ 0.0 ],
                                        "pan_lfo": [ 0 ],
                                        "playback": [ 32.9746192893401 ],
                                        "playback_depth": [ 0.0 ],
                                        "playback_dev": [ 0.0 ],
                                        "playback_lfo": [ 0 ],
                                        "resonance": [ 0.0 ],
                                        "resonance_depth": [ 0.0 ],
                                        "resonance_dev": [ 0.0 ],
                                        "resonance_lfo": [ 0 ],
                                        "scanrange": [ 0.005945089510538404 ],
                                        "scanrange_depth": [ 0.0 ],
                                        "scanrange_dev": [ 0.0 ],
                                        "scanrange_lfo": [ 0 ],
                                        "scanspeed": [ 29.401015228426402 ],
                                        "scanspeed_depth": [ 0.0 ],
                                        "scanspeed_dev": [ 0.0 ],
                                        "scanspeed_lfo": [ 0 ],
                                        "scanstart": [ 0.45698806566849565 ],
                                        "scanstart_depth": [ 0.0 ],
                                        "scanstart_dev": [ 0.0 ],
                                        "scanstart_lfo": [ 0 ],
                                        "spatial_allocmode": [ 4 ],
                                        "spatial_correlation": [ 0.31482033217215494 ],
                                        "spatial_correlation_numbox": [ 0.31482033217215494 ],
                                        "spatial_correlation_weighted": [ 0.0 ],
                                        "spatial_correlation_weighted_numbox": [ 0.0 ],
                                        "spatial_fixedchan": [ 0 ],
                                        "spatial_fixedchan_numbox": [ 1 ],
                                        "spatial_pendulumdecay": [ 0.0 ],
                                        "spatial_pendulumdecay_numbox": [ 0.0 ],
                                        "spatial_pitchmax": [ 0.0 ],
                                        "spatial_pitchmax_numbox": [ 0.1 ],
                                        "spatial_pitchmin": [ 0.0 ],
                                        "spatial_pitchmin_numbox": [ 0.1 ],
                                        "spatial_randomspread": [ 0.4035532994923858 ],
                                        "spatial_randomspread_numbox": [ 0.4035532994923858 ],
                                        "spatial_randspread_weighted": [ 0.0 ],
                                        "spatial_randspread_weighted_numbox": [ 0.0 ],
                                        "spatial_rrstep": [ 3 ],
                                        "spatial_rrstep_numbox": [ 4 ],
                                        "spatial_spiralfactor": [ 0.0 ],
                                        "spatial_spiralfactor_numbox": [ 0.0 ],
                                        "spatial_trajdepth": [ 0.0 ],
                                        "spatial_trajdepth_numbox": [ 0.0 ],
                                        "spatial_trajrate": [ 0.0 ],
                                        "spatial_trajrate_numbox": [ 0.01 ],
                                        "spatial_trajshape": [ 5 ],
                                        "spatial_weights": [ 0.0, 0.0 ],
                                        "streams": [ 0 ],
                                        "streams_depth": [ 0.0025380710659898 ],
                                        "streams_dev": [ 0 ],
                                        "streams_lfo": [ 0 ]
                                    },
                                    "text": "autopattr",
                                    "varname": "u742008752"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-148",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 582.0, 717.0, 47.0, 22.0 ],
                                    "text": "size $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-136",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 582.0, 831.0, 100.0, 22.0 ],
                                    "text": "prepend /weights"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "candycane": 16,
                                    "contdata": 1,
                                    "hidden": 1,
                                    "id": "obj-134",
                                    "maxclass": "multislider",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 582.0, 750.0, 72.0, 67.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 540.0, 502.0, 86.0 ],
                                    "setminmax": [ 0.0, 1.0 ],
                                    "setstyle": 1,
                                    "size": 2,
                                    "spacing": 3,
                                    "varname": "spatial_weights"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-131",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 167.0, 687.0, 78.0, 22.0 ],
                                    "text": "/trajshape $1"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-129",
                                    "items": [ "SINE", ",", "SAW", ",", "TRIANGLE", ",", "RANDOM", ",", "SPIRAL", ",", "PENDULUM" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 94.0, 646.0, 175.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 510.0, 404.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "spatial_trajshape"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-128",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1064.0, 610.0, 120.0, 22.0 ],
                                    "text": "/pendulum_decay $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-112",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1165.0, 571.0, 30.0, 20.0 ],
                                    "text": "6"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-122",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 1064.0, 568.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 600.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_pendulumdecay_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-126",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 654.0, 568.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 600.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_pendulumdecay"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-105",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1064.0, 524.0, 94.0, 22.0 ],
                                    "text": "/spiral_factor $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-92",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1165.0, 490.0, 30.0, 20.0 ],
                                    "text": "6"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-97",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 1064.0, 487.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 600.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_spiralfactor_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-103",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 654.0, 487.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 600.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_spiralfactor"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-90",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1165.0, 409.0, 30.0, 20.0 ],
                                    "text": "6"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-86",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1064.0, 444.0, 75.0, 22.0 ],
                                    "text": "/trajdepth $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-76",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 1064.0, 406.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 570.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_trajdepth_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-77",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 654.0, 406.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 570.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_trajdepth"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-70",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1165.0, 312.0, 30.0, 20.0 ],
                                    "text": "6"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-72",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1060.0, 342.0, 66.0, 22.0 ],
                                    "text": "/trajrate $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-73",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 1060.0, 309.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 540.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_trajrate_numbox"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-74",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 654.0, 342.0, 157.0, 22.0 ],
                                    "text": "expr 0.01 * pow(10000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-75",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 654.0, 309.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 540.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_trajrate"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-69",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1165.0, 217.0, 30.0, 20.0 ],
                                    "text": "5"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-68",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1165.0, 121.0, 30.0, 20.0 ],
                                    "text": "5"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-63",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1060.0, 247.0, 77.0, 22.0 ],
                                    "text": "/pitchmax $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-64",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1060.0, 214.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 540.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_pitchmax_numbox"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-65",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 654.0, 247.0, 143.0, 22.0 ],
                                    "text": "expr 0.1 * pow(5000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-67",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 654.0, 214.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 540.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_pitchmax"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-62",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1060.0, 151.0, 73.0, 22.0 ],
                                    "text": "/pitchmin $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-42",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 1060.0, 118.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 510.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_pitchmin_numbox"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-50",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 654.0, 151.0, 143.0, 22.0 ],
                                    "text": "expr 0.1 * pow(5000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-55",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 654.0, 118.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 510.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_pitchmin"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-41",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 603.0, 367.0, 30.0, 20.0 ],
                                    "text": "2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-40",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 503.0, 397.0, 84.0, 22.0 ],
                                    "text": "/spatialcorr $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-32",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 503.0, 364.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 540.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_correlation_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-33",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 93.0, 364.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 540.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_correlation"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-31",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 603.0, 278.0, 30.0, 20.0 ],
                                    "text": "2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-30",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 503.0, 311.0, 89.0, 22.0 ],
                                    "text": "/randspread $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "hidden": 1,
                                    "id": "obj-29",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 503.0, 275.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 510.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_randomspread_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "hidden": 1,
                                    "id": "obj-26",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 93.0, 275.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 510.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_randomspread"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-19",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 603.0, 197.0, 30.0, 20.0 ],
                                    "text": "1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-18",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 603.0, 121.0, 30.0, 20.0 ],
                                    "text": "0"
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
                                    "id": "obj-16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 354.0, 687.0, 80.0, 22.0 ],
                                    "text": "allocmode $1"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-8",
                                    "items": [ "FIXED", ",", "ROUND-ROBIN", ",", "RANDOM", ",", "WEIGHTED", ",", "LOAD-BALANCE", ",", "PITCHMAP", ",", "TRAJECTORY" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 292.0, 646.0, 175.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 480.0, 404.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "spatial_allocmode"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-5",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 500.0, 228.0, 59.0, 22.0 ],
                                    "text": "/rrstep $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-3",
                                    "ignoreclick": 1,
                                    "maxclass": "number",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 500.0, 194.0, 93.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 510.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_rrstep_numbox"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "hidden": 1,
                                    "id": "obj-4",
                                    "knobcolor": [ 0.666, 0.49, 0.282, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "min": 1.0,
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 93.0, 194.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 510.0, 404.0, 26.0 ],
                                    "size": 16.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_rrstep"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "hidden": 1,
                                    "id": "obj-2",
                                    "ignoreclick": 1,
                                    "maxclass": "number",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "parameter_mappable": 0,
                                    "patching_rect": [ 496.0, 118.0, 93.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 420.0, 510.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ],
                                    "varname": "spatial_fixedchan_numbox"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-315",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 496.0, 150.0, 80.0, 22.0 ],
                                    "text": "/fixedchan $1"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "hidden": 1,
                                    "id": "obj-312",
                                    "knobcolor": [ 0.666, 0.49, 0.282, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "min": 1.0,
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 89.0, 118.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 510.0, 404.0, 26.0 ],
                                    "size": 16.0,
                                    "valuepopuplabel": 1,
                                    "varname": "spatial_fixedchan"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-308",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1363.0, 2592.0, 69.0, 22.0 ],
                                    "text": "/lfo6rate $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-309",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 843.0, 2587.0, 87.0, 22.0 ],
                                    "text": "/lfo6polarity $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-310",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 738.0, 2587.0, 81.0, 22.0 ],
                                    "text": "/lfo6shape $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-305",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1363.0, 2477.0, 69.0, 22.0 ],
                                    "text": "/lfo5rate $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-306",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 843.0, 2477.0, 87.0, 22.0 ],
                                    "text": "/lfo5polarity $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-307",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 738.0, 2477.0, 81.0, 22.0 ],
                                    "text": "/lfo5shape $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-302",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1363.0, 2367.0, 69.0, 22.0 ],
                                    "text": "/lfo4rate $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-303",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 843.0, 2367.0, 87.0, 22.0 ],
                                    "text": "/lfo4polarity $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-304",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 738.0, 2367.0, 81.0, 22.0 ],
                                    "text": "/lfo4shape $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-299",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1363.0, 2255.0, 69.0, 22.0 ],
                                    "text": "/lfo3rate $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-300",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 843.0, 2255.0, 87.0, 22.0 ],
                                    "text": "/lfo3polarity $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-301",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 738.0, 2255.0, 81.0, 22.0 ],
                                    "text": "/lfo3shape $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-296",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1363.0, 2153.0, 69.0, 22.0 ],
                                    "text": "/lfo2rate $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-297",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 843.0, 2153.0, 87.0, 22.0 ],
                                    "text": "/lfo2polarity $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-298",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 738.0, 2153.0, 81.0, 22.0 ],
                                    "text": "/lfo2shape $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-295",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1363.0, 2055.0, 69.0, 22.0 ],
                                    "text": "/lfo1rate $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-294",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 843.0, 2055.0, 87.0, 22.0 ],
                                    "text": "/lfo1polarity $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-293",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 738.0, 2055.0, 81.0, 22.0 ],
                                    "text": "/lfo1shape $1"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-288",
                                    "items": [ "BIPOLAR", ",", "UNI+", ",", "UNI-" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 2550.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 630.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo6_polarity"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-289",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1363.0, 2550.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 1143.0, 630.0, 94.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-290",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 957.0, 2583.0, 163.0, 22.0 ],
                                    "text": "expr 0.001 * pow(40000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-291",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 957.0, 2550.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 835.0, 630.0, 306.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "lfo6_rate"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-292",
                                    "items": [ "SINE", ",", "SQUARE", ",", "RISE", ",", "FALL", ",", "NOISE" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 2550.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 630.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo6_shape"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-283",
                                    "items": [ "BIPOLAR", ",", "UNI+", ",", "UNI-" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 2436.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 600.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo5_polarity"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-284",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1363.0, 2436.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 1143.0, 600.0, 94.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-285",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 957.0, 2469.0, 163.0, 22.0 ],
                                    "text": "expr 0.001 * pow(40000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-286",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 957.0, 2436.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 835.0, 600.0, 306.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "lfo5_rate"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-287",
                                    "items": [ "SINE", ",", "SQUARE", ",", "RISE", ",", "FALL", ",", "NOISE" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 2436.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 600.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo5_shape"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-278",
                                    "items": [ "BIPOLAR", ",", "UNI+", ",", "UNI-" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 2328.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 570.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo4_polarity"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-279",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1363.0, 2328.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 1143.0, 570.0, 94.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-280",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 957.0, 2361.0, 163.0, 22.0 ],
                                    "text": "expr 0.001 * pow(40000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-281",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 957.0, 2328.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 835.0, 570.0, 306.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "lfo4_rate"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-282",
                                    "items": [ "SINE", ",", "SQUARE", ",", "RISE", ",", "FALL", ",", "NOISE" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 2328.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 570.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo4_shape"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-273",
                                    "items": [ "BIPOLAR", ",", "UNI+", ",", "UNI-" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 2216.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 540.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo3_polarity"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-274",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1363.0, 2216.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 1143.0, 540.0, 94.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-275",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 957.0, 2249.0, 163.0, 22.0 ],
                                    "text": "expr 0.001 * pow(40000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-276",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 957.0, 2216.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 835.0, 540.0, 306.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "lfo3_rate"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-277",
                                    "items": [ "SINE", ",", "SQUARE", ",", "RISE", ",", "FALL", ",", "NOISE" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 2216.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 540.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo3_shape"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-268",
                                    "items": [ "BIPOLAR", ",", "UNI+", ",", "UNI-" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 2115.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 510.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo2_polarity"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-269",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1363.0, 2115.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 1143.0, 510.0, 94.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-270",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 957.0, 2148.0, 163.0, 22.0 ],
                                    "text": "expr 0.001 * pow(40000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-271",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 957.0, 2115.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 835.0, 510.0, 306.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "lfo2_rate"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-272",
                                    "items": [ "SINE", ",", "SQUARE", ",", "RISE", ",", "FALL", ",", "NOISE" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 2115.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 510.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo2_shape"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-267",
                                    "items": [ "BIPOLAR", ",", "UNI+", ",", "UNI-" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 2022.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 480.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo1_polarity"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-264",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1363.0, 2022.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 1143.0, 480.0, 94.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-265",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 957.0, 2055.0, 163.0, 22.0 ],
                                    "text": "expr 0.001 * pow(40000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-266",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 957.0, 2022.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 835.0, 480.0, 306.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "lfo1_rate"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-261",
                                    "items": [ "SINE", ",", "SQUARE", ",", "RISE", ",", "FALL", ",", "NOISE" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 2022.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 480.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "lfo1_shape"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-259",
                                    "maxclass": "flonum",
                                    "maximum": 0.5,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1265.0, 1925.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 420.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "scanrange_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-258",
                                    "maxclass": "flonum",
                                    "maximum": 0.5,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1265.0, 1834.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 330.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "scanstart_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-256",
                                    "maxclass": "flonum",
                                    "maximum": 16.0,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1265.0, 1736.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 360.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "scanspeed_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-255",
                                    "maxclass": "flonum",
                                    "maximum": 1.0,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1264.0, 1642.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 390.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "pan_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-254",
                                    "maxclass": "flonum",
                                    "maximum": 0.5,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1264.0, 1550.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 300.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "resonance_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-252",
                                    "maxclass": "number",
                                    "maximum": 10000,
                                    "minimum": 0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1263.0, 1443.0, 93.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 270.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "filterfreq_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-251",
                                    "maxclass": "flonum",
                                    "maximum": 0.5,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1262.0, 1337.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 240.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "envelope_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-250",
                                    "maxclass": "flonum",
                                    "maximum": 6.0,
                                    "minimum": -60.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1262.0, 1208.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 210.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "amplitude_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-249",
                                    "maxclass": "flonum",
                                    "maximum": 16.0,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1259.0, 1107.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 180.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "playback_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-248",
                                    "maxclass": "number",
                                    "maximum": 500,
                                    "minimum": 0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1258.0, 1007.0, 93.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 150.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "duration_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-246",
                                    "maxclass": "number",
                                    "maximum": 10,
                                    "minimum": 0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1256.0, 924.0, 93.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 120.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "streams_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-245",
                                    "maxclass": "flonum",
                                    "maximum": 0.5,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1254.0, 834.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 90.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "intermittency_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-244",
                                    "maxclass": "flonum",
                                    "maximum": 0.5,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1254.0, 744.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 60.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "async_dev"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "htricolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "id": "obj-243",
                                    "maxclass": "flonum",
                                    "maximum": 250.0,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1251.0, 664.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 631.0, 30.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "varname": "grainrate_dev"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-240",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 234.0, 22.0 ],
                                                    "text": "combine /lfo id _to_scanrange @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1967.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-241",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1925.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 420.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "scanrange_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-238",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 227.0, 22.0 ],
                                                    "text": "combine /lfo id _to_scanstart @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1881.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-239",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1834.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 390.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "scanstart_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-236",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 236.0, 22.0 ],
                                                    "text": "combine /lfo id _to_scanspeed @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1783.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-237",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1736.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 360.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "scanspeed_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-234",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 198.0, 22.0 ],
                                                    "text": "combine /lfo id _to_pan @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1693.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-235",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1643.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 330.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "pan_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-232",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 234.0, 22.0 ],
                                                    "text": "combine /lfo id _to_resonance @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1596.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-233",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1550.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 300.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "resonance_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-230",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 221.0, 22.0 ],
                                                    "text": "combine /lfo id _to_filterfreq @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1489.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-231",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1443.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 270.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "filterfreq_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-228",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 227.0, 22.0 ],
                                                    "text": "combine /lfo id _to_envelope @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1371.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-229",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1337.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 240.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "envelope_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-226",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 201.0, 22.0 ],
                                                    "text": "combine /lfo id _to_amp @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1252.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-227",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1208.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 210.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "amplitude_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-224",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 225.0, 22.0 ],
                                                    "text": "combine /lfo id _to_playback @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1150.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-225",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1107.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 180.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "playback_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-222",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 221.0, 22.0 ],
                                                    "text": "combine /lfo id _to_duration @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 1041.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-223",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 1007.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 150.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "duration_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-220",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 221.0, 22.0 ],
                                                    "text": "combine /lfo id _to_streams @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 741.0, 958.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-221",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 741.0, 924.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 120.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "streams_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-218",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 246.0, 22.0 ],
                                                    "text": "combine /lfo id _to_intermittency @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 868.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-219",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 834.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 90.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "intermittency_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-216",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 478.0, 193.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 209.0, 22.0 ],
                                                    "text": "combine /lfo id _to_async @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 778.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-217",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 744.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 60.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "async_lfo"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-211",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 775.0, 353.0, 1000.0, 755.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 329.0, 275.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 329.0, 235.0, 44.0, 22.0 ],
                                                    "text": "pak s f"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 354.0, 61.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-207",
                                                    "maxclass": "newobj",
                                                    "numinlets": 3,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 70.0, 179.0, 225.0, 22.0 ],
                                                    "text": "combine /lfo id _to_grainrate @triggers 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-206",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 130.0, 29.5, 22.0 ],
                                                    "text": "+ 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-210",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "int" ],
                                                    "patching_rect": [ 173.0, 61.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 1 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-207", 1 ],
                                                    "source": [ "obj-206", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-207", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-206", 0 ],
                                                    "source": [ "obj-210", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 738.0, 698.0, 53.0, 22.0 ],
                                    "text": "p assign"
                                }
                            },
                            {
                                "box": {
                                    "align": 1,
                                    "bgcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_angle": 270.0,
                                    "bgfillcolor_color": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "bgfillcolor_color1": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "bgfillcolor_color2": [ 0.2901960784313726, 0.30980392156862746, 0.30196078431372547, 1.0 ],
                                    "bgfillcolor_proportion": 0.39,
                                    "bgfillcolor_type": "color",
                                    "elementcolor": [ 0.3764705882352941, 0.3843137254901961, 0.4, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-200",
                                    "items": [ "LFO 1", ",", "LFO 2", ",", "LFO 3", ",", "LFO 4", ",", "LFO 5", ",", "LFO 6" ],
                                    "maxclass": "umenu",
                                    "menumode": 1,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 738.0, 664.0, 100.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 730.0, 30.0, 100.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "textjustification": 1,
                                    "varname": "grainrate_lfo"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-199",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1925.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 420.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "scanrange_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-198",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1834.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 390.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "scanstart_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-197",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1736.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 360.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "scanspeed_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-196",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1643.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 330.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "pan_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-195",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1550.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 300.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "resonance_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-194",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1443.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 270.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "filterfreq_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-190",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1337.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 240.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "envelope_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-191",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1208.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 210.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "amplitude_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-192",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1107.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 180.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "playback_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-193",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 1007.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 150.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "duration_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-189",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 924.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 120.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "streams_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-188",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 834.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 90.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "intermittency_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-186",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 744.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 60.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "async_depth"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-184",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 843.0, 664.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 833.0, 30.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopup": 1,
                                    "valuepopuplabel": 1,
                                    "varname": "grainrate_depth"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-178",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 2167.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 420.0, 110.0, 24.0 ],
                                    "text": "Scanrange",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-179",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 2166.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 420.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-180",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 2166.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 420.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "scanrange"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-171",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 2076.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 390.0, 110.0, 24.0 ],
                                    "text": "Scanstart",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-176",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 2075.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 390.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-177",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 2075.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 390.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "scanstart"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-168",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1978.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 360.0, 110.0, 24.0 ],
                                    "text": "Scanspeed",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-169",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1977.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 360.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-170",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "min": -32.0,
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1977.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 360.0, 404.0, 26.0 ],
                                    "size": 64.0,
                                    "valuepopuplabel": 1,
                                    "varname": "scanspeed"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-165",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1885.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 330.0, 110.0, 24.0 ],
                                    "text": "Pan",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-166",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1884.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 330.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-167",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "min": -1.0,
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1884.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 330.0, 404.0, 26.0 ],
                                    "size": 2.0,
                                    "valuepopuplabel": 1,
                                    "varname": "pan"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-156",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1792.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 300.0, 110.0, 24.0 ],
                                    "text": "Resonance",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-163",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1791.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 300.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-164",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1791.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 300.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "resonance"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-153",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1685.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 270.0, 110.0, 24.0 ],
                                    "text": "Filterfreq",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-150",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1684.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 270.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-151",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 65.0, 1722.0, 140.0, 22.0 ],
                                    "text": "expr 20 * pow(1000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-152",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1684.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 270.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "filterfreq"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-144",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1579.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 240.0, 110.0, 24.0 ],
                                    "text": "Envelope",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-145",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1578.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 240.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-146",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1578.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 240.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "envelope"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-147",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 471.0, 1615.0, 77.0, 22.0 ],
                                    "text": "/envelope $1"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-140",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 569.0, 1450.0, 104.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 210.0, 110.0, 24.0 ],
                                    "text": "Amplitude",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-141",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1450.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 210.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-142",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 65.0, 1483.0, 362.0, 22.0 ],
                                    "text": "expr -60. + 66. * ((exp(1.9616585*$f1) - 1.) / (exp(1.9616585) - 1.))"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-143",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1450.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 210.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "amplitude"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-135",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1349.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 180.0, 110.0, 24.0 ],
                                    "text": "Playback",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-137",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1348.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 421.0, 180.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-139",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "min": -32.0,
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1348.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 180.0, 404.0, 26.0 ],
                                    "size": 64.0,
                                    "valuepopuplabel": 1,
                                    "varname": "playback"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-130",
                                    "maxclass": "number",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 472.0, 1249.0, 93.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 419.0, 150.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-132",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1250.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 150.0, 110.0, 24.0 ],
                                    "text": "Duration",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "id": "obj-133",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "min": 1.0,
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 65.0, 1249.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 150.0, 404.0, 26.0 ],
                                    "size": 1000.0,
                                    "valuepopuplabel": 1,
                                    "varname": "duration"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-127",
                                    "maxclass": "number",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 472.0, 1165.0, 93.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 419.0, 120.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-104",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1166.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 120.0, 110.0, 24.0 ],
                                    "text": "Streams",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "id": "obj-120",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "min": 1.0,
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 59.0, 1165.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 120.0, 404.0, 26.0 ],
                                    "size": 20.0,
                                    "valuepopuplabel": 1,
                                    "varname": "streams"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-100",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 1076.0, 110.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 90.0, 110.0, 24.0 ],
                                    "text": "Intermittency",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-101",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 1075.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 419.0, 90.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-102",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 63.0, 1075.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 90.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "intermittency"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-99",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 567.0, 986.0, 84.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 60.0, 110.0, 24.0 ],
                                    "text": "Async",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-96",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 471.0, 985.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 419.0, 60.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-98",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 59.0, 985.0, 404.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 60.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "async"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "id": "obj-88",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 563.0, 885.0, 84.0, 24.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 517.0, 30.0, 110.0, 24.0 ],
                                    "text": "Grainrate",
                                    "textcolor": [ 0.8156862745098039, 0.6588235294117647, 0.47058823529411764, 1.0 ],
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "fontface": 1,
                                    "fontsize": 16.0,
                                    "format": 6,
                                    "id": "obj-25",
                                    "ignoreclick": 1,
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 463.0, 884.0, 96.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 419.0, 30.0, 96.0, 26.0 ],
                                    "textcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "tricolor": [ 0.458595350062755, 0.458595237564901, 0.458595266962388, 0.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-34",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 63.0, 917.0, 143.0, 22.0 ],
                                    "text": "expr 0.1 * pow(5000\\, $f1)"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "drawoffcolor": 1,
                                    "elementcolor": [ 0.050980392156862744, 0.1803921568627451, 0.25098039215686274, 1.0 ],
                                    "floatoutput": 1,
                                    "id": "obj-48",
                                    "knobcolor": [ 0.6666666666666666, 0.49019607843137253, 0.2823529411764706, 1.0 ],
                                    "knobshape": 6,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 63.0, 884.0, 444.0, 26.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 30.0, 404.0, 26.0 ],
                                    "size": 1.0,
                                    "valuepopuplabel": 1,
                                    "varname": "grainrate"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 582.0, 687.0, 94.0, 22.0 ],
                                    "text": "route nchannels"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.639216, 0.458824, 0.070588, 1.0 ],
                                    "fontface": 1,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 582.0, 648.0, 65.0, 22.0 ],
                                    "text": "r ec2-data"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.92549, 0.364706, 0.341176, 1.0 ],
                                    "fontface": 1,
                                    "id": "obj-84",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 579.5, 2552.0, 85.0, 22.0 ],
                                    "text": "s ec2-params"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-83",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1265.0, 1967.0, 111.0, 22.0 ],
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
                                    "patching_rect": [ 1265.0, 1881.0, 103.0, 22.0 ],
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
                                    "patching_rect": [ 1265.0, 1783.0, 113.0, 22.0 ],
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
                                    "patching_rect": [ 1264.0, 1693.0, 75.0, 22.0 ],
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
                                    "patching_rect": [ 1264.0, 1596.0, 111.0, 22.0 ],
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
                                    "patching_rect": [ 1263.0, 1483.0, 98.0, 22.0 ],
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
                                    "patching_rect": [ 1262.0, 1378.0, 103.0, 22.0 ],
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
                                    "patching_rect": [ 1262.0, 1275.0, 78.0, 22.0 ],
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
                                    "patching_rect": [ 1259.0, 1150.0, 102.0, 22.0 ],
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
                                    "patching_rect": [ 1258.0, 1045.0, 98.0, 22.0 ],
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
                                    "patching_rect": [ 1256.0, 958.0, 97.0, 22.0 ],
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
                                    "patching_rect": [ 1254.0, 868.0, 123.0, 22.0 ],
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
                                    "patching_rect": [ 1254.0, 784.0, 86.0, 22.0 ],
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
                                    "patching_rect": [ 1251.0, 703.0, 102.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 1925.0, 49.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 2208.0, 85.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 2122.0, 77.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 2024.0, 87.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 1837.0, 85.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 1722.0, 72.0, 22.0 ],
                                    "text": "/filterfreq $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-39",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 472.0, 1525.0, 52.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 1391.0, 76.0, 22.0 ],
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
                                    "patching_rect": [ 472.0, 1293.0, 72.0, 22.0 ],
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
                                    "patching_rect": [ 472.0, 1206.0, 71.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 1112.0, 97.0, 22.0 ],
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
                                    "patching_rect": [ 471.0, 1031.0, 60.0, 22.0 ],
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
                                    "patching_rect": [ 463.0, 917.0, 76.0, 22.0 ],
                                    "text": "/grainrate $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-71",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1262.0, 1242.0, 39.0, 22.0 ],
                                    "text": "dbtoa"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-61",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 472.0, 1493.0, 39.0, 22.0 ],
                                    "text": "dbtoa"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                                    "buffername": "emission",
                                    "chanoffset": 2,
                                    "gridcolor": [ 0.221327066888467, 0.221327006361825, 0.221327022178404, 0.0 ],
                                    "id": "obj-12",
                                    "maxclass": "waveform~",
                                    "numinlets": 5,
                                    "numoutlets": 6,
                                    "outlettype": [ "float", "float", "float", "float", "list", "" ],
                                    "patching_rect": [ 22.5, 2328.0, 256.0, 64.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 13.0, 671.0, 1224.0, 154.0 ],
                                    "selectioncolor": [ 0.922234290352602, 0.71007200526417, 0.329758341965716, 0.0 ],
                                    "waveformcolor": [ 0.5450980392156862, 0.37254901960784315, 0.16470588235294117, 1.0 ]
                                }
                            },
                            {
                                "box": {
                                    "angle": 270.0,
                                    "bgcolor": [ 0.19215686274509802, 0.3411764705882353, 0.4235294117647059, 1.0 ],
                                    "id": "obj-17",
                                    "maxclass": "panel",
                                    "mode": 0,
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 335.39825707674026, 674.3363374471664, 128.0, 128.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 8.0, -1.0, 1274.0, 873.0 ],
                                    "proportion": 0.5
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 4 ],
                                    "source": [ "obj-10", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-78", 1 ],
                                    "source": [ "obj-10", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-78", 0 ],
                                    "source": [ "obj-10", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "source": [ "obj-101", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-101", 0 ],
                                    "midpoints": [ 72.5, 1102.0, 52.0, 1102.0, 52.0, 1060.0, 475.0, 1060.0, 475.0, 1072.0, 480.5, 1072.0 ],
                                    "source": [ "obj-102", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-97", 0 ],
                                    "midpoints": [ 663.5, 523.0, 648.3984375, 523.0, 648.3984375, 477.0, 1073.5, 477.0 ],
                                    "source": [ "obj-103", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1073.5, 1549.0, 589.0, 1549.0 ],
                                    "source": [ "obj-105", 0 ]
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
                                    "destination": [ "obj-127", 0 ],
                                    "midpoints": [ 68.5, 1201.0, 469.0, 1201.0, 469.0, 1162.0, 481.5, 1162.0 ],
                                    "source": [ "obj-120", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-128", 0 ],
                                    "source": [ "obj-122", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-122", 0 ],
                                    "midpoints": [ 663.5, 604.0, 648.3984375, 604.0, 648.3984375, 558.0, 1073.5, 558.0 ],
                                    "source": [ "obj-126", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "source": [ "obj-127", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1073.5, 1592.0, 589.0, 1592.0 ],
                                    "source": [ "obj-128", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-131", 0 ],
                                    "order": 0,
                                    "source": [ "obj-129", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 0 ],
                                    "order": 1,
                                    "source": [ "obj-129", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-148", 0 ],
                                    "source": [ "obj-13", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-35", 0 ],
                                    "source": [ "obj-130", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 176.5, 1630.5, 589.0, 1630.5 ],
                                    "source": [ "obj-131", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-130", 0 ],
                                    "midpoints": [ 74.5, 1285.0, 469.0, 1285.0, 469.0, 1246.0, 481.5, 1246.0 ],
                                    "source": [ "obj-133", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-136", 0 ],
                                    "source": [ "obj-134", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "source": [ "obj-136", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-37", 0 ],
                                    "source": [ "obj-137", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-137", 0 ],
                                    "midpoints": [ 74.5, 1375.0, 52.0, 1375.0, 52.0, 1333.0, 475.0, 1333.0, 475.0, 1345.0, 480.5, 1345.0 ],
                                    "source": [ "obj-139", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 1802.5, 589.0, 1802.5 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-61", 0 ],
                                    "source": [ "obj-141", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-141", 0 ],
                                    "midpoints": [ 74.5, 1518.6171875, 60.0, 1518.6171875, 60.0, 1434.0, 480.5, 1434.0 ],
                                    "source": [ "obj-142", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-142", 0 ],
                                    "source": [ "obj-143", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-147", 0 ],
                                    "source": [ "obj-145", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-145", 0 ],
                                    "midpoints": [ 74.5, 1605.0, 52.0, 1605.0, 52.0, 1563.0, 475.0, 1563.0, 475.0, 1575.0, 480.5, 1575.0 ],
                                    "source": [ "obj-146", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 2094.5, 589.0, 2094.5 ],
                                    "source": [ "obj-147", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-134", 0 ],
                                    "source": [ "obj-148", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 1843.0, 589.0, 1843.0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-43", 0 ],
                                    "source": [ "obj-150", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-150", 0 ],
                                    "midpoints": [ 74.5, 1754.0, 53.2421875, 1754.0, 53.2421875, 1674.0, 480.5, 1674.0 ],
                                    "source": [ "obj-151", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-151", 0 ],
                                    "source": [ "obj-152", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 363.5, 1630.5, 589.0, 1630.5 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 512.5, 1590.0, 589.0, 1590.0 ],
                                    "source": [ "obj-161", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-161", 0 ],
                                    "source": [ "obj-162", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-44", 0 ],
                                    "source": [ "obj-163", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-163", 0 ],
                                    "midpoints": [ 74.5, 1818.0, 52.0, 1818.0, 52.0, 1776.0, 475.0, 1776.0, 475.0, 1788.0, 480.5, 1788.0 ],
                                    "source": [ "obj-164", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-49", 0 ],
                                    "source": [ "obj-166", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-166", 0 ],
                                    "midpoints": [ 74.5, 1911.0, 52.0, 1911.0, 52.0, 1869.0, 475.0, 1869.0, 475.0, 1881.0, 480.5, 1881.0 ],
                                    "source": [ "obj-167", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-45", 0 ],
                                    "source": [ "obj-169", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-169", 0 ],
                                    "midpoints": [ 74.5, 2004.0, 52.0, 2004.0, 52.0, 1962.0, 475.0, 1962.0, 475.0, 1974.0, 480.5, 1974.0 ],
                                    "source": [ "obj-170", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-162", 0 ],
                                    "midpoints": [ 102.5, 609.0, 87.3984375, 609.0, 87.3984375, 563.0, 512.5, 563.0 ],
                                    "source": [ "obj-172", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 512.5, 1547.0, 589.0, 1547.0 ],
                                    "source": [ "obj-174", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-174", 0 ],
                                    "source": [ "obj-175", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-46", 0 ],
                                    "source": [ "obj-176", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-176", 0 ],
                                    "midpoints": [ 74.5, 2102.0, 52.0, 2102.0, 52.0, 2060.0, 475.0, 2060.0, 475.0, 2072.0, 480.5, 2072.0 ],
                                    "order": 0,
                                    "source": [ "obj-177", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-38", 1 ],
                                    "order": 1,
                                    "source": [ "obj-177", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-47", 0 ],
                                    "source": [ "obj-179", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-179", 0 ],
                                    "midpoints": [ 74.5, 2193.0, 52.0, 2193.0, 52.0, 2151.0, 475.0, 2151.0, 475.0, 2163.0, 480.5, 2163.0 ],
                                    "order": 0,
                                    "source": [ "obj-180", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-38", 2 ],
                                    "order": 1,
                                    "source": [ "obj-180", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-175", 0 ],
                                    "midpoints": [ 102.5, 520.0, 87.3984375, 520.0, 87.3984375, 474.0, 512.5, 474.0 ],
                                    "source": [ "obj-181", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-211", 1 ],
                                    "midpoints": [ 852.5, 694.0, 781.5, 694.0 ],
                                    "source": [ "obj-184", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 1 ],
                                    "midpoints": [ 852.5, 774.0, 781.5, 774.0 ],
                                    "source": [ "obj-186", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 1 ],
                                    "midpoints": [ 852.5, 864.0, 781.5, 864.0 ],
                                    "source": [ "obj-188", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 1 ],
                                    "midpoints": [ 852.5, 954.0, 784.5, 954.0 ],
                                    "source": [ "obj-189", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-228", 1 ],
                                    "midpoints": [ 852.5, 1367.0, 781.5, 1367.0 ],
                                    "source": [ "obj-190", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-226", 1 ],
                                    "midpoints": [ 852.5, 1240.640625, 781.5, 1240.640625 ],
                                    "source": [ "obj-191", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-224", 1 ],
                                    "midpoints": [ 852.5, 1137.0, 781.5, 1137.0 ],
                                    "source": [ "obj-192", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-222", 1 ],
                                    "midpoints": [ 852.5, 1037.0, 781.5, 1037.0 ],
                                    "source": [ "obj-193", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-230", 1 ],
                                    "midpoints": [ 852.5, 1473.0, 781.5, 1473.0 ],
                                    "source": [ "obj-194", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-232", 1 ],
                                    "midpoints": [ 852.5, 1580.0, 781.5, 1580.0 ],
                                    "source": [ "obj-195", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-234", 1 ],
                                    "midpoints": [ 852.5, 1673.0, 781.5, 1673.0 ],
                                    "source": [ "obj-196", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-236", 1 ],
                                    "midpoints": [ 852.5, 1766.0, 781.5, 1766.0 ],
                                    "source": [ "obj-197", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-238", 1 ],
                                    "midpoints": [ 852.5, 1864.0, 781.5, 1864.0 ],
                                    "source": [ "obj-198", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-240", 1 ],
                                    "midpoints": [ 852.5, 1955.0, 781.5, 1955.0 ],
                                    "source": [ "obj-199", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-315", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 481.5, 1890.0, 589.0, 1890.0 ],
                                    "source": [ "obj-20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-211", 0 ],
                                    "source": [ "obj-200", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-155", 0 ],
                                    "source": [ "obj-201", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-155", 0 ],
                                    "midpoints": [ 103.5, 751.5, 301.5, 751.5 ],
                                    "source": [ "obj-202", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 1636.0, 589.0, 1636.0 ],
                                    "source": [ "obj-211", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 1676.0, 589.0, 1676.0 ],
                                    "source": [ "obj-216", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 0 ],
                                    "source": [ "obj-217", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 1721.0, 589.0, 1721.0 ],
                                    "source": [ "obj-218", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 0 ],
                                    "source": [ "obj-219", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 750.5, 1766.0, 589.0, 1766.0 ],
                                    "source": [ "obj-220", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 0 ],
                                    "source": [ "obj-221", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 1807.5, 589.0, 1807.5 ],
                                    "source": [ "obj-222", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-222", 0 ],
                                    "source": [ "obj-223", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 1862.0, 589.0, 1862.0 ],
                                    "source": [ "obj-224", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-224", 0 ],
                                    "source": [ "obj-225", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 1913.0, 589.0, 1913.0 ],
                                    "source": [ "obj-226", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-226", 0 ],
                                    "source": [ "obj-227", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 1972.5, 589.0, 1972.5 ],
                                    "source": [ "obj-228", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-228", 0 ],
                                    "source": [ "obj-229", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2031.5, 589.0, 2031.5 ],
                                    "source": [ "obj-230", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-230", 0 ],
                                    "source": [ "obj-231", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2085.0, 589.0, 2085.0 ],
                                    "source": [ "obj-232", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-232", 0 ],
                                    "source": [ "obj-233", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2133.5, 589.0, 2133.5 ],
                                    "source": [ "obj-234", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-234", 0 ],
                                    "source": [ "obj-235", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2178.5, 589.0, 2178.5 ],
                                    "source": [ "obj-236", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-236", 0 ],
                                    "source": [ "obj-237", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2227.5, 589.0, 2227.5 ],
                                    "source": [ "obj-238", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-238", 0 ],
                                    "source": [ "obj-239", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2270.5, 589.0, 2270.5 ],
                                    "source": [ "obj-240", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-240", 0 ],
                                    "source": [ "obj-241", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-51", 0 ],
                                    "source": [ "obj-243", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-52", 0 ],
                                    "source": [ "obj-244", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-53", 0 ],
                                    "source": [ "obj-245", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-54", 0 ],
                                    "source": [ "obj-246", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-56", 0 ],
                                    "source": [ "obj-248", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-57", 0 ],
                                    "source": [ "obj-249", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "source": [ "obj-25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-71", 0 ],
                                    "source": [ "obj-250", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-59", 0 ],
                                    "source": [ "obj-251", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-66", 0 ],
                                    "source": [ "obj-252", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 0 ],
                                    "source": [ "obj-254", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-80", 0 ],
                                    "source": [ "obj-255", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-81", 0 ],
                                    "source": [ "obj-256", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-82", 0 ],
                                    "source": [ "obj-258", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-83", 0 ],
                                    "source": [ "obj-259", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-29", 0 ],
                                    "midpoints": [ 102.5, 311.0, 87.3984375, 311.0, 87.3984375, 265.0, 512.5, 265.0 ],
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-293", 0 ],
                                    "source": [ "obj-261", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-295", 0 ],
                                    "source": [ "obj-264", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-264", 0 ],
                                    "midpoints": [ 966.5, 2090.6171875, 952.0, 2090.6171875, 952.0, 2006.0, 1372.5, 2006.0 ],
                                    "source": [ "obj-265", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-265", 0 ],
                                    "source": [ "obj-266", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-294", 0 ],
                                    "source": [ "obj-267", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-297", 0 ],
                                    "source": [ "obj-268", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-296", 0 ],
                                    "source": [ "obj-269", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-269", 0 ],
                                    "midpoints": [ 966.5, 2183.6171875, 952.0, 2183.6171875, 952.0, 2099.0, 1372.5, 2099.0 ],
                                    "source": [ "obj-270", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-270", 0 ],
                                    "source": [ "obj-271", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-298", 0 ],
                                    "source": [ "obj-272", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-300", 0 ],
                                    "source": [ "obj-273", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-299", 0 ],
                                    "source": [ "obj-274", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-274", 0 ],
                                    "midpoints": [ 966.5, 2284.6171875, 952.0, 2284.6171875, 952.0, 2200.0, 1372.5, 2200.0 ],
                                    "source": [ "obj-275", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-275", 0 ],
                                    "source": [ "obj-276", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-301", 0 ],
                                    "source": [ "obj-277", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-303", 0 ],
                                    "source": [ "obj-278", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-302", 0 ],
                                    "source": [ "obj-279", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-279", 0 ],
                                    "midpoints": [ 966.5, 2396.6171875, 952.0, 2396.6171875, 952.0, 2312.0, 1372.5, 2312.0 ],
                                    "source": [ "obj-280", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-280", 0 ],
                                    "source": [ "obj-281", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-304", 0 ],
                                    "source": [ "obj-282", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-306", 0 ],
                                    "source": [ "obj-283", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-305", 0 ],
                                    "source": [ "obj-284", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-284", 0 ],
                                    "midpoints": [ 966.5, 2504.6171875, 952.0, 2504.6171875, 952.0, 2420.0, 1372.5, 2420.0 ],
                                    "source": [ "obj-285", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-285", 0 ],
                                    "source": [ "obj-286", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-307", 0 ],
                                    "source": [ "obj-287", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-309", 0 ],
                                    "source": [ "obj-288", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-308", 0 ],
                                    "source": [ "obj-289", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-30", 0 ],
                                    "source": [ "obj-29", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-289", 0 ],
                                    "midpoints": [ 966.5, 2618.6171875, 952.0, 2618.6171875, 952.0, 2534.0, 1372.5, 2534.0 ],
                                    "source": [ "obj-290", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-290", 0 ],
                                    "source": [ "obj-291", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-310", 0 ],
                                    "source": [ "obj-292", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2314.5, 589.0, 2314.5 ],
                                    "source": [ "obj-293", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 852.5, 2314.5, 589.0, 2314.5 ],
                                    "source": [ "obj-294", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1372.5, 2314.5, 589.0, 2314.5 ],
                                    "source": [ "obj-295", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1372.5, 2363.5, 589.0, 2363.5 ],
                                    "source": [ "obj-296", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 852.5, 2363.5, 589.0, 2363.5 ],
                                    "source": [ "obj-297", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2363.5, 589.0, 2363.5 ],
                                    "source": [ "obj-298", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1372.5, 2414.5, 589.0, 2414.5 ],
                                    "source": [ "obj-299", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 512.5, 1442.5, 589.0, 1442.5 ],
                                    "source": [ "obj-30", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 852.5, 2414.5, 589.0, 2414.5 ],
                                    "source": [ "obj-300", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2414.5, 589.0, 2414.5 ],
                                    "source": [ "obj-301", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1372.5, 2470.5, 589.0, 2470.5 ],
                                    "source": [ "obj-302", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 852.5, 2470.5, 589.0, 2470.5 ],
                                    "source": [ "obj-303", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2470.5, 589.0, 2470.5 ],
                                    "source": [ "obj-304", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1372.5, 2525.5, 589.0, 2525.5 ],
                                    "source": [ "obj-305", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 852.5, 2525.5, 589.0, 2525.5 ],
                                    "source": [ "obj-306", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2525.5, 589.0, 2525.5 ],
                                    "source": [ "obj-307", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1372.5, 2624.0, 994.0, 2624.0, 994.0, 2542.0, 589.0, 2542.0 ],
                                    "source": [ "obj-308", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 852.5, 2619.0, 734.0, 2619.0, 734.0, 2542.0, 589.0, 2542.0 ],
                                    "source": [ "obj-309", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.5763723254, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 747.5, 2619.0, 681.5, 2619.0, 681.5, 2542.0, 589.0, 2542.0 ],
                                    "source": [ "obj-310", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "midpoints": [ 98.5, 154.0, 84.95703125, 154.0, 84.95703125, 108.0, 505.5, 108.0 ],
                                    "source": [ "obj-312", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 505.5, 1362.0, 589.0, 1362.0 ],
                                    "source": [ "obj-315", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-40", 0 ],
                                    "source": [ "obj-32", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "midpoints": [ 102.5, 400.0, 87.3984375, 400.0, 87.3984375, 354.0, 512.5, 354.0 ],
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "midpoints": [ 72.5, 952.6171875, 52.0, 952.6171875, 52.0, 868.0, 472.5, 868.0 ],
                                    "source": [ "obj-34", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 481.5, 1933.5, 589.0, 1933.5 ],
                                    "source": [ "obj-35", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 1982.5, 589.0, 1982.5 ],
                                    "source": [ "obj-37", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 1 ],
                                    "order": 1,
                                    "source": [ "obj-38", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 3 ],
                                    "source": [ "obj-38", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 2 ],
                                    "source": [ "obj-38", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-78", 2 ],
                                    "order": 0,
                                    "source": [ "obj-38", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-38", 0 ],
                                    "source": [ "obj-380", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 481.5, 2049.5, 589.0, 2049.5 ],
                                    "source": [ "obj-39", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "midpoints": [ 102.5, 230.0, 88.95703125, 230.0, 88.95703125, 184.0, 509.5, 184.0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 512.5, 1485.5, 589.0, 1485.5 ],
                                    "source": [ "obj-40", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-62", 0 ],
                                    "source": [ "obj-42", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 2148.0, 589.0, 2148.0 ],
                                    "source": [ "obj-43", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 2205.5, 589.0, 2205.5 ],
                                    "source": [ "obj-44", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 2299.0, 589.0, 2299.0 ],
                                    "source": [ "obj-45", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 2348.0, 589.0, 2348.0 ],
                                    "source": [ "obj-46", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 2391.0, 589.0, 2391.0 ],
                                    "source": [ "obj-47", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-34", 0 ],
                                    "source": [ "obj-48", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 480.5, 2249.5, 589.0, 2249.5 ],
                                    "source": [ "obj-49", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 509.5, 1401.0, 589.0, 1401.0 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-42", 0 ],
                                    "midpoints": [ 663.5, 186.6171875, 649.0, 186.6171875, 649.0, 102.0, 1069.5, 102.0 ],
                                    "source": [ "obj-50", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1260.5, 1638.5, 589.0, 1638.5 ],
                                    "source": [ "obj-51", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1263.5, 1679.0, 589.0, 1679.0 ],
                                    "source": [ "obj-52", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1263.5, 1721.0, 589.0, 1721.0 ],
                                    "source": [ "obj-53", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1265.5, 1766.0, 589.0, 1766.0 ],
                                    "source": [ "obj-54", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-50", 0 ],
                                    "source": [ "obj-55", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1267.5, 1809.5, 589.0, 1809.5 ],
                                    "source": [ "obj-56", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1268.5, 1862.0, 589.0, 1862.0 ],
                                    "source": [ "obj-57", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1271.5, 1924.5, 589.0, 1924.5 ],
                                    "source": [ "obj-58", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1271.5, 1976.0, 589.0, 1976.0 ],
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
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1069.5, 1362.5, 589.0, 1362.5 ],
                                    "source": [ "obj-62", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1069.5, 1410.5, 589.0, 1410.5 ],
                                    "source": [ "obj-63", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-63", 0 ],
                                    "source": [ "obj-64", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-64", 0 ],
                                    "midpoints": [ 663.5, 282.6171875, 649.0, 282.6171875, 649.0, 198.0, 1069.5, 198.0 ],
                                    "source": [ "obj-65", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1272.5, 2028.5, 589.0, 2028.5 ],
                                    "source": [ "obj-66", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-67", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-155", 0 ],
                                    "source": [ "obj-7", 0 ]
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
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1069.5, 1458.0, 589.0, 1458.0 ],
                                    "source": [ "obj-72", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-72", 0 ],
                                    "source": [ "obj-73", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-73", 0 ],
                                    "midpoints": [ 663.5, 377.6171875, 649.0, 377.6171875, 649.0, 293.0, 1069.5, 293.0 ],
                                    "source": [ "obj-74", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-74", 0 ],
                                    "source": [ "obj-75", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-86", 0 ],
                                    "source": [ "obj-76", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-76", 0 ],
                                    "midpoints": [ 663.5, 442.0, 648.3984375, 442.0, 648.3984375, 396.0, 1073.5, 396.0 ],
                                    "source": [ "obj-77", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-176", 0 ],
                                    "midpoints": [ 127.19912451505661, 2442.0, 9.0, 2442.0, 9.0, 2061.0, 480.5, 2061.0 ],
                                    "order": 0,
                                    "source": [ "obj-78", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-177", 0 ],
                                    "midpoints": [ 127.19912451505661, 2442.0, 9.0, 2442.0, 9.0, 2070.0, 74.5, 2070.0 ],
                                    "order": 1,
                                    "source": [ "obj-78", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-179", 0 ],
                                    "midpoints": [ 158.53304150501884, 2451.0, 9.0, 2451.0, 9.0, 2151.0, 477.0, 2151.0, 477.0, 2163.0, 480.5, 2163.0 ],
                                    "order": 0,
                                    "source": [ "obj-78", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-180", 0 ],
                                    "midpoints": [ 158.53304150501884, 2451.0, 9.0, 2451.0, 9.0, 2163.0, 74.5, 2163.0 ],
                                    "order": 1,
                                    "source": [ "obj-78", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 221.20087548494337, 2496.734610617161, 589.0, 2496.734610617161 ],
                                    "source": [ "obj-78", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 189.8669584949811, 2496.734610617161, 589.0, 2496.734610617161 ],
                                    "source": [ "obj-78", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1273.5, 2085.0, 589.0, 2085.0 ],
                                    "source": [ "obj-79", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "order": 0,
                                    "source": [ "obj-8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-201", 0 ],
                                    "order": 1,
                                    "source": [ "obj-8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 1 ],
                                    "midpoints": [ 301.5, 715.53515625, 169.5, 715.53515625 ],
                                    "order": 2,
                                    "source": [ "obj-8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1273.5, 2133.5, 589.0, 2133.5 ],
                                    "source": [ "obj-80", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1274.5, 2178.5, 589.0, 2178.5 ],
                                    "source": [ "obj-81", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1274.5, 2227.5, 589.0, 2227.5 ],
                                    "source": [ "obj-82", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 1.0, 0.2527923882, 1.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1274.5, 2270.5, 589.0, 2270.5 ],
                                    "source": [ "obj-83", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.9994240403, 0.9855536819, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 1073.5, 1509.0, 589.0, 1509.0 ],
                                    "source": [ "obj-86", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "color": [ 0.0, 0.9768045545, 0.0, 1.0 ],
                                    "destination": [ "obj-84", 0 ],
                                    "midpoints": [ 472.5, 1745.5, 589.0, 1745.5 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-96", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-105", 0 ],
                                    "source": [ "obj-97", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-96", 0 ],
                                    "midpoints": [ 68.5, 1012.0, 52.0, 1012.0, 52.0, 970.0, 475.0, 970.0, 475.0, 982.0, 480.5, 982.0 ],
                                    "source": [ "obj-98", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 46.0, -114.0, 35.0, 22.0 ],
                    "text": "p gui",
                    "varname": "patcher"
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "grad1": [ 0.00784313725490196, 0.10588235294117647, 0.1568627450980392, 1.0 ],
                    "grad2": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 1.0 ],
                    "id": "obj-381",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 2.0, -206.0, 161.0, 129.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 2.0, 4.0, 161.0, 129.0 ],
                    "proportion": 0.5
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-376", 0 ],
                    "source": [ "obj-380", 0 ]
                }
            }
        ],
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