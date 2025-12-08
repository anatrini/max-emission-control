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
        "rect": [ 40.0, 108.0, 1089.0, 832.0 ],
        "boxes": [
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
                    "patching_rect": [ 81.0, 4.0, 482.0, 165.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "id": "obj-3",
                    "linecount": 28,
                    "maxclass": "o.display",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 911.0, 321.5, 248.0, 379.0 ],
                    "text": "/grainrate : 26.0305,\n/async : 0.,\n/intermittency : 0.,\n/streams : 1.,\n/playback : 1.,\n/duration : 100.,\n/envelope : 0.5,\n/scanstart : 0.5,\n/scanrange : 1.,\n/amplitude : 0.5,\n/filterfreq : 1000.,\n/resonance : 0.,\n/pan : 0.,\n/scanspeed : 1.,\n/grainrate_dev : 0.,\n/async_dev : 0.,\n/intermittency_dev : 0.,\n/streams_dev : 0.,\n/playback_dev : 0.,\n/duration_dev : 0.,\n/envelope_dev : 0.,\n/pan_dev : 0.,\n/amp_dev : 0.,\n/filterfreq_dev : 0.,\n/resonance_dev : 0.,\n/scanstart_dev : 0.,\n/scanrange_dev : 0.,\n/scanspeed_dev : 0."
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
                    "fontface": 0,
                    "id": "obj-7",
                    "linecount": 14,
                    "maxclass": "o.display",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 458.0, 397.0, 150.0, 200.0 ],
                    "text": "/pan : 0.,\n/grainrate : 26.0305,\n/async : 0.,\n/intermittency : 0.,\n/streams : 1,\n/duration : 100,\n/playback : 1.,\n/amp : 0.5,\n/envelope : 0.5,\n/filterfreq : 1000.,\n/resonance : 0.,\n/scanspeed : 1.,\n/scanstart : 0.5,\n/scanrange : 1."
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 743.0, 195.0, 142.0, 22.0 ],
                    "text": "udpreceive 8000 CNMAT"
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
                        "fixedchan": 0,
                        "mc": 1,
                        "outputs": 2,
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
                    "patching_rect": [ 1006.0, 237.0, 48.0, 22.0 ],
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
                    "patching_rect": [ 1006.0, 279.0, 95.0, 22.0 ],
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
                    "destination": [ "obj-5", 0 ],
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
                    "destination": [ "obj-1", 0 ],
                    "order": 0,
                    "source": [ "obj-21", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "order": 1,
                    "source": [ "obj-21", 0 ]
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
                    "destination": [ "obj-2", 0 ],
                    "source": [ "obj-5", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-5": [ "mc.live.gain~", "mc.live.gain~", 0 ],
            "obj-6::obj-1": [ "live.dial", "Grainrate", 0 ],
            "obj-6::obj-16": [ "live.dial[4]", "Duration", 0 ],
            "obj-6::obj-17": [ "live.dial[5]", "Playback", 0 ],
            "obj-6::obj-18": [ "live.dial[6]", "Amplitude", 0 ],
            "obj-6::obj-19": [ "live.dial[7]", "Envelope", 0 ],
            "obj-6::obj-2": [ "live.dial[1]", "Async", 0 ],
            "obj-6::obj-22": [ "live.dial[8]", "FilterFreq", 0 ],
            "obj-6::obj-23": [ "live.dial[9]", "Resonance", 0 ],
            "obj-6::obj-26": [ "live.dial[10]", "Pan (Stereo)", 0 ],
            "obj-6::obj-29": [ "live.dial[11]", "ScanSpeed", 0 ],
            "obj-6::obj-3": [ "live.dial[2]", "Intermittency", 0 ],
            "obj-6::obj-30": [ "live.dial[12]", "ScanStart", 0 ],
            "obj-6::obj-31": [ "live.dial[13]", "ScanRange", 0 ],
            "obj-6::obj-4": [ "live.dial[3]", "Streams", 0 ],
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
        "autosave": 0
    }
}