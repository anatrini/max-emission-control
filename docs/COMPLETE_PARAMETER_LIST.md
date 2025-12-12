# ec2~ - Lista Completa Parametri

**Versione**: 1.0.0-alpha
**Data**: Dicembre 2025

---

## Riepilogo Totale

| Categoria | Numero Parametri | Tipo |
|-----------|-----------------|------|
| **Attributi** | 5 | @ (set at creation) |
| **Sintesi Base** | 14 | messages |
| **Deviazioni** | 14 | messages |
| **LFO** | 30 | messages (6 LFOs × 5 params) |
| **Modulation Routing** | 28 | messages (14 params × 2 controls) |
| **Spatial Allocation** | 12 | messages |
| **TOTALE** | **103** | |

---

## 1. ATTRIBUTI (5 total)

Attributi strutturali configurati con `@` - **da impostare alla creazione dell'oggetto**.

### Output Configuration (2)
- `@outputs` (int, 1-16, default: 2) - Numero di canali output
- `@mc` (int, 0-1, default: 0) - Multichannel cable mode

### Buffer (1)
- `@buffer` (symbol, default: none) - Nome del buffer~ sorgente

### Spatial Allocation Mode (2)
- `@allocmode` (int, 0-6, default: 1) - Modalità allocazione spaziale
- `@soundfile` (int, 0-15, default: 0) - Indice file audio

---

## 2. PARAMETRI DI SINTESI (14 total)

Messaggi per controllo real-time dei parametri di sintesi.

### Grain Scheduling (4)
- `grainrate` (float, 0.1-500 Hz, default: 20.0) - Frequenza emissione grani
- `async` (float, 0.0-1.0, default: 0.0) - Asincronia temporale
- `intermittency` (float, 0.0-1.0, default: 0.0) - Probabilità dropout grani
- `streams` (int, 1-20, default: 1) - Numero stream polifonici

### Grain Characteristics (4)
- `playback` (float, -32 to 32, default: 1.0) - Velocità riproduzione/trasposizione
- `duration` (float, 1-1000 ms, default: 100.0) - Durata grani
- `envelope` (float, 0.0-1.0, default: 0.5) - Forma inviluppo (0=Hann, 1=Exp)
- `amplitude` (float, 0.0-1.0, default: 0.5) - Ampiezza output

### Filtering (2)
- `filterfreq` (float, 20-22000 Hz, default: 1000.0) - Frequenza filtro lowpass
- `resonance` (float, 0.0-1.0, default: 0.0) - Risonanza filtro

### Spatial/Scanning (4)
- `pan` (float, -1.0 to 1.0, default: 0.0) - Posizione panorama stereo
- `scanstart` (float, 0.0-1.0, default: 0.5) - Posizione inizio scansione buffer
- `scanrange` (float, 0.0-1.0, default: 1.0) - Ampiezza finestra scansione
- `scanspeed` (float, -32 to 32, default: 1.0) - Velocità scansione automatica

---

## 3. PARAMETRI DI DEVIAZIONE (14 total)

Deviazioni statistiche (Curtis Roads: stochastic grain clouds).
Ogni parametro aggiunge variazione casuale uniforme (±) al valore base.

### Grain Scheduling Deviations (4)
- `grainrate_dev` (float, 0-250 Hz, default: 0.0) - Deviazione frequenza grani
- `async_dev` (float, 0.0-0.5, default: 0.0) - Deviazione asincronia
- `intermittency_dev` (float, 0.0-0.5, default: 0.0) - Deviazione intermittenza
- `streams_dev` (float, 0-10, default: 0.0) - Deviazione numero stream

### Grain Characteristics Deviations (4)
- `playback_dev` (float, 0-16, default: 0.0) - Deviazione playback rate
- `duration_dev` (float, 0-500 ms, default: 0.0) - Deviazione durata grani
- `envelope_dev` (float, 0.0-0.5, default: 0.0) - Deviazione forma inviluppo
- `amp_dev` (float, 0.0-0.5, default: 0.0) - Deviazione ampiezza

