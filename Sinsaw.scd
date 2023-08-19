(
SynthDef("Sinsaw", {arg out = 0, freq= Prand (0,600), pan = 0, rate=1, amp=0.2, gate=1;
	var acco, snd;
	acco = Env.adsr(
		attackTime:0.2,
		decayTime:0.5,
		sustainLevel:0.1,
		releaseTime:0.5,
		peakLevel:2,
		curve:-4.0,
		bias:0).kr(gate: gate, doneAction:2);
	snd = BRF.ar(
		in: Saw.ar(
			freq: freq,
			feedback:0.2,
	));
	snd = snd*acco;
	snd = Mix.ar(snd);
	snd = BPF.ar(
		in: Saw.ar(freq: freq));
		Out.ar(0,Pan2.ar (snd, pan, amp));
}).add;
)

(
Synth(\Sinsaw);
)

// FORK //

(
{
a = Pbind(
	TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \Sinsaw,
	\degree, Pwhite(0, 30,inf),
	\dur, 0.2,
	\mul, 1,
	\amp, 0.3,
	// \legato, 1,
	\ctranspose, 1.0
).play;

4.wait;

b = Pbind(
    TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \eerie,
	\degree, Prand([0,-1,-2,-3,-4,-5,-6,-7],inf),
	\dur, 0.2,
	\mul, 1.5,
	\amp, 0.4,
	\legato, 0.7,
	\ctranspose, 0.5
).play;

8.wait;
b.stop;

c = Pbind(
	TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \Sinsaw,
	\degree, Pwhite (-15, 0,inf),
	\dur, 0.2 ,
	\mul, 1,
	\amp, 0.4,
	\legato, 1,
	\ctranspose, 0.1
	).play;

8.wait;

d = Pbind(
    TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \eerie,
	\degree, Prand([0,-1,-2,-3,-4,-5,-6,-7],inf),
	\dur, 0.2,
	\mul, 1.5,
	\amp, 0.4,
	\legato, 0.7,
	\ctranspose, 0.5
).play;
d.stop;


}.fork;
)



{SinOsc.ar ([100,200,300])}.scope.play;
















