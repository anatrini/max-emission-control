# Lista di Controllo per Test e Validazione ec2~

**Documento per TEST - Solo Uso Locale**
Versione: 1.0.0-alpha
Data: Dicembre 2025

---

## Indice

1. [Test Patch Max](#test-patch-max)
2. [Verifica Parametri](#verifica-parametri)
3. [Confronto con EmissionControl2 Standalone](#confronto-con-emissioncontrol2-standalone)
4. [Test Multichannel](#test-multichannel)
5. [Test OSC Integration](#test-osc-integration)
6. [Test LFO e Modulazione](#test-lfo-e-modulazione)
7. [Test Stabilità](#test-stabilità)
8. [Documentazione](#documentazione)

---

## Test Patch Max

### 1.1 Completamento GUI (ec2_GUI.maxpat)

**Obiettivo**: Verificare che tutti i 108 parametri siano presenti e funzionanti nella patch GUI.

**Task**:
- [ ] Aprire `patchers/ec2_GUI.maxpat`
- [ ] Verificare presenza di tutti i controlli per parametri di sintesi (14 parametri)
- [ ] Verificare presenza di tutti i controlli per deviazioni (14 parametri)
- [ ] Verificare presenza di tutti i controlli LFO (6 LFO × 4 parametri = 24 controlli)
- [ ] Verificare presenza di tutti i controlli modulation routing (14 parametri × 2 = 28 controlli)
- [ ] Verificare presenza controlli spatial allocation (11 parametri)
- [ ] Verificare presenza attributi (@outputs, @mc, @buffer, @allocmode)

**Parametri da includere**:

**Sintesi Base (14)**:
- grainrate, async, intermittency, streams
- playback, duration, envelope, amplitude
- filterfreq, resonance, pan
- scanstart, scanrange, scanspeed

**Deviazioni (14)**:
- grainrate_dev, async_dev, intermittency_dev, streams_dev
- playback_dev, duration_dev, envelope_dev, amp_dev
- filterfreq_dev, resonance_dev, pan_dev
- scanstart_dev, scanrange_dev, scanspeed_dev

**LFO (24 = 6 × 4)**:
- lfo1shape, lfo1rate, lfo1polarity, lfo1duty
- (ripetere per lfo2, lfo3, lfo4, lfo5, lfo6)

**Modulation Routing (28 = 14 × 2)**:
- grainrate_lfosource, grainrate_moddepth
- async_lfosource, async_moddepth
- (ripetere per tutti i 14 parametri modulabili)

**Note**:
- Usare controlli appropriati: slider per valori continui, number box per interi, umenu per selezioni discrete
- Per lfosource usare umenu con valori: "none (0)", "LFO1 (1)", "LFO2 (2)", ..., "LFO6 (6)"
- Organizzare GUI in sezioni logiche (Synthesis, Deviation, LFO, Modulation, Spatial)

### 1.2 Test Patch Base (ec2_testpatch.maxpat)

**Task**:
- [ ] Aprire `patchers/ec2_testpatch.maxpat`
- [ ] Caricare un buffer~ di test con audio significativo
- [ ] Verificare che il parametro `buffer` punti correttamente al buffer~
- [ ] Testare audio output in uscita (deve suonare!)
- [ ] Provare a cambiare grainrate, duration, amplitude - verificare cambiamenti udibili

---

## Verifica Parametri

### 2.1 Test Parametri Individuali

**Obiettivo**: Verificare che ogni parametro risponda correttamente e produca l'effetto atteso.

**Procedura per ogni parametro**:
1. Impostare ec2~ con valori di default
2. Variare SOLO il parametro in test
3. Ascoltare e documentare l'effetto
4. Verificare che i valori siano nel range corretto

#### Parametri di Sintesi

| Parametro | Range | Default | Test | Note |
|-----------|-------|---------|------|------|
| grainrate | 0.1-500 Hz | 20.0 | Testare 1, 20, 100 Hz | Densità grani |
| async | 0.0-1.0 | 0.0 | Testare 0, 0.5, 1.0 | Casualità temporale |
| intermittency | 0.0-1.0 | 0.0 | Testare 0, 0.5, 1.0 | Probabilità dropout |
| streams | 1-20 | 1 | Testare 1, 5, 10 | Polifonia |
| playback | -32 to 32 | 1.0 | Testare 0.5, 1.0, 2.0 | Trasposizione |
| duration | 1-1000 ms | 100.0 | Testare 10, 100, 500 | Lunghezza grani |
| envelope | 0.0-1.0 | 0.5 | Testare 0, 0.5, 1.0 | Forma inviluppo |
| amplitude | 0.0-1.0 | 0.5 | Testare 0.2, 0.5, 0.8 | Volume output |
| filterfreq | 20-22000 Hz | 1000.0 | Testare 500, 1000, 5000 | Filtro lowpass |
| resonance | 0.0-1.0 | 0.0 | Testare 0, 0.5, 0.9 | Enfasi filtro |
| pan | -1.0 to 1.0 | 0.0 | Testare -1, 0, 1 | Posizione stereo |
| scanstart | 0.0-1.0 | 0.5 | Testare 0, 0.5, 1.0 | Posizione lettura buffer |
| scanrange | 0.0-1.0 | 1.0 | Testare 0.1, 0.5, 1.0 | Ampiezza finestra scan |
| scanspeed | -32 to 32 | 1.0 | Testare 0, 1, 5 | Velocità scansione |

**Checklist**:
- [ ] Tutti i 14 parametri di sintesi testati individualmente
- [ ] Range di valori verificati (nessun crash con valori estremi)
- [ ] Effetti sonori corrispondono alle aspettative
- [ ] Valori di default corretti (scanstart=0.5, filterfreq=1000)

#### Parametri di Deviazione

**Procedura**:
1. Impostare parametro base (es. grainrate=50)
2. Aumentare gradualmente la deviazione (es. grainrate_dev: 0 → 5 → 10 → 20)
3. Verificare aumento della variazione/randomizzazione

**Checklist**:
- [ ] grainrate_dev: testare 0, 10, 50 (effetto su regolarità temporale)
- [ ] playback_dev: testare 0, 0.05, 0.2 (effetto detune/chorus)
- [ ] duration_dev: testare 0, 20, 100 (variazione lunghezza grani)
- [ ] pan_dev: testare 0, 0.3, 1.0 (spazializzazione stereo)
- [ ] filterfreq_dev: testare 0, 500, 2000 (variazione timbro)
- [ ] Tutte le altre 9 deviazioni testate
- [ ] Verificare che dev=0 elimini completamente la variazione

---

## Confronto con EmissionControl2 Standalone

### 3.1 Setup Ambiente di Test

**Requisiti**:
- EmissionControl2 standalone installato e funzionante
- ec2~ caricato in Max
- Stesso file audio sorgente caricato in entrambi
- Impostazioni iniziali identiche

### 3.2 Test Comparativi

**Obiettivo**: Verificare che ec2~ produca risultati sonori simili a EmissionControl2 con parametri identici.

**Procedura**:

1. **Test Base - Suono Neutro**
   - [ ] Caricare stesso audio in entrambi
   - [ ] Impostare parametri identici: grainrate=20, duration=100, playback=1, amplitude=0.5
   - [ ] Registrare output di entrambi (10 secondi)
   - [ ] Confrontare spettrogrammi (es. in Audacity o Sonic Visualiser)
   - [ ] **Aspettativa**: Texture sonora simile, non identica ma comparabile

2. **Test Grain Rate**
   - [ ] EC2: grainrate=10, ec2~: grainrate=10
   - [ ] Ascoltare e confrontare densità grani
   - [ ] Ripetere con grainrate=50, 100
   - [ ] **Aspettativa**: Densità percepita simile

3. **Test Trasposizione**
   - [ ] Testare playback=0.5, 1.0, 2.0 in entrambi
   - [ ] Verificare pitch shift equivalente
   - [ ] **Aspettativa**: Stessa trasposizione

4. **Test LFO**
   - [ ] EmissionControl2: assegnare LFO1 a grainrate
   - [ ] ec2~: grainrate_lfosource=1, grainrate_moddepth=0.5
   - [ ] Verificare modulazione simile
   - [ ] **Aspettativa**: Modulazione comparabile

5. **Test Spatial Allocation**
   - [ ] Configurare entrambi con 8 canali
   - [ ] Testare modalità: Round-robin, Random, Weighted
   - [ ] Verificare distribuzione spaziale
   - [ ] **Aspettativa**: Grains distribuiti in modo simile

**Checklist Generale**:
- [ ] Test base completato - somiglianza verificata
- [ ] Test trasposizione completato
- [ ] Test LFO completato
- [ ] Test spazializzazione completato
- [ ] Documentare eventuali differenze significative (non per correzione codice, solo reportistica)

**Note importanti**:
- Non ci si aspetta output bit-identical (algoritmi di random diversi)
- Focus su somiglianza timbrica e comportamentale
- Se differenze sostanziali: documentare dettagliatamente per revisione

---

## Test Multichannel

### 4.1 Test Modalità Separated Outputs (@mc 0)

**Setup**: `[ec2~ @outputs 8 @mc 0]`

**Checklist**:
- [ ] Verificare che l'oggetto mostri 8 outlet separati
- [ ] Collegare ogni outlet a dac~ diverso (dac~ 1, dac~ 2, ..., dac~ 8)
- [ ] Verificare audio su tutti gli 8 canali
- [ ] Testare allocmode=1 (round-robin): verificare rotazione tra canali
- [ ] Testare allocmode=2 (random): verificare distribuzione casuale
- [ ] Testare con @outputs 2, 4, 16 (verificare scalabilità)

### 4.2 Test Modalità Multichannel Cable (@mc 1)

**Setup**: `[ec2~ @outputs 8 @mc 1]`

**Checklist**:
- [ ] Verificare che l'oggetto mostri 1 outlet multichannel (cavo blu/nero)
- [ ] Collegare a `[mc.unpack~ 8]`
- [ ] Verificare audio su tutti gli 8 canali
- [ ] Testare con mc.mixdown~ e altri oggetti MC di Max
- [ ] Testare con @outputs 16 @mc 1 (massimo canali)

### 4.3 Test Spatial Allocation Modes

**Setup**: `[ec2~ @outputs 8]`

| Allocmode | Nome | Test |
|-----------|------|------|
| 0 | Fixed | Verificare tutti grains su 1 canale (@fixedchan 3) |
| 1 | Round-robin | Verificare sequenza circolare con @rrstep 1, 2 |
| 2 | Random | Verificare distribuzione casuale uniforme |
| 3 | Weighted | Verificare distribuzione pesata (@randspread) |
| 4 | Load-balance | Verificare bilanciamento carico tra canali |
| 5 | Pitch-map | Verificare mappatura pitch→canale (@pitchmin, @pitchmax) |
| 6 | Trajectory | Verificare movimento spaziale (@trajshape, @trajrate) |

**Checklist**:
- [ ] Tutti i 7 allocation modes testati
- [ ] Parametri specifici verificati per ogni mode
- [ ] Distribuzione spaziale conforme alle aspettative
- [ ] Nessun canale rimane muto inaspettatamente

---

## Test OSC Integration

### 5.1 Test OSC Output (odot)

**Setup**:
```
[ec2~]
|
[o.display]
```

**Checklist**:
- [ ] Verificare che o.display mostri bundle OSC automaticamente
- [ ] Cambiare parametro (es. grainrate 50) → verificare aggiornamento bundle
- [ ] Verificare che tutti i parametri siano presenti nel bundle
- [ ] Verificare ordine parametri nel bundle (deve essere consistente)
- [ ] Testare suppress_osc 1 → verificare che o.display si fermi
- [ ] Testare suppress_osc 0 → verificare ripresa output

### 5.2 Test OSC Input (FullPacket)

**Setup**:
```
[udpreceive 9000]
|
[o.route /ec2]
|
[ec2~]
```

**Checklist**:
- [ ] Inviare bundle OSC da altro computer o processo
- [ ] Verificare ricezione e applicazione parametri
- [ ] Testare singoli messaggi: /grainrate 30, /filterfreq 2000
- [ ] Testare bundle multipli (più parametri insieme)
- [ ] Verificare che parametri OSC abbiano effetto sonoro

### 5.3 Test Compatibilità odot

**Setup**:
```
[o.compose /grainrate 100 /duration 200]
|
[o.pack]
|
[ec2~]
```

**Checklist**:
- [ ] Verificare parsing corretto di bundle odot
- [ ] Testare tutti i tipi di dato: float, int, double
- [ ] Verificare che bundle complessi vengano parsati correttamente
- [ ] Testare bidirezionale: ec2~ → o.display → o.route → ec2~ (loopback)

---

## Test LFO e Modulazione

### 6.1 Test LFO Individuali

**Per ogni LFO (1-6)**:

**Setup**: `[ec2~ @buffer mybuffer]` + controlli LFO

**Checklist per ogni LFO**:
- [ ] **Shape**: testare tutte le forme (0-4: sine, square, rise, fall, noise)
  - Sine: verificare modulazione fluida
  - Square: verificare switch netto tra valori
  - Rise/Fall: verificare rampe lineari
  - Noise: verificare valori casuali

- [ ] **Rate**: testare 0.1 Hz (lento), 1 Hz (medio), 10 Hz (veloce)
  - Verificare che frequenza percepita corrisponda al valore impostato

- [ ] **Polarity**: testare 0 (bipolar), 1 (unipolar+), 2 (unipolar-)
  - Bipolar: modulazione sopra e sotto valore base
  - Unipolar+: solo sopra valore base
  - Unipolar-: solo sotto valore base

- [ ] **Duty**: (solo per square) testare 0.25, 0.5, 0.75
  - Verificare proporzione high/low corretta

### 6.2 Test Modulation Routing

**Obiettivo**: Verificare che ogni parametro possa essere modulato da ogni LFO.

**Procedura tipo**:
1. Impostare LFO1: shape=0 (sine), rate=1.0, polarity=0 (bipolar)
2. Assegnare a parametro: `grainrate_lfosource 1`, `grainrate_moddepth 0.5`
3. Ascoltare effetto modulazione
4. Verificare che grainrate oscilli sopra/sotto valore base

**Checklist prioritaria** (parametri più critici):
- [ ] grainrate_lfosource + moddepth: modulazione densità grani
- [ ] playback_lfosource + moddepth: vibrato/wobble pitch
- [ ] filterfreq_lfosource + moddepth: wah-wah effect
- [ ] amplitude_lfosource + moddepth: tremolo
- [ ] pan_lfosource + moddepth: auto-pan stereo
- [ ] duration_lfosource + moddepth: variazione lunghezza grani
- [ ] scanstart_lfosource + moddepth: scansione automatica buffer

**Checklist secondaria**:
- [ ] async_lfosource + moddepth
- [ ] intermittency_lfosource + moddepth
- [ ] streams_lfosource + moddepth
- [ ] envelope_lfosource + moddepth
- [ ] resonance_lfosource + moddepth
- [ ] scanrange_lfosource + moddepth
- [ ] scanspeed_lfosource + moddepth

### 6.3 Test Modulation Depth

**Procedura**:
1. Assegnare LFO a parametro (es. filterfreq_lfosource 1)
2. Testare moddepth: 0.0, 0.25, 0.5, 0.75, 1.0
3. Verificare che:
   - depth=0.0: nessuna modulazione
   - depth=0.5: modulazione media
   - depth=1.0: modulazione massima (full range)

**Checklist**:
- [ ] Depth=0 elimina completamente modulazione
- [ ] Depth aumenta linearmente l'escursione
- [ ] Depth=1.0 non causa valori fuori range

### 6.4 Test Modulation Multiple Simultanee

**Scenario**: Più parametri modulati contemporaneamente

**Setup**:
```
LFO1 → grainrate (depth=0.6)
LFO2 → filterfreq (depth=0.7)
LFO3 → pan (depth=0.5)
```

**Checklist**:
- [ ] Tutte le modulazioni funzionano simultaneamente
- [ ] Nessuna interferenza tra LFO
- [ ] Texture sonora complessa e dinamica
- [ ] CPU usage accettabile (< 50% su M1)

---

## Test Stabilità

### 7.1 Test Long-Running

**Obiettivo**: Verificare stabilità a lungo termine

**Procedura**:
1. Configurare ec2~ con grainrate=50, streams=5
2. Avviare audio in Max
3. Lasciare in esecuzione per 30 minuti
4. Monitorare CPU, memoria, eventuali glitch audio

**Checklist**:
- [ ] Nessun crash dopo 30 minuti
- [ ] CPU usage stabile (non aumenta progressivamente)
- [ ] Memoria stabile (no memory leak)
- [ ] Audio continuo senza interruzioni
- [ ] Nessun messaggio di errore in console Max

### 7.2 Test Parameter Sweep

**Obiettivo**: Stress test con cambiamenti rapidi di parametri

**Procedura**:
1. Usare `[line~]` o `[drunk]` per cambiare parametri rapidamente
2. Variare grainrate 10-200 velocemente
3. Variare playback -2 to 2 velocemente
4. Cambiare allocmode casualmente

**Checklist**:
- [ ] Nessun crash con cambiamenti rapidi
- [ ] Audio risponde correttamente (no glitch)
- [ ] Nessun messaggio di errore

### 7.3 Test Buffer Changes

**Obiettivo**: Verificare cambio buffer runtime

**Procedura**:
1. Avviare ec2~ con buffer1
2. Durante playback: `buffer buffer2`
3. Verificare transizione
4. Testare con buffer di dimensioni diverse
5. Testare buffer vuoto o non esistente

**Checklist**:
- [ ] Cambio buffer durante playback: nessun crash
- [ ] Audio si adatta al nuovo buffer
- [ ] Buffer non esistente: nessun crash, messaggio di warning appropriato
- [ ] Buffer vuoto: gestito correttamente

### 7.4 Test Extreme Values

**Obiettivo**: Verificare robustezza con valori estremi

**Checklist**:
- [ ] grainrate=0.1 (molto lento): funziona
- [ ] grainrate=500 (molto veloce): funziona, nessun overload
- [ ] duration=1ms: grains brevissimi udibili
- [ ] duration=1000ms: grains lunghissimi funzionano
- [ ] playback=-32: reverse massimo funziona
- [ ] playback=32: fast forward massimo funziona
- [ ] streams=20: massima polifonia, CPU accettabile
- [ ] Tutti i parametri ai valori min/max: nessun crash

---

## Documentazione

### 8.1 Verifica README.md

**Checklist**:
- [ ] Versione corretta (1.0.0-alpha)
- [ ] Istruzioni installazione chiare e testate
- [ ] Build from source: verificare che le istruzioni funzionino
- [ ] Esempi Quick Start funzionanti
- [ ] Parametri documentati corrispondono al codice
- [ ] Link GitHub corretti
- [ ] Credits corretti (Curtis Roads, Jack Kilgore, Rodney DuPlessis, Alessandro Anatrini)
- [ ] Copyright year automatico funzionante

### 8.2 Verifica EC2_HELP_REFERENCE.md

**Checklist**:
- [ ] Tutti i 108 parametri documentati
- [ ] Range valori corretti per ogni parametro
- [ ] Valori default corretti (scanstart=0.5, filterfreq=1000)
- [ ] Esempi funzionanti e testabili
- [ ] Sezione LFO completa e accurata
- [ ] Sezione modulation routing aggiornata
- [ ] Sezione OSC completa
- [ ] Sezione spatial allocation completa

### 8.3 Banner Version Check

**Checklist**:
- [ ] Aprire Max, creare `[ec2~]`
- [ ] Verificare banner in console Max:
  ```
  ——————————————————————————————————————————————————————————————————
  ec2~ version 1.0.0-alpha-xxxxxxx (compiled Dec 08 2025 17:xx:xx)
  based on EmissionControl2 by Curtis Roads, Jack Kilgore, Rodney DuPlessis
  Max port, spatial audio & multichannel allocation by Alessandro Anatrini ©2025
  ——————————————————————————————————————————————————————————————————
  ```
- [ ] Git commit hash presente
- [ ] Copyright year corretto (©2025)
- [ ] Credits completi e corretti

---

## Report Finale

Dopo aver completato tutti i test, compilare un report con:

### Template Report

```markdown
# Report Test ec2~ v1.0.0-alpha

**Data**: [inserire data]
**Testato da**: [nome]
**Piattaforma**: macOS [versione] / Apple Silicon o Intel
**Max Version**: [versione]

## Riepilogo

- Test completati: XX/YY
- Test passati: XX
- Test falliti: XX
- Issues trovati: XX

## Dettagli Test

### Patch Max
- [ ] GUI completa
- [ ] Tutti i parametri accessibili
- Note: [...]

### Verifica Parametri
- [ ] Parametri sintesi: XX/14 testati
- [ ] Parametri deviation: XX/14 testati
- [ ] LFO: XX/24 testati
- [ ] Modulation routing: XX/28 testati
- Note: [...]

### Confronto EmissionControl2
- [ ] Test base: [PASS/FAIL]
- [ ] Somiglianza sonora: [Ottima/Buona/Accettabile/Insufficiente]
- Differenze notate: [...]

### Multichannel
- [ ] Separated outputs: [PASS/FAIL]
- [ ] MC mode: [PASS/FAIL]
- [ ] Allocation modes: XX/7 testati
- Note: [...]

### OSC Integration
- [ ] OSC output: [PASS/FAIL]
- [ ] OSC input: [PASS/FAIL]
- [ ] Compatibilità odot: [PASS/FAIL]
- Note: [...]

### LFO e Modulazione
- [ ] LFO individuali: XX/6 testati
- [ ] Modulation routing: [PASS/FAIL]
- [ ] Modulation depth: [PASS/FAIL]
- Note: [...]

### Stabilità
- [ ] Long-running: [PASS/FAIL]
- [ ] Parameter sweep: [PASS/FAIL]
- [ ] Buffer changes: [PASS/FAIL]
- [ ] Extreme values: [PASS/FAIL]
- Note: [...]

### Documentazione
- [ ] README.md: [OK/NEEDS UPDATE]
- [ ] EC2_HELP_REFERENCE.md: [OK/NEEDS UPDATE]
- [ ] Banner: [OK/NEEDS UPDATE]

## Issues Trovati

### Issue #1: [Titolo]
- **Gravità**: [Critica/Alta/Media/Bassa]
- **Descrizione**: [...]
- **Steps to reproduce**: [...]
- **Comportamento atteso**: [...]
- **Comportamento attuale**: [...]

[Ripetere per ogni issue]

## Raccomandazioni

1. [...]
2. [...]

## Conclusioni

[Valutazione generale dello stato del software]
```

---

## Note Importanti

- **NON modificare il codice sorgente**: questo documento è solo per test e reportistica
- **Documentare tutto**: anche comportamenti strani o inaspettati, anche se non sono necessariamente bug
- **Essere sistematici**: seguire l'ordine delle checklist per completezza
- **Audio recordings**: quando possibile, registrare esempi audio dei test per riferimento futuro
- **Screenshots**: catturare screenshot della GUI e delle configurazioni di test

---

**Fine documento**
