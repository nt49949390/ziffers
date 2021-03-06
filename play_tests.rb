use_synth :piano


def testzplay
  # row row
  zplay("|:q.1.1|q1e2q.3|3e2q3e4|h.5|e888555333111|q5e4q3e2|h.1:|")
  # frere jacques
  zplay("|:q1231:|:q34h5:|@:e5654q31:|:q1_5^h1:@|", key: :e, scale: :major)
  # Same using fractions as note length / sleep
  zplay("|:1/4 1231:|:34 2/4 5:|@:1/8 5654 1/4 31:|:1 _5^ 2/4 1:@|", key: :e, scale: :major)
  # jericho
  zplay "|:q1_7^12&32&345h550;q4h440q5h550;&q34h54&321:|", key: :d, scale: :major
  # ode to joy
  zplay("|:q3345|5432|1123|;q32h2;q21h1:|q2231|2e34q31|2e34q32|q12h_5|^q3345|5432|1123|21h1|")
  # twinkle twinkle
  zplay("q115566h5q443322h1 *|: q554433h2 :|*")
  # Test transposing degrees
  zplay("s12345678987654321",{scale: "major_pentatonic"})
  # Numbered loops
  zplay("|:1234:3|616|:4321:3|")
  # Test negative degree
  zplay "-987654321+123456789", key: :b
end

def testinverseoffset
  in_thread do
    zplay "|:q.1.1|q1e2q.3|3e2q3e4|h.5|e888555333111|q5e4q3e2|h.1:|", inverse: 1, offset: -2
  end
  zplay "|:q.1.1|q1e2q.3|3e2q3e4|h.5|e888555333111|q5e4q3e2|h.1:|"
end

def testcontrolchars
  zplay("R3 Z0 123456789 Z1 000")
  with_synth :beep do
    zplay("R1 1234 R2 1234 R3 1234 R4 1234")
  end
end

def testslide
  with_synth :chiplead do
    zplay "|: ~ 91 ~ 61 :|"
    zplay "~0.1 1234"
    zplay " ~1 1234 "
    zplay("h3q323 ..q ~0.15 36 h5.3 ..q ~0.25 36 53 q ~0.25 3232222")
  end
end

def testsingledegrees
  (scale :gong).reflect.each do |k|
    [1,3,6].each do |d|
      zplay d, key: 40+k, scale: :blues_minor
      sleep 0.1
    end
  end
end

def testarraydegrees
  zplay zarray [4,4,3,3,2,2,3,3,4,4,3,3,2,2,3,3], key: :c, scale: :chromatic, sleep: 0.12
  zplay zarray((scale :gong).reflect.to_a),  key: 60, scale: :blues_minor
  zplay zarray([[1, 0.375], [1, 0.375], [1, 0.25], [2, 0.125], [3, 0.375], [3, 0.25], [2, 0.125], [3, 0.25], [4, 0.125], [5, 0.75], [8, 0.125], [8, 0.125], [8, 0.125], [5, 0.125], [5, 0.125], [5, 0.125], [3, 0.125], [3, 0.125], [3, 0.125], [1, 0.125], [1, 0.125], [1, 0.125], [5, 0.25], [4, 0.125], [3, 0.25], [2, 0.125], [1, 0.75]]), scale: :aeolian
  zplay zarray([1,2,4,5,6,7].zip(0.1.step(0.7,0.1).to_a))
end

def testchords
  # Chord synth test
  zplay("i ii iii iv v vi vii",{scale: "major", chordSleep: 0.25, chordSynth: :piano})
  zplay("|:iv 123 iii 234 ii 432 i 123:|",{chordKey: :e3, key: :e4, scale: "mixolydian"})
  zplay("|:iv 123 iii 234 ii 432 i 123:|",{chordKey: "f", key: "e", scale: "mixolydian"})
  zplay("|: i^major7 vi^dim ii^m7 v^dim7 :|", chordSleep: 0.5, scale: :aeolian)
  zplay("%-2 vii %-1 iii vi %0 ii v %1 i iv", chordSleep: 0.5)
  zplay "G1232 |: i^7 :3||: %-1 iv^dim :3|"
  zplay "Gq12e^3212 |: i^7 :3||: %-1 iv^dim7 :3|", key: :d4, scale: :mixolydian
  zplay "N3 G987654321 %-1 ii^m9 v^add13 %2 i^maj9 %-2 vi^m9", key: :e3
  zplay "N2 G(1,6,6) i 0 v 0 vi"
  zplay "N2 G(1..6) i 0 v 0 vi"
