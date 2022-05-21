%%%%%       SARA SUJOVA                         %%%%%
%%%%%       PROJEKT_1 VBC 2021                  %%%%%
%%%%%       GENETIC ALG. & SIMULOVANE ZIHANI    %%%%%

%% SECTION 1: nacteni parametru dimenze, pocet RUN, limit pro fitness a velikost populace pro GA algoritmus, nastaveni vychozich optimoptions
% pro oba algoritmy

clear all
clc

dim = 50;
RUNS = 1000;
fitness_limit = 0.1;
population_size = 200;

options_sa = optimoptions('simulannealbnd');
options_ga = optimoptions('ga', 'fitnesslimit', fitness_limit, 'PopulationSize', population_size, 'SelectionFcn', @selectionremainder);

%% SECTION 2: DeJong 5

fun = @(x) dejong5fcn(x);

x_0 = zeros(dim, 1)' + 15; % start
low_limit = zeros(dim, 1)' - 65.536; % spodni ohraniceni
up_limit = zeros(dim, 1)' + 65.536; % horni ohraniceni

%zadefinovani nejlepsich hodnot, inf aby slo hledat minimum, u souradnic
%neni podstatne
best_value_sa = inf;
best_value_ga = inf;
best_coors_sa = 0;
best_coors_ga = 0;

tic
for i=1:RUNS
    
    % zapis seedu podle
    % https://www.mathworks.com/help/gads/options-in-genetic-algorithm.html
    % kvuli zpetnemu generovani nejlepsiho RUN
    
    randseed = round(abs(randn)*1000);
    rng(randseed);
    
    %run genetaku
    [x,fval_g] = ga(fun,dim,[],[],[],[],low_limit,up_limit,[],options_ga);

    %porovnani a zapis hodnot event. nejlepsiho RUN vc. odpovidajiciho
    %seedu
    if best_value_ga > fval_g
       best_value_ga = fval_g;
       best_coors_ga = x;
       best_seed_ga_j = randseed;
    end
end
toc

tic
for i=1:RUNS

    randseed = round(abs(randn)*1000);
    rng(randseed);

    %run pro SA
    [x,fval_s] = simulannealbnd(fun,x_0,low_limit,up_limit,options_sa);

    %porovnani a zapis hodnot event. nejlepsiho RUN vc. odpovidajiciho
    %seedu
    if best_value_sa > fval_s 
       best_value_sa = fval_s;
       best_coors_sa = x;
       best_seed_sa_j = randseed;
    end
end
toc

%% SECTION 3: Vykresleni nejlepsich prubehu pomoci zapsaneho seedu

rng(best_seed_ga_j(end));
options_plot_ga = optimoptions('ga','PlotFcn', @gaplotbestf,'FitnessLimit',fitness_limit, 'PopulationSize', population_size, 'SelectionFcn', @selectiontournament, 'CreationFcn', @gacreationuniform);
[x,fval,exitflag,output,population,score] = ga(fun,dim,[],[],[],[],low_limit,up_limit,[],options_plot_ga)    

rng(best_seed_sa_j(end));
options_plot_sa = optimoptions('simulannealbnd','PlotFcn', @saplotbestf);
[x,fval,exitflag,output] = simulannealbnd(fun,x_0,low_limit,up_limit,options_plot_sa)

%% SECTION 4: Rastrigin - stejny postup jak u SECTION 2


fun = @(x) rastriginsfcn(x);

x_0 = zeros(dim, 1)' + 2; 
low_limit = zeros(dim, 1)' - 5; 
up_limit = zeros(dim, 1)' + 5; 

best_value_sa = inf;
best_value_ga = inf;
best_coors_sa = 0;
best_coors_ga = 0;

tic
for i=1:RUNS

    randseed_rast = round(abs(randn)*1000);
    rng(randseed_rast);

    [x,fval_g] = ga(fun,dim,[],[],[],[],low_limit,up_limit,[],options_ga);

    if best_value_ga > fval_g
           best_value_ga = fval_g;
           best_coors_ga = x;
           best_seed_ga_r = randseed_rast;
    end

end
toc

tic
for i=1:RUNS

    randseed_rast = round(abs(randn)*1000);
    rng(randseed_rast);

    [x,fval_s] = simulannealbnd(fun,x_0,low_limit,up_limit,options_sa);

    if best_value_sa > fval_s 
       best_value_sa = fval_s;
       best_coors_sa = x;
       best_seed_sa_r = randseed_rast;
    end

end
 toc       
%% SECTION 5: Vykresleni nejlepsich prubehu pomoci zapsaneho seedu 

rng(best_seed_ga_r(end));
options_plot_ga = optimoptions('ga','PlotFcn', @gaplotbestf,'FitnessLimit',fitness_limit,'PopulationSize', population_size, 'SelectionFcn', @selectiontournament, 'CreationFcn', @gacreationuniform);
[x,fval,exitflag,output,population,score] = ga(fun,dim,[],[],[],[],low_limit,up_limit,[],options_plot_ga)    

rng(best_seed_sa_r);
options_plot_sa = optimoptions('simulannealbnd','PlotFcn', @saplotbestf);
[x,fval,exitflag,output] = simulannealbnd(fun,x_0,low_limit,up_limit,options_plot_sa)

%% SECTION 6: Rosenbrock - stejny postup jak u SECTION 2

tic
fun = @(x) rosenbrockfcn(x);

x_0 = zeros(dim, 1)' + 5; % start point
low_limit = zeros(dim, 1)' - 5; % min bounds
up_limit = zeros(dim, 1)' + 10; % max bounds

best_value_sa = inf;
best_value_ga = inf;
best_coors_sa = 0;
best_coors_ga = 0;

tic
for i=1:RUNS

    randseed = round(abs(randn)*1000);
    rng(randseed);

    [x,fval_g] = ga(fun,dim,[],[],[],[],low_limit,up_limit,[],options_ga);

    if best_value_ga > fval_g
       best_value_ga = fval_g;
       best_coors_ga = x;
       best_seed_ga_ro = randseed;
    end

end
toc

tic
for i=1:RUNS

    randseed = round(abs(randn)*1000);
    rng(randseed);

    [x,fval_s] = simulannealbnd(fun,x_0,low_limit,up_limit,options_sa);

    if best_value_sa > fval_s 
       best_value_sa = fval_s;
       best_coors_sa = x;
       best_seed_sa_ro = randseed;
    end

end
toc
        
%% SECTION 7: Vykresleni nejlepsich prubehu pomoci zapsaneho seedu 
% 
rng(best_seed_ga_ro);
options_plot_ga = optimoptions('ga','PlotFcn', @gaplotbestf,'FitnessLimit',fitness_limit,'PopulationSize', population_size, 'SelectionFcn', @selectionremainder);
[x,fval,exitflag,output,population,score] = ga(fun,dim,[],[],[],[],low_limit,up_limit,[],options_plot_ga)   

rng(best_seed_sa_ro);
options_plot_sa = optimoptions('simulannealbnd','PlotFcn', @saplotbestf);
[x,fval,exitflag,output] = simulannealbnd(fun,x_0,low_limit,up_limit,options_plot_sa)


%% SECTION 8: Rosenbrock fcn

function result = rosenbrockfcn(x)
    [rows, columns] = size(x);
    result = zeros(rows, 1);
    for i=1:rows
       for j=1:(columns - 1)
          result(i) = result(i) + 100*(x(i, j+1) - x(i,j)^2)^2 + (x(i,j) - 1)^2; 
       end
    end
end



