set Tricks;
set Elements;
param value{Tricks, Elements};
param execution_time{Tricks, Elements};
param chance_of_injury{Tricks,Elements};
param time_of_a_round >=0;
param treshold >=0;

var do{Tricks, Elements} binary;

s.t. TimeConstraint{e in Elements}:
    sum{t in Tricks} do[t, e] * execution_time[t, e] <= time_of_a_round;

s.t. InjuryConstraint {e in Elements}:
    sum{t in Tricks} do[t, e] * chance_of_injury[t, e] <= treshold;

maximize Points: sum{t in Tricks, e in Elements} do[t,e] * value[t,e];