### Filtering Deviations (2)
- `filterfreq_dev` (float, 0-11000 Hz, default: 0.0) - Deviazione frequenza filtro
- `resonance_dev` (float, 0.0-0.5, default: 0.0) - Deviazione risonanza

### Spatial/Scanning Deviations (4)
- `pan_dev` (float, 0.0-1.0, default: 0.0) - Deviazione panorama
- `scanstart_dev` (float, 0.0-0.5, default: 0.0) - Deviazione posizione scan
- `scanrange_dev` (float, 0.0-0.5, default: 0.0) - Deviazione ampiezza scan
- `scanspeed_dev` (float, 0-16, default: 0.0) - Deviazione velocità scan

---

## 4. LFO PARAMETERS (30 total = 6 LFOs × 5 params)

ec2~ include 6 LFO indipendenti (LFO1-LFO6) per modulazione dinamica. Ogni LFO ha 5 parametri di controllo.

### LFO1 (5 params)
- `lfo1shape` (int, 0-4, default: 0) - Forma d'onda (0=Sine, 1=Square, 2=Rise, 3=Fall, 4=Noise)
- `lfo1rate` (float, 0.001-100 Hz, default: 1.0) - Frequenza oscillazione
- `lfo1polarity` (int, 0-2, default: 0) - Polarità (0=Bipolar ±1, 1=Unipolar+ 0→1, 2=Unipolar- -1→0)
- `lfo1duty` (float, 0.0-1.0, default: 0.5) - Duty cycle (solo square wave)
- `lfo1_depth` (float, 0.0-1.0, default: 1.0) - Depth globale che scala TUTTE le destinazioni

### LFO2 (5 params)
- `lfo2shape` (int, 0-4, default: 0)
- `lfo2rate` (float, 0.001-100 Hz, default: 1.0)
- `lfo2polarity` (int, 0-2, default: 0)
- `lfo2duty` (float, 0.0-1.0, default: 0.5)
- `lfo2_depth` (float, 0.0-1.0, default: 1.0)

### LFO3 (5 params)
- `lfo3shape` (int, 0-4, default: 0)
- `lfo3rate` (float, 0.001-100 Hz, default: 1.0)
- `lfo3polarity` (int, 0-2, default: 0)
- `lfo3duty` (float, 0.0-1.0, default: 0.5)
- `lfo3_depth` (float, 0.0-1.0, default: 1.0)

### LFO4 (5 params)
- `lfo4shape` (int, 0-4, default: 0)
- `lfo4rate` (float, 0.001-100 Hz, default: 1.0)
- `lfo4polarity` (int, 0-2, default: 0)
- `lfo4duty` (float, 0.0-1.0, default: 0.5)
- `lfo4_depth` (float, 0.0-1.0, default: 1.0)

### LFO5 (5 params)
- `lfo5shape` (int, 0-4, default: 0)
- `lfo5rate` (float, 0.001-100 Hz, default: 1.0)
- `lfo5polarity` (int, 0-2, default: 0)
- `lfo5duty` (float, 0.0-1.0, default: 0.5)
- `lfo5_depth` (float, 0.0-1.0, default: 1.0)

### LFO6 (5 params)
- `lfo6shape` (int, 0-4, default: 0)
- `lfo6rate` (float, 0.001-100 Hz, default: 1.0)
- `lfo6polarity` (int, 0-2, default: 0)
- `lfo6duty` (float, 0.0-1.0, default: 0.5)
- `lfo6_depth` (float, 0.0-1.0, default: 1.0)

---

## 5. MODULATION ROUTING (28 total = 14 params × 2 controls)

Sistema di routing per assegnare LFO ai parametri di sintesi.
Ogni parametro ha 2 controlli: sorgente LFO e profondità modulazione.

### Grain Scheduling Routing (8 = 4 × 2)
- `grainrate_lfosource` (int, 0-6, default: 0) - LFO sorgente (0=none, 1-6=LFO number)
- `grainrate_moddepth` (float, 0.0-1.0, default: 0.0) - Profondità modulazione
- `async_lfosource` (int, 0-6, default: 0)
- `async_moddepth` (float, 0.0-1.0, default: 0.0)
- `intermittency_lfosource` (int, 0-6, default: 0)
- `intermittency_moddepth` (float, 0.0-1.0, default: 0.0)
- `streams_lfosource` (int, 0-6, default: 0)
- `streams_moddepth` (float, 0.0-1.0, default: 0.0)

