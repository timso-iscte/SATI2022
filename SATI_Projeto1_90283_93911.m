%Variables initialized with the probability of success between nodes

n_Trials = 0;
p_PT_VR = 0.92;                     
p_VR_GR = 0.88;
p_PT_VS = 0.93;
p_VS_GR = 0.85;
p_PT_AV = 0.95;
p_AV_CMB = 0.95;
p_CMB_GR = 0.90;
p_VS_CMB = 0.93;

%Arrays to save the state of the connection between nodes ( success = 1 /
%failure = 0 )

PT_VR_Working = zeros(n_Trials, 1); 
VR_GR_Working = zeros(n_Trials, 1);
PT_VS_Working = zeros(n_Trials, 1);
VS_GR_Working = zeros(n_Trials, 1);
PT_AV_Working = zeros(n_Trials, 1);
AV_CMB_Working = zeros(n_Trials, 1);
CMB_GR_Working = zeros(n_Trials, 1);
VS_CMB_Working = zeros(n_Trials, 1);

%Arrays to save the state of the connection of a path
%(success - 1 / failure - 0)

path1_working = zeros(n_Trials, 1); 
path2_working = zeros(n_Trials, 1);
path3_working = zeros(n_Trials, 1);
path4_working = zeros(n_Trials, 1);

%Arrays to save the state of the connection of a mesh
%(success - 1 / failure - 0)

cenario1 = zeros(n_Trials, 1);      
cenario2 = zeros(n_Trials, 1);
cenario3 = zeros(n_Trials, 1);      
cenario4 = zeros(n_Trials, 1);

%Auxiliary arrays to aid with ploting

p1_Vector = [];                     
p2_Vector = [];
p3_Vector = [];
p4_Vector = [];
t_Vector = [];



for n_Trials = [100, 1000, 5000, 10000, 50000, 100000, 500000, 1000000]     
    
   %Variables to save the number of successful transmissions
    
    temp1 = 0;  
    temp2 = 0;
    temp3 = 0;
    temp4 = 0;

for i = 1:n_Trials
    
%if rand returns a value lower than the variable, the connetion between
%nodes is successful

    if rand(1,1) < p_PT_VR          
        PT_VR_Working(i, 1) = 1;    
    else                            
        PT_VR_Working(i, 1) = 0;
    end
    
    if rand(1,1) < p_VR_GR
        VR_GR_Working(i, 1) = 1;
    else
        VR_GR_Working(i, 1) = 0;
    end
   
    if rand(1,1) < p_PT_VS
        PT_VS_Working(i, 1) = 1;
    else
        PT_VS_Working(i, 1) = 0;
    end
    
    if rand(1,1) < p_VS_GR
        VS_GR_Working(i, 1) = 1;
    else
        VS_GR_Working(i, 1) = 0;
    end
   
    if rand(1, 1) < p_PT_AV
        PT_AV_Working(i, 1) = 1;
    else
        PT_AV_Working(i, 1) = 0;
    end
    
    if rand(1, 1) < p_AV_CMB
        AV_CMB_Working(i, 1) = 1;
    else
        AV_CMB_Working(i, 1) = 0;
    end
    
    if rand(1, 1) < p_CMB_GR
        CMB_GR_Working(i, 1) = 1;
    else
        CMB_GR_Working(i, 1) = 0;
    end
    
    if rand(1, 1) < p_VS_CMB
        VS_CMB_Working(i, 1) = 1;
    else
        VS_CMB_Working(i, 1) = 0;
    end

    %Below are the logical operations to calculate if the transmission is
    %sucessful
    
    path1_working(i, 1) = PT_VR_Working(i, 1) * VR_GR_Working(i, 1);
    
    path2_working(i, 1) = PT_VS_Working(i, 1) * VS_GR_Working(i, 1);
    
    path3_working(i, 1) = PT_AV_Working(i, 1) * AV_CMB_Working(i, 1) * CMB_GR_Working(i, 1);
    
    path4_working(i, 1) = PT_VS_Working(i, 1) * VS_CMB_Working(i, 1) * CMB_GR_Working(i, 1);
    
    cenario1(i, 1) = path1_working(i, 1);
    
    cenario2(i, 1) = path1_working(i, 1) + path2_working(i, 1) - ( path1_working(i, 1) * path2_working(i, 1) );
    
    cenario3(i, 1) = cenario2(i, 1) + path3_working(i, 1) - ( cenario2(i, 1) * path3_working(i, 1) );
    
    cenario4(i, 1) = cenario3(i, 1) + path4_working(i, 1) - ( cenario3(i, 1) * path4_working(i, 1) );
    
    temp1 = temp1 + cenario1(i, 1);
    temp2 = temp2 + cenario2(i, 1);
    temp3 = temp3 + cenario3(i, 1);
    temp4 = temp4 + cenario4(i, 1);
    
    
end


    number_comm_failure1 = n_Trials - temp1;
    prob_comm_working1 = temp1 / n_Trials;
    prob_comm_failure1 = number_comm_failure1 / n_Trials;
    
    number_comm_failure2 = n_Trials - temp2;
    prob_comm_working2 = temp2 / n_Trials;
    prob_comm_failure2 = number_comm_failure2 / n_Trials;
    
    number_comm_failure3 = n_Trials - temp3;
    prob_comm_working3 = temp3 / n_Trials;
    prob_comm_failure3 = number_comm_failure3 / n_Trials;
    
    number_comm_failure4 = n_Trials - temp4;
    prob_comm_working4 = temp4 / n_Trials;
    prob_comm_failure4 = number_comm_failure4 / n_Trials;
    
    t_Vector(end + 1) = n_Trials

    p1_Vector(end + 1) = prob_comm_working1
    
    p2_Vector(end + 1) = prob_comm_working2
   
    p3_Vector(end + 1) = prob_comm_working3
    
    p4_Vector(end + 1) = prob_comm_working4
    
end

%plots

t_Vector_Modified = 1:length(t_Vector);

t = tiledlayout(2,2);
title(t, 'Cenários')
xlabel(t, 'number of attempts');
ylabel(t, 'probability of the path working');

nexttile
bar(t_Vector_Modified, p1_Vector, 0.4, 'BarWidth', 1)
xticklabels(gca,{'100', '1000', '5000', '10000', '50000', '100000', '500000', '1000000'});
yline(0.8092)
axis([0 inf 0.75 0.85])
title('Cenário 1')


nexttile
bar(t_Vector_Modified, p2_Vector, 0.4, 'BarWidth', 1)
xticklabels(gca,{'100', '1000', '5000', '10000', '50000', '100000', '500000', '1000000'});
yline(0.9601)
axis([0 inf 0.90 1])
title('Cenário 2')


nexttile
bar(t_Vector_Modified, p3_Vector, 0.4, 'BarWidth', 1)
xticklabels(gca,{'100', '1000', '5000', '10000', '50000', '100000', '500000', '1000000'});
yline(0.9925)
axis([0 inf 0.90 1])
title('Cenário 3')


nexttile
bar(t_Vector_Modified, p4_Vector, 0.4, 'BarWidth', 1)
xticklabels(gca,{'100', '1000', '5000', '10000', '50000', '100000', '500000', '1000000'});
yline(0.9983)
axis([0 inf 0.90 1])
title('Cenário 4')