set Riders;
set Tricks;

param canDo{Riders, Tricks} binary;
param chance_of_injury{Riders, Tricks} >= 0;
param value{Tricks} >= 0;
param execution_time{Tricks} >= 0;

param time;
param injury_treshold{Riders} >=0;

var doTrick{Riders, Tricks} binary;

s.t. OnlyDoIfCan{r in Riders, t in Tricks: canDo[r, t] <> 1}:
    doTrick[r, t] = 0;

s.t. AllTricksAtLeastOnce{r in Riders}:
    sum{t in Tricks} doTrick[r, t] >= 1;

s.t. TimeConstraint{r in Riders}: 
        sum{t in Tricks} doTrick[r, t] * execution_time[t] <= time;

s.t. InjuryConstraint{r in Riders}: 
       sum{t in Tricks} doTrick[r, t] * chance_of_injury[r, t] <= injury_treshold[r];


maximize Points:
    sum{r in Riders, t in Tricks} doTrick[r, t] * value[t];

solve;

printf "Osszpontszam: %d \n", Points;

for {r in Riders} {

    printf "%s \n", r;
    for{t in Tricks: doTrick[r, t]}{
        printf "  -> %s \n", t;
    }
   
}


end;

