// THIS DOES NOT WORK
{
    var freqs = Array.fill(100, { 20 * (10 ** (1/10 * (1 + 5.rand))) }); // 100 random frequencies between 20 Hz and 20kHz
    var gains = freqs.collect { |f| 
        var signal = SinOsc.ar(f, 0, 0.1); // Sine wave at each frequency
        var filteredSignal = BLowShelf.ar(signal, f, 0.8, 0.5); // Apply filter with a gain of 0.8 and cutoff at f
        // Calculate the gain at that frequency by comparing the magnitudes
        var originalMag = signal.abs;  // Absolute value of original sine wave
        var filteredMag = filteredSignal.abs; // Absolute value of filtered signal
        filteredMag.sum / originalMag.sum; // Divide the filtered magnitude by the original magnitude
    };
    
    // Plot the frequency vs gain (dB scale)
    Plot.kr(freqs, gains, 0, 100, "Frequency Response of BLowShelf Filter", "Frequency (Hz)", "Gain");
}.fork;