### Grain Characteristics Routing (8 = 4 × 2)
- `playback_lfosource` (int, 0-6, default: 0)
- `playback_moddepth` (float, 0.0-1.0, default: 0.0)
- `duration_lfosource` (int, 0-6, default: 0)
- `duration_moddepth` (float, 0.0-1.0, default: 0.0)
- `envelope_lfosource` (int, 0-6, default: 0)
- `envelope_moddepth` (float, 0.0-1.0, default: 0.0)
- `amplitude_lfosource` (int, 0-6, default: 0)
- `amplitude_moddepth` (float, 0.0-1.0, default: 0.0)

### Filtering Routing (4 = 2 × 2)
- `filterfreq_lfosource` (int, 0-6, default: 0)
- `filterfreq_moddepth` (float, 0.0-1.0, default: 0.0)
- `resonance_lfosource` (int, 0-6, default: 0)
- `resonance_moddepth` (float, 0.0-1.0, default: 0.0)

### Spatial/Scanning Routing (8 = 4 × 2)
- `pan_lfosource` (int, 0-6, default: 0)
- `pan_moddepth` (float, 0.0-1.0, default: 0.0)
- `scanstart_lfosource` (int, 0-6, default: 0)
- `scanstart_moddepth` (float, 0.0-1.0, default: 0.0)
- `scanrange_lfosource` (int, 0-6, default: 0)
- `scanrange_moddepth` (float, 0.0-1.0, default: 0.0)
- `scanspeed_lfosource` (int, 0-6, default: 0)
- `scanspeed_moddepth` (float, 0.0-1.0, default: 0.0)

---

## 6. SPATIAL ALLOCATION PARAMETERS (12 total)

**IMPORTANTE - Differenza tra ATTRIBUTI e PARAMETRI**:

**ATTRIBUTI** (5 totali: `@outputs`, `@mc`, `@buffer`, `@allocmode`, `@soundfile`):
- Impostabili in 3 modi:
  a) Alla creazione: `[ec2~ @outputs 8 @buffer mysound]`
  b) Con attrui (inspector Max)
  c) Come messaggi semplici (alcuni attributi)

**PARAMETRI** (tutti gli altri 94: grainrate, async, randspread, weights, etc.):
- Inviabili in 2 modi:
  1. **Messaggi OSC-style**: `/randspread 0.8`, `/weights 0.5 0.3 0.1 0.1`
  2. **FullPacket bundle** (odot): comunicazione OSC bidirezionale via outlet destro

---

Parametri di allocazione spaziale per controllo real-time.
Ogni modalità allocazione (@allocmode) usa parametri specifici.

### Fixed Channel Mode (allocmode=0) - 1 param
- `fixedchan` (int, 1-16, default: 1) - Numero canale fisso output (user-facing, convertito a 0-based internamente)

### Round-Robin Mode (allocmode=1) - 1 param
- `rrstep` (int, 1-16, default: 1) - Passo incremento round-robin

### Random Mode (allocmode=2) - 2 params
- `randspread` (float, 0.0-1.0, default: 0.0) - Panning tra canali adiacenti (0=hard, 1=full panning)
- `spatialcorr` (float, 0.0-1.0, default: 0.0) - Correlazione spaziale tra grani successivi

### Weighted Random Mode (allocmode=3) - 1 param (+ 2 shared)
- `weights` (list of floats, default: uniform) - Pesi probabilità per canale (auto-normalizzati)

**Nota:** Mode 3 condivide i parametri `randspread` e `spatialcorr` con Mode 2 (vedi sopra)

**Formato messaggio weights**:
- OSC-style: `/weights <valore1> <valore2> ... <valoreN>`
- Ogni valore corrisponde a un canale (0-indexed)
- Valori >= 0.0 (valori negativi vengono clampati a 0)
- Auto-normalizzazione automatica: somma sempre 1.0 internamente
- Messaggio vuoto resetta a distribuzione uniforme

