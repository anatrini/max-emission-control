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
        "rect": [ 1683.0, 87.0, 1007.0, 832.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-50",
                    "linecount": 5,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 518.0, 6.0, 363.0, 74.0 ],
                    "text": "TODO: \n1. implementa filtro VA tipo ladder per suono migliore\n2. implementa visualizzazione parametri su waveform\n3. implementa visualizzazione parameteri con doppio click, togli debug out dx"
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
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
                        "rect": [ 430.0, 193.0, 1000.0, 755.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 282.0, 214.0, 34.0, 22.0 ],
                                    "text": "sel 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 107.0, 309.0, 41.0, 22.0 ],
                                    "text": "s data"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-15",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 107.0, 144.0, 80.0, 22.0 ],
                                    "text": "nchannels $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "int", "signal" ],
                                    "patching_rect": [ 107.0, 86.0, 106.0, 22.0 ],
                                    "text": "mc.channelcount~"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "int", "float", "int", "int" ],
                                    "patching_rect": [ 282.0, 169.0, 61.0, 22.0 ],
                                    "text": "dspstate~"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-84",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 385.0, 39.0, 79.0, 22.0 ],
                                    "text": "r ec2-params"
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
                                    "patching_rect": [ 385.0, 301.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-4",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "multichannelsignal" ],
                                    "patching_rect": [ 107.0, 37.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "source": [ "obj-11", 0 ]
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
                                    "destination": [ "obj-16", 0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 291.5, 246.0, 83.03125, 246.0, 83.03125, 76.0, 116.5, 76.0 ],
                                    "source": [ "obj-17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-84", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 743.0, 185.0, 94.0, 22.0 ],
                    "text": "p params-router"
                }
            },
            {
                "box": {
                    "id": "obj-32",
                    "linecount": 4,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 591.0, 748.0, 50.0, 62.0 ],
                    "text": "/lfo1_to_grainrate unmap"
                }
            },
            {
                "box": {
                    "id": "obj-30",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 573.0, 682.0, 47.0, 22.0 ],
                    "text": "pak s s"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "live.tab",
                    "num_lines_patching": 1,
                    "num_lines_presentation": 1,
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 603.0, 611.0, 100.0, 20.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "map", "unmap" ],
                            "parameter_longname": "live.tab",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.tab",
                            "parameter_type": 2,
                            "parameter_unitstyle": 9
                        }
                    },
                    "varname": "live.tab"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 573.0, 557.0, 175.0, 22.0 ],
                    "text": "combine /lfo1_to_ i @triggers 1"
                }
            },
            {
                "box": {
                    "fontsize": 14.0,
                    "id": "obj-23",
                    "maxclass": "live.menu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 622.0, 509.0, 100.0, 20.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "grainrate", "async", "streams", "playback" ],
                            "parameter_longname": "live.menu",
                            "parameter_mmax": 3,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.menu",
                            "parameter_type": 2
                        }
                    },
                    "varname": "live.menu"
                }
            },
            {
                "box": {
                    "attr": "allocmode",
                    "id": "obj-7",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1162.0, 124.0, 150.0, 22.0 ]
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-6",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "ec2_GUI.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 12.0, 6.0, 484.0, 553.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "id": "obj-3",
                    "linecount": 69,
                    "maxclass": "o.display",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 911.0, 321.5, 248.0, 904.0 ],
                    "text": "/grainrate : 20.,\n/async : 0.,\n/intermittency : 0.,\n/streams : 1.,\n/playback : 1.,\n/duration : 1.,\n/envelope : 0.5,\n/scanstart : 0.5,\n/scanrange : 1.,\n/amplitude : 1.,\n/filterfreq : 1000.,\n/resonance : 0.,\n/pan : 0.,\n/scanspeed : 1.,\n/grainrate_dev : 0.,\n/async_dev : 0.,\n/intermittency_dev : 0.,\n/streams_dev : 0.,\n/playback_dev : 0.,\n/duration_dev : 0.,\n/envelope_dev : 0.,\n/pan_dev : 0.,\n/amp_dev : 3.16228e-05,\n/filterfreq_dev : 0.,\n/resonance_dev : 0.,\n/scanstart_dev : 0.,\n/scanrange_dev : 0.,\n/scanspeed_dev : 0.,\n/lfo1shape : 0.,\n/lfo1rate : 1.,\n/lfo1polarity : 0.,\n/lfo1duty : 0.5,\n/lfo2shape : 0.,\n/lfo2rate : 1.,\n/lfo2polarity : 0.,\n/lfo2duty : 0.5,\n/lfo3shape : 0.,\n/lfo3rate : 1.,\n/lfo3polarity : 0.,\n/lfo3duty : 0.5,\n/lfo4shape : 0.,\n/lfo4rate : 1.,\n/lfo4polarity : 0.,\n/lfo4duty : 0.5,\n/lfo5shape : 0.,\n/lfo5rate : 1.,\n/lfo5polarity : 0.,\n/lfo5duty : 0.5,\n/lfo6shape : 0.,\n/lfo6rate : 1.,\n/lfo6polarity : 0.,\n/lfo6duty : 0.5,\n//lfo1depth : 1.,\n//lfo2depth : 1.,\n//lfo3depth : 1.,\n//lfo4depth : 1.,\n//lfo5depth : 1.,\n//lfo6depth : 1.,\n/fixedchan : 1.,\n/rrstep : 1.,\n/randspread : 0.,\n/spatialcorr : 0.,\n/pitchmin : 20.,\n/pitchmax : 20000.,\n/trajshape : 0.,\n/trajrate : 0.5,\n/trajdepth : 0.,\n/spiral_factor : 0.,\n/pendulum_decay : 0.1"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "lastchannelcount": 2,
                    "maxclass": "mc.live.gain~",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "multichannelsignal", "", "float", "list" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 743.0, 328.0, 48.0, 136.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "mc.live.gain~",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "mc.live.gain~",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "varname": "mc.live.gain~"
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [ "multichannelsignal", "" ],
                    "patching_rect": [ 743.0, 279.0, 187.0, 22.0 ],
                    "saved_object_attributes": {
                        "allocmode": 1,
                        "buffer": "johnson",
                        "mc": 1,
                        "outputs": 2,
                        "soundfile": 0
                    },
                    "text": "ec2~ johnson @outputs 2 @mc 1"
                }
            },
            {
                "box": {
                    "attr": "buffer",
                    "id": "obj-4",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 930.0, 124.0, 150.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1221.0, 237.0, 48.0, 22.0 ],
                    "text": "replace"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 1221.0, 279.0, 95.0, 22.0 ],
                    "text": "buffer~ johnson"
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 743.0, 500.0, 54.0, 22.0 ],
                    "text": "mc.dac~"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "source": [ "obj-1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-48", 0 ],
                    "midpoints": [ 752.5, 310.8359375, 731.1171875, 310.8359375, 731.1171875, 174.0, 752.5, 174.0 ],
                    "order": 0,
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "order": 1,
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9", 0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 1 ],
                    "source": [ "obj-23", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "source": [ "obj-24", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 1 ],
                    "source": [ "obj-27", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-32", 1 ],
                    "source": [ "obj-30", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-48", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-7", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-23": [ "live.menu", "live.menu", 0 ],
            "obj-27": [ "live.tab", "live.tab", 0 ],
            "obj-5": [ "mc.live.gain~", "mc.live.gain~", 0 ],
            "obj-6::obj-1": [ "live.dial", "Grainrate", 0 ],
            "obj-6::obj-107": [ "live.dial[19]", "PitchMin", 0 ],
            "obj-6::obj-109": [ "live.dial[20]", "PitchMax", 0 ],
            "obj-6::obj-110": [ "live.menu[2]", "live.menu", 0 ],
            "obj-6::obj-111": [ "live.dial[22]", "TrajRate", 0 ],
            "obj-6::obj-115": [ "live.dial[21]", "TrajDepth", 0 ],
            "obj-6::obj-117": [ "live.dial[23]", "Spiral", 0 ],
            "obj-6::obj-119": [ "live.dial[24]", "Pendulum", 0 ],
            "obj-6::obj-12": [ "Fixedchan", "FixedChan", 0 ],
            "obj-6::obj-122": [ "live.dial[27]", "LFO1 GDepth", 0 ],
            "obj-6::obj-131": [ "live.tab[8]", "live.tab", 0 ],
            "obj-6::obj-134": [ "live.menu[5]", "live.menu", 0 ],
            "obj-6::obj-136": [ "live.menu[6]", "live.menu", 0 ],
            "obj-6::obj-138": [ "live.menu[7]", "live.menu", 0 ],
            "obj-6::obj-148": [ "live.numbox[14]", "live.numbox", 0 ],
            "obj-6::obj-149": [ "live.numbox[15]", "live.numbox", 0 ],
            "obj-6::obj-154": [ "live.numbox[20]", "live.numbox", 0 ],
            "obj-6::obj-155": [ "live.numbox[21]", "live.numbox", 0 ],
            "obj-6::obj-16": [ "live.dial[4]", "Duration", 0 ],
            "obj-6::obj-161": [ "live.tab[5]", "live.tab", 0 ],
            "obj-6::obj-162": [ "live.tab[9]", "live.tab", 0 ],
            "obj-6::obj-17": [ "live.dial[5]", "Playback", 0 ],
            "obj-6::obj-18": [ "live.dial[6]", "Amplitude", 0 ],
            "obj-6::obj-19": [ "live.dial[7]", "Envelope", 0 ],
            "obj-6::obj-2": [ "live.dial[1]", "Async", 0 ],
            "obj-6::obj-22": [ "live.dial[8]", "FilterFreq", 0 ],
            "obj-6::obj-23": [ "live.dial[9]", "Resonance", 0 ],
            "obj-6::obj-24": [ "live.dial[14]", "RRstep", 0 ],
            "obj-6::obj-26": [ "live.dial[10]", "Pan (Stereo)", 0 ],
            "obj-6::obj-28": [ "live.dial[15]", "Rspread", 0 ],
            "obj-6::obj-29": [ "live.dial[11]", "ScanSpeed", 0 ],
            "obj-6::obj-3": [ "live.dial[2]", "Intermittency", 0 ],
            "obj-6::obj-30": [ "live.dial[12]", "ScanStart", 0 ],
            "obj-6::obj-31": [ "live.dial[13]", "ScanRange", 0 ],
            "obj-6::obj-33": [ "live.dial[25]", "LFO1 Rate", 0 ],
            "obj-6::obj-4": [ "live.dial[3]", "Streams", 0 ],
            "obj-6::obj-42": [ "live.tab[1]", "live.tab", 0 ],
            "obj-6::obj-5": [ "live.menu[3]", "live.menu", 0 ],
            "obj-6::obj-55": [ "live.dial[26]", "LFO1 Duty", 0 ],
            "obj-6::obj-63": [ "live.numbox", "live.numbox", 0 ],
            "obj-6::obj-64": [ "live.numbox[1]", "live.numbox", 0 ],
            "obj-6::obj-65": [ "live.numbox[2]", "live.numbox", 0 ],
            "obj-6::obj-67": [ "live.numbox[3]", "live.numbox", 0 ],
            "obj-6::obj-68": [ "live.numbox[4]", "live.numbox", 0 ],
            "obj-6::obj-69": [ "live.numbox[5]", "live.numbox", 0 ],
            "obj-6::obj-7": [ "live.menu[1]", "live.menu", 0 ],
            "obj-6::obj-70": [ "live.numbox[6]", "live.numbox", 0 ],
            "obj-6::obj-72": [ "live.numbox[7]", "live.numbox", 0 ],
            "obj-6::obj-73": [ "live.numbox[8]", "live.numbox", 0 ],
            "obj-6::obj-74": [ "live.numbox[9]", "live.numbox", 0 ],
            "obj-6::obj-75": [ "live.numbox[10]", "live.numbox", 0 ],
            "obj-6::obj-76": [ "live.numbox[11]", "live.numbox", 0 ],
            "obj-6::obj-77": [ "live.numbox[12]", "live.numbox", 0 ],
            "obj-6::obj-78": [ "live.numbox[13]", "live.numbox", 0 ],
            "obj-6::obj-8": [ "live.menu[4]", "live.menu", 0 ],
            "obj-6::obj-89": [ "live.dial[16]", "Spatialcorr", 0 ],
            "obj-6::obj-97": [ "live.tab[2]", "live.tab", 0 ],
            "parameter_overrides": {
                "obj-6::obj-110": {
                    "parameter_longname": "live.menu[2]"
                },
                "obj-6::obj-28": {
                    "parameter_shortname": "Rspread"
                },
                "obj-6::obj-42": {
                    "parameter_longname": "live.tab[1]"
                },
                "obj-6::obj-7": {
                    "parameter_longname": "live.menu[1]"
                },
                "obj-6::obj-89": {
                    "parameter_shortname": "Spatialcorr"
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}