end

def testrandom
  zplay "(1..7?3)"
  zplay "(1..7?3*3)"
  zplay "(1,7*10)"
  zplay "(100,200:3)"
  zplay "(2000,5000;wqqee)"
  zplay "(1..9;wqqeee)"
  zplay "(1..9;wqqeee~)"
  zplay "(10..1000+100;e~)"
  zplay "Z0.? ???? Z[0.25,0.5,1] ???? Z(0.1,0.5) ????"
  with_synth :beep do
    3.times do zplay("ii 554e56 iv 12323456 i q 334e56 v [q7765,e75645342,q????]") end
    zplay("$ P? C0.? (1,2) P? C0.? (2,3) P? C0.? (3,4) $ [1,2,3] P? [4,5,6] P? [4,5,6] ~ ????????? ")
  end
end

def testzsample
  zplay("|:q1231:|:q34h5:|@:e5654q31:|:q1_5^h1:@|", {hz: 4, sample:  :ambi_drone, key: "c1", sustain: 0.25})
  zplay("|:q1231:|:q34h5:|@:e5654q31:|:q1_5^h1:@|", {hz: 4, sample:  :ambi_drone, key: "c1", sustain: 0.25}, rateBased: true)
  zplay("h3q323 ..q ~0.15 36 h5.3 ..q ~0.25 36 53 q ~0.25 3232222",{sample: :ambi_piano, sustain: 0.25, key: "c", amp: 3})
  zplay("h3q323 q ~0.1 3666 h5.3 q ~0.25 3666 53 q ~0.2 3232222",{sample: :ambi_piano, sustain: 0.25, key: "c", amp: 3})
  zplay("q115566h5q443322h1 *|: q554433h2 :|*", sample: :ambi_glass_rub, rate: 2.1, amp: 0.2)
end

def testzmidi
  zmidi "|: q 53 53 53 57 h 60 q 53 53 ; h 55 q 60 60 h 57 q 53 53 ; q 55 55 57 55 w 53 :|"
end

def testbinaural
  with_synth :beep do zbin("q12345678") end
  with_synth :beep do zbin("q12345678",{hz:10}) end
  zbin("q12345678",{sustain: 0.25, sample: :ambi_glass_rub})
  zbin("q12345678",{hz:10, sustain: 0.25, sample: :ambi_glass_rub})
  zbin("q12345678",{sustain: 0.25, sample: :ambi_glass_rub}, rateBased: true)
  zbin("q12345678",{hz:10, sustain: 0.25, sample: :ambi_glass_rub}, rateBased: true)
end

def testzdrums
  zdrums("1 2 3 4", )
  zdrums("12345687654321", synth: :sine)
end

def testlsystem
  with_synth :beep do
    zplay "1", rules: {"1"=>"13","3"=>"6431"}, gen: 3
    zplay "?", rules: {"?"=>"q?e???q?"}, gen: 2, scale: :major_pentatonic
    zplay "1", rules: {/[1-7]/=>"(1..7;qeqqe)"}, gen: 2, scale: :gong
    zplay "1", rules: {/(3)1/=>"q'$1+1'1'$2+2'",/[1-7]/=>"e313"}, gen: 4
    zplay "123", rules: {/[1-9]/=>"'$*1' [e,q] '$*2'"}, gen: 4
  end
end

def testpreparse
  # Parse degrees from c and play in e
  zplay(zpreparse("|:1/4 cdec:|:ef 2/4 g:|@:1/8 gagf 1/4 ec:|:c _g^ 2/4 c:@|",:c),key: :e)
  # same using Z escape char and parseKey param
  zplay("|:Z0.25 cdec:|:ef Z0.5 g:|@:Z0.125 gagf Z0.25 ec:|:c _g^ Z0.5 c:@|", parsekey: :c, key: :e)
end


testzplay
testchords
testinverseoffset
testcontrolchars
testrandom
testslide
testsingledegrees
testzsample
testzmidi

# These require ziffers_utils.rb
testlsystem
testpreparse
testarraydegrees
testbinaural
testzdrums