**Esempi**:
```
[/weights 0.5 0.3 0.1 0.1(   // 4 canali: 50%, 30%, 10%, 10%
[/weights 5 3 1 1(           // Stesso risultato (auto-normalizzato)
[/weights(                   // Reset a uniforme
[/randspread 0.8(            // Altri parametri spatial
[/spatialcorr 0.3(
```

### Pitch-to-Space Mapping (allocmode=5) - 2 params
- `pitchmin` (float, 20-20000 Hz, default: 20.0) - Pitch minimo mappato a canale 0
- `pitchmax` (float, 20-20000 Hz, default: 20000.0) - Pitch massimo mappato a ultimo canale

### Trajectory Mode (allocmode=6) - 5 params
- `trajshape` (int, 0-5, default: 0) - Forma traiettoria:
  - **0**: Sine - Movimento sinusoidale avanti-indietro
  - **1**: Saw - Sweep lineare (dente di sega)
  - **2**: Triangle - Movimento triangolare avanti-indietro
  - **3**: Random walk - Movimento casuale vincolato
  - **4**: Spiral - Movimento spirale (richiede spiral_factor)
  - **5**: Pendulum - Oscillazione pendolo smorzato (richiede pendulum_decay)
- `trajrate` (float, 0.001-100 Hz, default: 1.0) - Velocità movimento traiettoria
- `trajdepth` (float, 0.0-1.0, default: 1.0) - Profondità/ampiezza movimento spaziale
- `spiral_factor` (float, 0.0-1.0, default: 0.0) - Strettezza spirale (0=cerchio puro, 1=spirale stretta)
- `pendulum_decay` (float, 0.0-1.0, default: 0.1) - Fattore smorzamento pendolo (0=nessuno, 1=pesante)

**Nota**: Questi parametri sono ora messaggi (non più attributi) per permettere:
- Controllo real-time durante esecuzione
- Modulazione via LFO (implementata)
- Automazione e controllo OSC bidirezionale

---

## Esempi Pratici

### Esempio 1: Setup Base con LFO
```
// Crea ec2~ con 8 canali
[ec2~ @outputs 8 @buffer mysound]

// Imposta parametri base
[grainrate 40(
[duration 150(
[amplitude 0.6(

// Configura LFO1 per modulare filter frequency
[lfo1shape 0(        // Sine wave
[lfo1rate 0.5(       // 0.5 Hz
[lfo1polarity 0(     // Bipolar
[filterfreq_lfosource 1(   // Assign LFO1
[filterfreq_moddepth 0.7(  // 70% depth
```

### Esempio 2: Modulazione Multipla
```
// LFO1 → grainrate (slow variation)
[lfo1shape 0(
[lfo1rate 0.2(
[grainrate_lfosource 1(
[grainrate_moddepth 0.5(

// LFO2 → pan (auto-pan)
[lfo2shape 0(
[lfo2rate 2.0(
[pan_lfosource 2(
[pan_moddepth 0.8(

// LFO3 → playback (vibrato)
[lfo3shape 0(
[lfo3rate 5.0(
[playback_lfosource 3(
[playback_moddepth 0.2(
```

### Esempio 3: Disattivazione LFO
```
// Rimuovi assegnazione LFO da parametro
[grainrate_lfosource 0(  // 0 = none

// L'LFO continua a funzionare ma non modula più quel parametro
```

---

## Note Implementazione

1. **Attributi vs Messages**:
   - Attributi (@) configurano la struttura dell'oggetto (outlets, buffer, spatial allocation)
   - Messages controllano i parametri di sintesi in tempo reale

2. **LFO Always Active**:
   - Gli LFO sono sempre attivi in background
   - Consumano CPU minima (~0.1% per LFO)
   - Per "disattivare" un LFO: impostare `lfosource=0` per tutti i parametri

3. **Deviazioni vs LFO**:
   - Deviazioni: variazione casuale uniforme per ogni grano
   - LFO: modulazione periodica continua
   - Possono essere usati simultaneamente

4. **OSC Output**:
   - Tutti i 94 parametri sono trasmessi via OSC outlet (rightmost)
   - Formato odot-compatible (FullPacket)
   - Automatic transmission on parameter change

---

**Fine documento**
