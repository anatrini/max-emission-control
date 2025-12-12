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
        "rect": [ 71.0, 116.0, 1407.0, 832.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-40",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 543.0, 263.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 624.0, 199.0, 108.0, 22.0 ],
                    "text": "mc.sig~ @chans 8"
                }
            },
            {
                "box": {
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "int", "signal" ],
                    "patching_rect": [ 543.0, 328.0, 106.0, 22.0 ],
                    "text": "mc.channelcount~"
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
                    "num_lines_presentation": 0,
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
                    "id": "obj-84",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 743.0, 124.0, 79.0, 22.0 ],
                    "text": "r ec2-params"
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
                    "patching_rect": [ 12.0, 6.0, 485.0, 398.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "id": "obj-3",
                    "linecount": 80,
                    "maxclass": "o.display",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 911.0, 321.5, 248.0, 1045.0 ],
                    "text": "/grainrate : 20.,\n/async : 0.,\n/intermittency : 0.,\n/streams : 1.,\n/playback : 1.,\n/duration : 1.,\n/envelope : 0.5,\n/scanstart : 0.5,\n/scanrange : 1.,\n/amplitude : 1.,\n/filterfreq : 1000.,\n/resonance : 0.,\n/pan : 0.,\n/scanspeed : 1.,\n/grainrate_dev : 0.,\n/async_dev : 0.,\n/intermittency_dev : 0.,\n/streams_dev : 0.,\n/playback_dev : 0.,\n/duration_dev : 0.,\n/envelope_dev : 0.,\n/pan_dev : 0.,\n/amp_dev : 3.16228e-05,\n/filterfreq_dev : 0.,\n/resonance_dev : 0.,\n/scanstart_dev : 0.,\n/scanrange_dev : 0.,\n/scanspeed_dev : 0.,\n/lfo1shape : 0.,\n/lfo1rate : 1.,\n/lfo1polarity : 0.,\n/lfo1duty : 0.5,\n/lfo2shape : 0.,\n/lfo2rate : 1.,\n/lfo2polarity : 0.,\n/lfo2duty : 0.5,\n/lfo3shape : 0.,\n/lfo3rate : 1.,\n/lfo3polarity : 0.,\n/lfo3duty : 0.5,\n/lfo4shape : 0.,\n/lfo4rate : 1.,\n/lfo4polarity : 0.,\n/lfo4duty : 0.5,\n/lfo5shape : 0.,\n/lfo5rate : 1.,\n/lfo5polarity : 0.,\n/lfo5duty : 0.5,\n/lfo6shape : 0.,\n/lfo6rate : 1.,\n/lfo6polarity : 0.,\n/lfo6duty : 0.5,\n/grainrate_lfosource : 0.,\n/grainrate_moddepth : 0.,\n/async_lfosource : 0.,\n/async_moddepth : 0.,\n/intermittency_lfosource : 0.,\n/intermittency_moddepth : 0.,\n/streams_lfosource : 0.,\n/streams_moddepth : 0.,\n/playback_lfosource : 0.,\n/playback_moddepth : 0.,\n/duration_lfosource : 0.,\n/duration_moddepth : 0.,\n/envelope_lfosource : 0.,\n/envelope_moddepth : 0.,\n/filterfreq_lfosource : 0.,\n/filterfreq_moddepth : 0.,\n/resonance_lfosource : 0.,\n/resonance_moddepth : 0.,\n/pan_lfosource : 0.,\n/pan_moddepth : 0.,\n/amplitude_lfosource : 0.,\n/amplitude_moddepth : 0.,\n/scanstart_lfosource : 0.,\n/scanstart_moddepth : 0.,\n/scanrange_lfosource : 0.,\n/scanrange_moddepth : 0.,\n/scanspeed_lfosource : 0.,\n/scanspeed_moddepth : 0."
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "lastchannelcount": 4,
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
                        "allocmode": 3,
                        "buffer": "johnson",
                        "fixedchan": 0,
                        "mc": 1,
                        "outputs": 4,
                        "pitchmax": 20000.0,
                        "pitchmin": 20.0,
                        "randspread": 0.0,
                        "rrstep": 1,
                        "soundfile": 0,
                        "spatialcorr": 0.0,
                        "trajdepth": 1.0,
                        "trajrate": 0.5,
                        "trajshape": 0
                    },
                    "text": "ec2~ johnson @outputs 4 @mc 1"
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
                    "destination": [ "obj-35", 0 ],
                    "order": 1,
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "order": 0,
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
                    "destination": [ "obj-35", 0 ],
                    "source": [ "obj-40", 0 ]
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
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-84", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-23": [ "live.menu", "live.menu", 0 ],
            "obj-27": [ "live.tab", "live.tab", 0 ],
            "obj-5": [ "mc.live.gain~", "mc.live.gain~", 0 ],
            "obj-6::obj-1": [ "live.dial", "Grainrate", 0 ],
            "obj-6::obj-101": [ "live.dial[17]", "Rspread (3)", 0 ],
            "obj-6::obj-103": [ "live.dial[18]", "Spatialcorr (3)", 0 ],
            "obj-6::obj-107": [ "live.dial[19]", "Pitchmin", 0 ],
            "obj-6::obj-109": [ "live.dial[20]", "Pitchmax", 0 ],
            "obj-6::obj-110": [ "live.menu[2]", "live.menu", 0 ],
            "obj-6::obj-111": [ "live.dial[22]", "Trajrate", 0 ],
            "obj-6::obj-115": [ "live.dial[21]", "Trajdepth", 0 ],
            "obj-6::obj-117": [ "live.dial[23]", "Spiral", 0 ],
            "obj-6::obj-119": [ "live.dial[24]", "Pendulum", 0 ],
            "obj-6::obj-12": [ "Fixedchan", "Fixedchan", 0 ],
            "obj-6::obj-16": [ "live.dial[4]", "Duration", 0 ],
            "obj-6::obj-17": [ "live.dial[5]", "Playback", 0 ],
            "obj-6::obj-18": [ "live.dial[6]", "Amplitude", 0 ],
            "obj-6::obj-19": [ "live.dial[7]", "Envelope", 0 ],
            "obj-6::obj-2": [ "live.dial[1]", "Async", 0 ],
            "obj-6::obj-22": [ "live.dial[8]", "FilterFreq", 0 ],
            "obj-6::obj-23": [ "live.dial[9]", "Resonance", 0 ],
            "obj-6::obj-24": [ "live.dial[14]", "RRstep", 0 ],
            "obj-6::obj-26": [ "live.dial[10]", "Pan (Stereo)", 0 ],
            "obj-6::obj-28": [ "live.dial[15]", "Rspread (2)", 0 ],
            "obj-6::obj-29": [ "live.dial[11]", "ScanSpeed", 0 ],
            "obj-6::obj-3": [ "live.dial[2]", "Intermittency", 0 ],
            "obj-6::obj-30": [ "live.dial[12]", "ScanStart", 0 ],
            "obj-6::obj-31": [ "live.dial[13]", "ScanRange", 0 ],
            "obj-6::obj-4": [ "live.dial[3]", "Streams", 0 ],
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
            "obj-6::obj-89": [ "live.dial[16]", "Spatialcorr (2)", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "parameter_overrides": {
                "obj-6::obj-110": {
                    "parameter_longname": "live.menu[2]"
                },
                "obj-6::obj-7": {
                    "parameter_longname": "live.menu[1]"
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}