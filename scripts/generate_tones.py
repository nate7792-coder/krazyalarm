#!/usr/bin/env python3
import math
import struct
import wave
from pathlib import Path

RATE = 44_100
DEST = Path(__file__).resolve().parents[1] / "KrazyAlarm" / "Resources" / "Sounds"


def render(name, notes, pulse=0.34, gap=0.08, volume=0.42):
    DEST.mkdir(parents=True, exist_ok=True)
    samples = []
    for frequency, duration in notes:
        count = int(RATE * duration)
        attack = max(1, int(RATE * 0.025))
        release = max(1, int(RATE * 0.09))
        for i in range(count):
            envelope = min(1.0, i / attack, (count - i) / release)
            fundamental = math.sin(2 * math.pi * frequency * i / RATE)
            harmonic = 0.24 * math.sin(2 * math.pi * frequency * 2 * i / RATE)
            tremolo = 0.82 + 0.18 * math.sin(2 * math.pi * pulse * i / RATE)
            value = int(32767 * volume * envelope * tremolo * (fundamental + harmonic) / 1.24)
            samples.append(max(-32767, min(32767, value)))
        samples.extend([0] * int(RATE * gap))

    with wave.open(str(DEST / f"{name}.wav"), "wb") as output:
        output.setnchannels(1)
        output.setsampwidth(2)
        output.setframerate(RATE)
        output.writeframes(b"".join(struct.pack("<h", sample) for sample in samples))


TONES = {
    "CrimsonBell": [(523.25, .55), (659.25, .55), (783.99, .8)] * 2,
    "GuardianPulse": [(220, .30), (329.63, .30), (440, .48)] * 3,
    "IronChime": [(293.66, .48), (440, .48), (587.33, .68)] * 2,
    "DawnRise": [(261.63, .30), (329.63, .30), (392, .30), (523.25, .7)] * 2,
    "NightSignal": [(392, .38), (392, .38), (587.33, .62)] * 3,
    "Forge": [(146.83, .38), (220, .38), (293.66, .62)] * 3,
    "KrazyBeep": [(659.25, .16), (783.99, .16), (987.77, .22), (783.99, .16)] * 4,
    "SoftWake": [(261.63, .62), (329.63, .62), (392, .9)] * 2,
}

for tone_name, tone_notes in TONES.items():
    render(tone_name, tone_notes)

print(f"Generated {len(TONES)} tones in {DEST}")

