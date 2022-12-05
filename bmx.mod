set Tricks;
set Elements;
param Value{Tricks, Elements};
param ExecutionTime{Tricks, Elements};
param ChanceOfInjury{Tricks,Elements};
param TimeOfRound >=0;
param Treshold >=0;

var Do{Tricks, Elements} binary;

s.t. TimeConstraint{e in Elements}:
    sum{t in Tricks} Do[t, e] * ExecutionTime[t, e] <= TimeOfRound;

s.t. InjuryConstraint {e in Elements}:
    sum{t in Tricks} Do[t, e] * ChanceOfInjury[t, e] <= Treshold;

maximize Points: sum{t in Tricks, e in Elements} Do[t,e] * Value[t,e];

solve;

printf 'Osszpontszam: %d \n', Points;
printf '---------------\n';
printf '|Elem | Trukk | \n';
printf '---------------\n';
for {t in Tricks, e in Elements: Do[t, e]} {
    printf '%s - %s \n',e,t;
}

end;