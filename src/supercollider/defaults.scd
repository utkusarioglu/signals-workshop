var dict = Dictionary();

// d[\synth] = [0.8, 0, 0, 0, 0.01, 1, 0.1, 0.1];
// dict[\reverb] = [0.3, 0.5, 0.5, 0.5];

dict[\synth] = [
  (
    name: "Pulse Vol",
    default: 0.8, 
  ),
  (
    name: "Pulse Spread",
    default: 0,
  ),
  (
    name: "Saw Vol",
    default: 0,
  ),
  (
    name: "Saw Spread",
    default: 0
  ),
  (
    name: "Atk",
    default: 0.01
  ),
  (
    name: "Dec",
    default: 1
  ),
  (
    name: "Slev",
    default: 0.1
  ),
  (
    name: "Rel",
    default: 0.1
  )
];

dict[\reverb] = [
  (
    name: "Mix",
    default: 0.3
  ),
  (
    name: "Room",
    default: 0.5
  ),
  (
    name: "Damp",
    default: 0.6
  ),
  (
    name: "Amp",
    default: 0.5
  )
];

dict;
