Load.temp("osc/coordinates");

// Task {
// Pwsh.async("docker", "-c u-Boulanger exec -it docker-signals-workshop-1 bash -c 'cd /utkusarioglu-com/workshops/signals-workshop/ && ./run.sh'").do(_.postln); "";
Pwsh.async("docker", "-c u-Boulanger exec -it docker-signals-workshop-1 bash -c /utkusarioglu-com/workshops/signals-workshop/run.sh");
// Pwsh.async("docker", "-c u-Boulanger exec -it docker-signals-workshop-1 bash -c ls").do(_.postln); "";
//   "";
// }.start;
